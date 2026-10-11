import SwiftUI
import FirebaseAuth
import FirebaseFirestore

private struct PULSEPost: Identifiable {
    let id: String
    let authorID: String
    let authorName: String
    let username: String
    let text: String
    let createdAt: Date
    let isPrivate: Bool

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard
            let authorID = data["authorID"] as? String,
            let authorName = data["authorName"] as? String,
            let username = data["username"] as? String,
            let text = data["text"] as? String
        else { return nil }

        self.id = document.documentID
        self.authorID = authorID
        self.authorName = authorName
        self.username = username
        self.text = text
        self.createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
        self.isPrivate = data["isPrivate"] as? Bool ?? false
    }
}

private enum PULSEStyle {
    static let blue = Color(red: 0.25, green: 0.48, blue: 0.96)
    static let violet = Color(red: 0.48, green: 0.32, blue: 0.92)
    static let divider = Color.primary.opacity(0.09)
}

struct PULSEHomeView: View {
    let user: User

    @State private var posts: [PULSEPost] = []
    @State private var displayName = ""
    @State private var username = ""
    @State private var bio = ""
    @State private var isAccountPrivate = false
    @State private var showEditProfile = false
    @State private var showDeleteAccountConfirmation = false
    @State private var isLoading = true
    @State private var loadError = ""
    @State private var showComposer = false
    @State private var selectedTab = 0
    @State private var feedListeners: [ListenerRegistration] = []
    @State private var publicPosts: [PULSEPost] = []
    @State private var ownPrivatePosts: [PULSEPost] = []

    private let db = Firestore.firestore()

    var body: some View {
        TabView(selection: $selectedTab) {
            feedScreen
                .tabItem { Image(systemName: "house") }
                .tag(0)

            profileScreen
                .tabItem { Image(systemName: "person.crop.circle") }
                .tag(1)
        }
        .tint(PULSEStyle.blue)
        .task { await loadProfile() }
        .onAppear(perform: startFeedListener)
        .onDisappear {
            feedListeners.forEach { $0.remove() }
            feedListeners.removeAll()
        }
        .sheet(isPresented: $showEditProfile) {
            PULSEEditProfileView(
                user: user,
                displayName: displayName,
                bio: bio,
                isPrivate: isAccountPrivate,
                onSave: { newName, newBio, makePrivate in
                    Task { await saveProfile(name: newName, bio: newBio, isPrivate: makePrivate) }
                },
                onDeleteAccount: { showDeleteAccountConfirmation = true }
            )
        }
        .confirmationDialog("Delete your PULSE account?", isPresented: $showDeleteAccountConfirmation, titleVisibility: .visible) {
            Button("Delete account permanently", role: .destructive) {
                Task { await deleteAccount() }
            }
        } message: {
            Text("Your profile and posts will be deleted. This cannot be undone.")
        }
        .sheet(isPresented: $showComposer) {
            PULSEComposerView(
                user: user,
                displayName: displayName.isEmpty ? (user.displayName ?? "PULSE user") : displayName,
                username: username
            )
        }
    }

