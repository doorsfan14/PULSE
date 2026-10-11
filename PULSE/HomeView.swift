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
        .tint(Color(red: 0.25, green: 0.48, blue: 0.96))
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
                        LazyVStack(spacing: 12) {
                            ForEach(posts) { post in
                                PULSEPostCard(post: post, currentUserID: user.uid)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 24)
                    }
                    .refreshable { await refreshFeed() }
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
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
            List {
                Section {
                    HStack(spacing: 14) {
                        Circle()
                            .fill(Color(red: 0.22, green: 0.42, blue: 0.86).opacity(0.14))
                            .frame(width: 62, height: 62)
                            .overlay {
                                Text(String((displayName.isEmpty ? (user.displayName ?? "P") : displayName).prefix(1)).uppercased())
                                    .font(.system(size: 25, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color(red: 0.25, green: 0.48, blue: 0.96))
                            }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(displayName.isEmpty ? (user.displayName ?? "Your profile") : displayName)
                                .font(.custom("PlusJakartaSans-SemiBold", size: 17))
                            Text(username.isEmpty ? user.email ?? "" : "@\(username)")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section {
                    LabeledContent("Posts", value: "\(posts.filter { $0.authorID == user.uid }.count)")
                } header: {
                    Text("Your activity")
                }

                Section {
                    Button(role: .destructive) {
                        do {
                            try PULSEBackend.shared.signOut()
                        } catch {
                            loadError = error.localizedDescription
                        }
                    } label: {
                        Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .navigationTitle("Profile")
            .background(Color(uiColor: .systemGroupedBackground))
        }
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

private struct PULSEPostCard: View {
    let post: PULSEPost
    let currentUserID: String

    @State private var isLiked = false
    @State private var likeCount = 0
    @State private var likesListener: ListenerRegistration?
    @State private var likeError = ""

    private var likesRef: CollectionReference {
        Firestore.firestore().collection("posts").document(post.id).collection("likes")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Circle()
                    .fill(Color(red: 0.24, green: 0.43, blue: 0.85).opacity(0.14))
                    .frame(width: 42, height: 42)
                    .overlay {
                        Text(String(post.authorName.prefix(1)).uppercased())
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color(red: 0.25, green: 0.48, blue: 0.96))
                    }
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.authorName)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundStyle(.primary)
                    Text("@\(post.username) · \(post.createdAt, style: .relative)")
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            Text(post.text)
                .font(.custom("PlusJakartaSans-Regular", size: 15))
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .textSelection(.enabled)

            HStack(spacing: 6) {
                Button(action: toggleLike) {
                    Label(isLiked ? "Liked" : "Like", systemImage: isLiked ? "heart.fill" : "heart")
                        .foregroundStyle(isLiked ? Color.pink : Color.secondary)
                }
                .buttonStyle(.plain)
                .disabled(!likeError.isEmpty && isLiked == false)

                Text("\(likeCount)")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundStyle(.secondary)

                Spacer()
                if !likeError.isEmpty {
                    Text(likeError)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .font(.custom("PlusJakartaSans-Medium", size: 13))
        }
        .padding(16)
        .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.primary.opacity(0.045), lineWidth: 1)
        }
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
            try await db.collection("posts").addDocument(data: [
                "authorID": user.uid,
                "authorName": displayName,
                "username": username,
                "text": body,
                "createdAt": FieldValue.serverTimestamp()
            ])
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
