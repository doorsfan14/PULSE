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
    @State private var isLoading = true
    @State private var loadError = ""
    @State private var showComposer = false
    @State private var selectedTab = 0
    @State private var feedListener: ListenerRegistration?

    private let db = Firestore.firestore()

    var body: some View {
        TabView(selection: $selectedTab) {
            feedScreen
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)

            profileScreen
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(1)
        }
        .tint(PULSEStyle.blue)
        .task { await loadProfile() }
        .onAppear(perform: startFeedListener)
        .onDisappear {
            feedListener?.remove()
            feedListener = nil
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
                                PULSEPostRow(post: post, currentUserID: user.uid)
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
                        LinearGradient(
                            colors: [
                                Color(red: 0.16, green: 0.34, blue: 0.78),
                                Color(red: 0.31, green: 0.38, blue: 0.91),
                                Color(red: 0.53, green: 0.31, blue: 0.82)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )

                        Circle()
                            .fill(Color.white.opacity(0.10))
                            .frame(width: 190, height: 190)
                            .offset(x: 220, y: -18)

                        Circle()
                            .stroke(Color.white.opacity(0.16), lineWidth: 1)
                            .frame(width: 240, height: 240)
                            .offset(x: 180, y: 70)

                        Text("PULSE")
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .tracking(4)
                            .foregroundStyle(.white.opacity(0.13))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.top, 18)
                            .padding(.trailing, 18)

                        Text("YOUR SPACE. YOUR PULSE.")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 10))
                            .tracking(2)
                            .foregroundStyle(.white.opacity(0.82))
                            .padding(.leading, 20)
                            .padding(.bottom, 18)
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

                            Button {
                                do {
                                    try PULSEBackend.shared.signOut()
                                } catch {
                                    loadError = error.localizedDescription
                                }
                            } label: {
                                Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 9)
                                    .overlay(Capsule().stroke(PULSEStyle.divider, lineWidth: 1))
                            }
                            .buttonStyle(.plain)
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
                            Text("YOUR POSTS")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 11))
                                .tracking(1.8)
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
                                PULSEPostRow(post: post, currentUserID: user.uid, showsAvatar: false)
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
        } catch {
            displayName = user.displayName ?? ""
            loadError = error.localizedDescription
        }
    }

    private func startFeedListener() {
        guard feedListener == nil else { return }
        feedListener = db.collection("posts")
            .order(by: "createdAt", descending: true)
            .limit(to: 50)
            .addSnapshotListener { snapshot, error in
                if let error {
                    loadError = error.localizedDescription
                    isLoading = false
                    return
                }
                posts = snapshot?.documents.compactMap(PULSEPost.init(document:)) ?? []
                loadError = ""
                isLoading = false
            }
    }

    private func refreshFeed() async {
        do {
            let snapshot = try await db.collection("posts")
                .order(by: "createdAt", descending: true)
                .limit(to: 50)
                .getDocuments()
            posts = snapshot.documents.compactMap(PULSEPost.init(document:))
            loadError = ""
        } catch {
            loadError = error.localizedDescription
        }
    }
}

private struct PULSEAvatar: View {
    let name: String
    var size: CGFloat = 42

    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [PULSEStyle.blue.opacity(0.20), PULSEStyle.violet.opacity(0.18)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: size, height: size)
            .overlay {
                Text(String(name.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1)).uppercased().isEmpty
                     ? "P"
                     : String(name.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1)).uppercased())
                    .font(.system(size: size * 0.38, weight: .bold, design: .rounded))
                    .foregroundStyle(PULSEStyle.blue)
            }
            .accessibilityLabel("\(name) avatar")
    }
}

private struct PULSEPostRow: View {
    let post: PULSEPost
    let currentUserID: String
    var showsAvatar = true

    @State private var isLiked = false
    @State private var likeCount = 0
    @State private var likesListener: ListenerRegistration?
    @State private var likeError = ""

    private var likesRef: CollectionReference {
        Firestore.firestore().collection("posts").document(post.id).collection("likes")
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if showsAvatar {
                PULSEAvatar(name: post.authorName, size: 42)
            }

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

                    Text("·")
                        .foregroundStyle(.tertiary)

                    Text(post.createdAt, style: .relative)
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    Spacer(minLength: 0)

                    Button {} label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Post options")
                }

                Text(post.text)
                    .font(.custom("PlusJakartaSans-Regular", size: 15))
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)

                HStack(spacing: 24) {
                    Button(action: toggleLike) {
                        HStack(spacing: 6) {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundStyle(isLiked ? Color.pink : Color.secondary)
                            Text("\(likeCount)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(isLiked ? "Unlike post" : "Like post")

                    Label("Reply", systemImage: "bubble")
                        .foregroundStyle(.secondary)

                    Spacer()
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
        .onAppear(perform: startLikesListener)
        .onDisappear {
            likesListener?.remove()
            likesListener = nil
        }
    }

    private func startLikesListener() {
        guard likesListener == nil else { return }
        likesListener = likesRef.addSnapshotListener { snapshot, error in
            if let error {
                likeError = error.localizedDescription
                return
            }
            let documents = snapshot?.documents ?? []
            likeCount = documents.count
            isLiked = documents.contains { $0.documentID == currentUserID }
            likeError = ""
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
            } catch {
                likeError = error.localizedDescription
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
                "createdAt": FieldValue.serverTimestamp()
            ])
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