    private var feedScreen: some View {
        NavigationStack {
            Group {
                if isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                        Text("Loading your feed…")
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !loadError.isEmpty && posts.isEmpty {
                    ContentUnavailableView(
                        "Couldn't load PULSE",
                        systemImage: "wifi.exclamationmark",
                        description: Text(loadError)
                    )
                } else if posts.isEmpty {
                    ContentUnavailableView {
                        Label("Your feed starts here", systemImage: "waveform.path")
                    } description: {
                        Text("Share your first thought. Posts from real PULSE accounts will appear here as they're published.")
                    } actions: {
                        Button {
                            showComposer = true
                        } label: {
                            Label("Write a post", systemImage: "square.and.pencil")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(posts) { post in
                                PULSEPostRow(post: post, currentUserID: user.uid, currentDisplayName: resolvedDisplayName, currentUsername: username, onPostChanged: refreshPostLists)
                                Rectangle()
                                    .fill(PULSEStyle.divider)
                                    .frame(height: 1)
                                    .padding(.leading, 72)
                            }
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 24)
                    }
                    .refreshable { await refreshFeed() }
                }
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("PULSE")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showComposer = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .accessibilityLabel("Write a post")
                }
            }
        }
    }

    private var profileScreen: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Profile cover banner: edge-to-edge, not a card.
                    ZStack(alignment: .bottomLeading) {
                        PULSEAvatarPalette.color(for: resolvedDisplayName)
                    }
                    .frame(height: 176)
                    .clipped()

                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .bottom) {
                            PULSEAvatar(name: resolvedDisplayName, size: 88)
                                .overlay(Circle().stroke(Color(uiColor: .systemBackground), lineWidth: 5))
                                .offset(y: -34)
                                .padding(.bottom, -34)

                            Spacer()

                            HStack(spacing: 8) {
                                Button {
                                    showEditProfile = true
                                } label: {
                                    Text("Edit profile")
                                        .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                        .padding(.horizontal, 13)
                                        .padding(.vertical, 9)
                                        .overlay(Capsule().stroke(PULSEStyle.divider, lineWidth: 1))
                                }
                                .buttonStyle(.plain)

                                Menu {
                                    Button(role: .destructive) {
                                        do {
                                            try PULSEBackend.shared.signOut()
                                        } catch {
                                            loadError = error.localizedDescription
                                        }
                                    } label: {
                                        Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 15, weight: .semibold))
                                        .frame(width: 36, height: 36)
                                        .overlay(Circle().stroke(PULSEStyle.divider, lineWidth: 1))
                                }
                            }
                            .padding(.top, 12)
                        }

                        Text(resolvedDisplayName)
                            .font(.custom("PlusJakartaSans-Bold", size: 23))
                            .foregroundStyle(.primary)
                            .padding(.top, 12)

                        Text(username.isEmpty ? (user.email ?? "") : "@\(username)")
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(.secondary)
                            .padding(.top, 3)

                        if !bio.isEmpty {
                            Text(bio)
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.primary.opacity(0.85))
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top, 10)
                        }

                        if isAccountPrivate {
                            Label("Private account", systemImage: "lock.fill")
                                .font(.custom("PlusJakartaSans-Medium", size: 12))
                                .foregroundStyle(.secondary)
                                .padding(.top, 10)
                        }

                        HStack(spacing: 22) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("\(posts.filter { $0.authorID == user.uid }.count)")
                                    .font(.custom("PlusJakartaSans-Bold", size: 18))
                                    .foregroundStyle(.primary)
                                Text("Posts")
                                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                                    .foregroundStyle(.secondary)
                            }

                            VStack(alignment: .leading, spacing: 3) {
                                Text("—")
                                    .font(.custom("PlusJakartaSans-Bold", size: 18))
                                    .foregroundStyle(.primary)
                                Text("Followers")
                                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                                    .foregroundStyle(.secondary)
                            }

                            VStack(alignment: .leading, spacing: 3) {
                                Text("—")
                                    .font(.custom("PlusJakartaSans-Bold", size: 18))
                                    .foregroundStyle(.primary)
                                Text("Following")
                                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.top, 22)

                        Rectangle()
                            .fill(PULSEStyle.divider)
                            .frame(height: 1)
                            .padding(.top, 24)

                        HStack {
                            Text("Posts")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                                .foregroundStyle(.secondary)
                            Spacer()
                            Image(systemName: "text.alignleft")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 16)

                        let ownPosts = posts.filter { $0.authorID == user.uid }
                        if ownPosts.isEmpty {
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Your story starts here.")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                                Text("The posts you publish will appear here.")
                                    .font(.custom("PlusJakartaSans-Regular", size: 13))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 18)
                        } else {
                            ForEach(ownPosts) { post in
                                PULSEPostRow(post: post, currentUserID: user.uid, currentDisplayName: resolvedDisplayName, currentUsername: username, isOwnPost: true, onPostChanged: refreshPostLists)
                                Rectangle()
                                    .fill(PULSEStyle.divider)
                                    .frame(height: 1)
                            }
                        }

                        if !loadError.isEmpty {
                            Text(loadError)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 12)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
            .background(Color(uiColor: .systemBackground))
            .ignoresSafeArea(edges: .top)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var resolvedDisplayName: String {
        let name = displayName.isEmpty ? (user.displayName ?? "") : displayName
        return name.isEmpty ? "Your profile" : name
    }

    private func loadProfile() async {
        do {
            let snapshot = try await db.collection("users").document(user.uid).getDocument()
            displayName = snapshot.data()?["displayName"] as? String ?? user.displayName ?? ""
            username = snapshot.data()?["username"] as? String ?? ""
            bio = snapshot.data()?["bio"] as? String ?? ""
            isAccountPrivate = snapshot.data()?["isPrivate"] as? Bool ?? false
        } catch {
            displayName = user.displayName ?? ""
            loadError = error.localizedDescription
        }
    }

    private func startFeedListener() {
        guard feedListeners.isEmpty else { return }
        let publicListener = db.collection("posts")
            .whereField("isPrivate", isEqualTo: false)
            .limit(to: 100)
            .addSnapshotListener { snapshot, error in
                if let error {
                    loadError = error.localizedDescription
                    isLoading = false
                    return
                }
                publicPosts = snapshot?.documents.compactMap(PULSEPost.init(document:)) ?? []
                refreshPostLists()
                loadError = ""
                isLoading = false
            }
        let ownListener = db.collection("posts")
            .whereField("authorID", isEqualTo: user.uid)
            .limit(to: 100)
            .addSnapshotListener { snapshot, error in
                if let error {
                    loadError = error.localizedDescription
                    isLoading = false
                    return
                }
                ownPrivatePosts = snapshot?.documents.compactMap(PULSEPost.init(document:)) ?? []
                refreshPostLists()
                loadError = ""
                isLoading = false
            }
        feedListeners = [publicListener, ownListener]
    }

    private func refreshPostLists() {
        var unique: [String: PULSEPost] = [:]
        (publicPosts + ownPrivatePosts).forEach { unique[$0.id] = $0 }
        posts = unique.values.sorted { $0.createdAt > $1.createdAt }
    }

    private func refreshFeed() async {
        do {
            async let publicSnapshot = db.collection("posts")
                .whereField("isPrivate", isEqualTo: false)
                .limit(to: 100)
                .getDocuments()
            async let ownSnapshot = db.collection("posts")
                .whereField("authorID", isEqualTo: user.uid)
                .limit(to: 100)
                .getDocuments()
            let (publicDocs, ownDocs) = try await (publicSnapshot, ownSnapshot)
            publicPosts = publicDocs.documents.compactMap(PULSEPost.init(document:))
            ownPrivatePosts = ownDocs.documents.compactMap(PULSEPost.init(document:))
            refreshPostLists()
            loadError = ""
        } catch {
            loadError = error.localizedDescription
        }
    }

    private func saveProfile(name: String, bio newBio: String, isPrivate: Bool) async {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanBio = newBio.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanName.isEmpty, cleanName.count <= 60, cleanBio.count <= 160 else { return }
        do {
            if isPrivate != isAccountPrivate {
                let own = try await db.collection("posts").whereField("authorID", isEqualTo: user.uid).getDocuments()
                for chunkStart in stride(from: 0, to: own.documents.count, by: 400) {
                    let batch = db.batch()
                    for document in own.documents.dropFirst(chunkStart).prefix(400) {
                        batch.updateData(["isPrivate": isPrivate], forDocument: document.reference)
                    }
                    try await batch.commit()
                }
            }
            try await db.collection("users").document(user.uid).updateData([
                "displayName": cleanName,
                "bio": cleanBio,
                "isPrivate": isPrivate
            ])
            let profileChange = user.createProfileChangeRequest()
            profileChange.displayName = cleanName
            try await profileChange.commitChanges()
            displayName = cleanName
            bio = cleanBio
            isAccountPrivate = isPrivate
            showEditProfile = false
        } catch {
            loadError = error.localizedDescription
        }
    }

    private func deleteAccount() async {
        guard let lastSignIn = user.metadata.lastSignInDate,
              Date().timeIntervalSince(lastSignIn) < 300 else {
            loadError = "For security, sign out and sign back in, then try deleting your account again."
            return
        }
        do {
            let own = try await db.collection("posts").whereField("authorID", isEqualTo: user.uid).getDocuments()
            for document in own.documents {
                try await document.reference.delete()
            }
            let profileRef = db.collection("users").document(user.uid)
            let profile = try await profileRef.getDocument()
            if let usernameKey = profile.data()?["usernameLowercase"] as? String {
                try await db.collection("usernames").document(usernameKey).delete()
            }
            try await profileRef.delete()
            try await user.delete()
        } catch {
            loadError = "Could not delete the account. You may need to sign in again first. " + error.localizedDescription
        }
    }
}

private enum PULSEAvatarPalette {
    static let colors: [Color] = [
        Color(red: 0.20, green: 0.39, blue: 0.82),
        Color(red: 0.44, green: 0.30, blue: 0.78),
        Color(red: 0.08, green: 0.52, blue: 0.48),
        Color(red: 0.76, green: 0.35, blue: 0.24),
        Color(red: 0.70, green: 0.34, blue: 0.53),
        Color(red: 0.36, green: 0.45, blue: 0.30)
    ]

    static func color(for name: String) -> Color {
        let scalar = name.trimmingCharacters(in: .whitespacesAndNewlines).unicodeScalars.first?.value ?? 0
        return colors[Int(scalar % UInt32(colors.count))]
    }
}

private struct PULSEAvatar: View {
    let name: String
    var size: CGFloat = 42

    var body: some View {
        Circle()
            .fill(PULSEAvatarPalette.color(for: name))
            .frame(width: size, height: size)
            .overlay {
                Text(String(name.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1)).uppercased().isEmpty
                     ? "P"
                     : String(name.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1)).uppercased())
                    .font(.system(size: size * 0.38, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            .accessibilityLabel("\(name) avatar")
    }
}

private struct PULSEPostRow: View {
    let post: PULSEPost
    let currentUserID: String
    var currentDisplayName = ""
    var currentUsername = ""
    var isOwnPost = false
    var onPostChanged: () -> Void = {}

    @State private var isLiked = false
    @State private var likeCount = 0
    @State private var repostCount = 0
    @State private var isReposted = false
    @State private var likesListener: ListenerRegistration?
    @State private var repostsListener: ListenerRegistration?
    @State private var ownRepostListener: ListenerRegistration?
    @State private var likeError = ""
    @State private var showReplyComposer = false

    private var postRef: DocumentReference {
        Firestore.firestore().collection("posts").document(post.id)
    }

    private var likesRef: CollectionReference { postRef.collection("likes") }
    private var repostsRef: CollectionReference { postRef.collection("reposts") }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            PULSEAvatar(name: post.authorName, size: 42)

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text(post.authorName)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Text("@\(post.username)")
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    Text("·").foregroundStyle(.tertiary)

                    Text(post.createdAt, style: .relative)
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    Spacer(minLength: 0)

                    Menu {
                        if isOwnPost {
                            Button {
                                Task { await togglePostPrivacy() }
                            } label: {
                                Label(post.isPrivate ? "Make post public" : "Make post private",
                                      systemImage: post.isPrivate ? "globe" : "lock")
                            }
                            Button(role: .destructive) {
                                Task { await deletePost() }
                            } label: {
                                Label("Delete post", systemImage: "trash")
                            }
                        }
                        ShareLink(item: post.text) {
                            Label("Share post", systemImage: "square.and.arrow.up")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.secondary)
                            .frame(width: 28, height: 28)
                            .contentShape(Rectangle())
                    }
                    .accessibilityLabel("Post options")
                }

                if post.isPrivate {
                    Label("Only you can see this", systemImage: "lock.fill")
                        .font(.custom("PlusJakartaSans-Regular", size: 11))
                        .foregroundStyle(.secondary)
                }

                Text(post.text)
                    .font(.custom("PlusJakartaSans-Regular", size: 15))
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)

                HStack(spacing: 0) {
                    Button(action: toggleLike) {
                        Label("\(likeCount)", systemImage: isLiked ? "heart.fill" : "heart")
                            .foregroundStyle(isLiked ? Color.pink : Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(isLiked ? "Unlike post" : "Like post")

                    Button {
                        showReplyComposer = true
                    } label: {
                        Image(systemName: "bubble")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Reply to post")

                    Button(action: toggleRepost) {
                        Label("\(repostCount)", systemImage: "arrow.2.squarepath")
                            .foregroundStyle(isReposted ? Color.green : Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                    .disabled(post.isPrivate)
                    .accessibilityLabel(isReposted ? "Undo repost" : "Repost")

                    ShareLink(item: post.text) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .accessibilityLabel("Share post")
                }
                .font(.custom("PlusJakartaSans-Medium", size: 12))

                if !likeError.isEmpty {
                    Text(likeError)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
        .contentShape(Rectangle())
        .onAppear {
            startLikesListener()
            startRepostsListeners()
        }
        .onDisappear {
            likesListener?.remove()
            repostsListener?.remove()
            ownRepostListener?.remove()
            likesListener = nil
            repostsListener = nil
            ownRepostListener = nil
        }
        .sheet(isPresented: $showReplyComposer) {
            PULSEReplyComposer(
                postID: post.id,
                user: Auth.auth().currentUser,
                displayName: currentDisplayName.isEmpty ? post.authorName : currentDisplayName,
                username: currentUsername
            )
        }
    }

    private func startLikesListener() {
        guard likesListener == nil else { return }
        likesListener = likesRef.addSnapshotListener { snapshot, error in
            if let error { likeError = error.localizedDescription; return }
            let documents = snapshot?.documents ?? []
            likeCount = documents.count
            isLiked = documents.contains { $0.documentID == currentUserID }
            likeError = ""
        }
    }

    private func startRepostsListeners() {
        guard repostsListener == nil else { return }
        repostsListener = repostsRef.addSnapshotListener { snapshot, error in
            if let error { likeError = error.localizedDescription; return }
            repostCount = snapshot?.documents.count ?? 0
        }
        ownRepostListener = repostsRef.document(currentUserID).addSnapshotListener { snapshot, error in
            if let error { likeError = error.localizedDescription; return }
            isReposted = snapshot?.exists ?? false
        }
    }

    private func toggleLike() {
        let likeRef = likesRef.document(currentUserID)
        Task {
            do {
                if isLiked {
                    try await likeRef.delete()
                } else {
                    try await likeRef.setData(["uid": currentUserID, "createdAt": FieldValue.serverTimestamp()])
                }
            } catch { likeError = error.localizedDescription }
        }
    }

    private func toggleRepost() {
        let repostRef = repostsRef.document(currentUserID)
        Task {
            do {
                if isReposted {
                    try await repostRef.delete()
                } else {
                    try await repostRef.setData([
                        "uid": currentUserID,
                        "authorName": currentDisplayName,
                        "username": currentUsername,
                        "createdAt": FieldValue.serverTimestamp()
                    ])
                }
            } catch { likeError = error.localizedDescription }
        }
    }

    private func togglePostPrivacy() async {
        do {
            try await postRef.updateData(["isPrivate": !post.isPrivate])
            onPostChanged()
        } catch { likeError = error.localizedDescription }
    }

    private func deletePost() async {
        do {
            try await postRef.delete()
            onPostChanged()
        } catch { likeError = error.localizedDescription }
    }
}

private struct PULSEReplyComposer: View {
    let postID: String
    let user: User?
    let displayName: String
    let username: String

    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State private var errorMessage = ""
    @State private var isSending = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 14) {
                Text("Replying to a post")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    .foregroundStyle(.secondary)
                TextEditor(text: $text)
                    .font(.custom("PlusJakartaSans-Regular", size: 16))
                    .frame(minHeight: 130)
                    .overlay(alignment: .topLeading) {
                        if text.isEmpty {
                            Text("Write a reply…")
                                .foregroundStyle(.tertiary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                    }
                if !errorMessage.isEmpty {
                    Text(errorMessage).font(.caption).foregroundStyle(.red)
                }
                Spacer()
            }
            .padding(18)
            .navigationTitle("Reply")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reply") { Task { await sendReply() } }
                        .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSending)
                }
            }
        }
    }

    private func sendReply() async {
        guard let user else { errorMessage = "Sign in to reply."; return }
        let body = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !body.isEmpty, body.count <= 280 else { return }
        isSending = true
        defer { isSending = false }
        do {
            try await Firestore.firestore().collection("posts").document(postID)
                .collection("replies").addDocument(data: [
                    "authorID": user.uid,
                    "authorName": displayName,
                    "username": username,
                    "text": body,
                    "createdAt": FieldValue.serverTimestamp()
                ])
            dismiss()
        } catch { errorMessage = error.localizedDescription }
    }
}

private struct PULSEEditProfileView: View {
    let user: User
    let onSave: (String, String, Bool) -> Void
    let onDeleteAccount: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var bio: String
    @State private var isPrivate: Bool

    init(user: User, displayName: String, bio: String, isPrivate: Bool,
         onSave: @escaping (String, String, Bool) -> Void,
         onDeleteAccount: @escaping () -> Void) {
        self.user = user
        self.onSave = onSave
        self.onDeleteAccount = onDeleteAccount
        _name = State(initialValue: displayName)
        _bio = State(initialValue: bio)
        _isPrivate = State(initialValue: isPrivate)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Profile") {
                    TextField("Display name", text: $name)
                        .textInputAutocapitalization(.words)
                        .onChange(of: name) { _, value in if value.count > 60 { name = String(value.prefix(60)) } }
                    TextField("Bio", text: $bio, axis: .vertical)
                        .lineLimit(2...4)
                        .onChange(of: bio) { _, value in if value.count > 160 { bio = String(value.prefix(160)) } }
                }
                Section("Privacy") {
                    Toggle("Private account", isOn: $isPrivate)
                    Text("When enabled, your existing posts and new posts are visible only to you. Followers are not implemented yet.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Section {
                    Button("Delete account", role: .destructive, action: onDeleteAccount)
                } footer: {
                    Text("Deleting your account is permanent. You may need to sign in again before deleting it.")
                }
            }
            .navigationTitle("Edit profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") { onSave(name, bio, isPrivate) }
                        .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

private struct PULSEComposerView: View {
    let user: User
    let displayName: String
    let username: String

    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State private var isPublishing = false
    @State private var errorMessage = ""

    private let maximumLength = 280
    private let db = Firestore.firestore()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    PULSEAvatar(name: displayName, size: 44)
                    VStack(alignment: .leading, spacing: 3) {
                        Text(displayName)
                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        Text(username.isEmpty ? "Posting to PULSE" : "@\(username)")
                            .font(.custom("PlusJakartaSans-Regular", size: 12))
                            .foregroundStyle(.secondary)
                    }
                }

                TextEditor(text: $text)
                    .font(.custom("PlusJakartaSans-Regular", size: 17))
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 170)
                    .overlay(alignment: .topLeading) {
                        if text.isEmpty {
                            Text("What's on your mind?")
                                .font(.custom("PlusJakartaSans-Regular", size: 17))
                                .foregroundStyle(.tertiary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                    }
                    .onChange(of: text) { _, newValue in
                        if newValue.count > maximumLength {
                            text = String(newValue.prefix(maximumLength))
                        }
                    }

                HStack {
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    Spacer()
                    Text("\(text.count)/\(maximumLength)")
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(20)
            .navigationTitle("New post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .disabled(isPublishing)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { await publish() }
                    } label: {
                        if isPublishing {
                            ProgressView()
                        } else {
                            Text("Post").fontWeight(.semibold)
                        }
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isPublishing)
                }
            }
        }
    }

    private func publish() async {
        let body = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !body.isEmpty else { return }
        isPublishing = true
        errorMessage = ""
        defer { isPublishing = false }

        do {
            let profile = try await db.collection("users").document(user.uid).getDocument()
            let profileData = profile.data() ?? [:]
            let currentName = (profileData["displayName"] as? String ?? displayName)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let currentUsername = (profileData["username"] as? String ?? username)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let accountIsPrivate = profileData["isPrivate"] as? Bool ?? false

            guard !currentName.isEmpty,
                  currentUsername.range(of: "^[A-Za-z0-9_]{3,20}$", options: .regularExpression) != nil else {
                errorMessage = "Your profile is still loading or is incomplete. Close the composer, wait a moment, and try again."
                return
            }

            try await db.collection("posts").addDocument(data: [
                "authorID": user.uid,
                "authorName": currentName,
                "username": currentUsername,
                "text": body,
                "createdAt": FieldValue.serverTimestamp(),
                "isPrivate": accountIsPrivate
            ])
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
