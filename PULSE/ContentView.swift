import SwiftUI

private struct PulsePost: Identifiable {
    let id: UUID
    var name: String
    var username: String
    var text: String
    var createdAt: Date
    var likes: Int
    var replies: Int
    var reposts: Int
    var topic: String
    var isVerified: Bool
    var isLiked: Bool
    var isReposted: Bool

    init(
        id: UUID = UUID(),
        name: String,
        username: String,
        text: String,
        createdAt: Date = .now,
        likes: Int = 0,
        replies: Int = 0,
        reposts: Int = 0,
        topic: String = "General",
        isVerified: Bool = false,
        isLiked: Bool = false,
        isReposted: Bool = false
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.text = text
        self.createdAt = createdAt
        self.likes = likes
        self.replies = replies
        self.reposts = reposts
        self.topic = topic
        self.isVerified = isVerified
        self.isLiked = isLiked
        self.isReposted = isReposted
    }
}

private struct PulsePerson: Identifiable {
    let id: String
    let name: String
    let username: String
    let bio: String
}

private struct PulseActivity: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let action: String
    let date: String
    let symbol: String
}

private struct PulseConversation: Identifiable {
    let id: String
    let name: String
    let username: String
    let preview: String
    let time: String
}

private enum PulseFeed: String, CaseIterable, Identifiable {
    case forYou = "For You"
    case following = "Following"
    var id: String { rawValue }
}

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var selectedFeed: PulseFeed = .forYou
    @State private var posts: [PulsePost] = [
        PulsePost(name: "Alex Morgan", username: "alexm", text: "A little reminder that you don't have to turn every hobby into a side hustle. Sometimes it's enough to just enjoy it.", createdAt: .now.addingTimeInterval(-720), likes: 128, replies: 18, reposts: 7, topic: "Life"),
        PulsePost(name: "Jamie Chen", username: "jamie", text: "Finally beat the level that's been bullying me all week 😭", createdAt: .now.addingTimeInterval(-2040), likes: 64, replies: 12, reposts: 3, topic: "Gaming"),
        PulsePost(name: "Riley Park", username: "rileypark", text: "What is one tiny thing that made today better?", createdAt: .now.addingTimeInterval(-3600), likes: 42, replies: 29, reposts: 2, topic: "Life"),
        PulsePost(name: "Noah Rivera", username: "noahdraws", text: "Tiny UI detail of the day: a good empty state should feel like an invitation, not a dead end.", createdAt: .now.addingTimeInterval(-7200), likes: 203, replies: 24, reposts: 31, topic: "Design", isVerified: true)
    ]
    @State private var draft = ""
    @State private var searchText = ""
    @State private var selectedTopic = "All"
    @State private var followedUsers: Set<String> = ["alexm"]
    @State private var savedPostIDs: Set<UUID> = []
    @State private var showSettings = false
    @State private var showMessages = false
    @State private var showComposer = false
    @State private var composerText = ""
    @State private var replyTarget: PulsePost?
    @State private var replyDraft = ""
    @State private var selectedProfileSection = "Posts"
    @State private var selectedProfileUser = "alexm"
    @State private var statusMessage: String?
    @State private var showStatus = false

    private let topics = ["All", "Design", "Gaming", "Tech", "Art", "Life"]
    private let people: [PulsePerson] = [
        PulsePerson(id: "mikamakes", name: "Mika Torres", username: "mikamakes", bio: "Design, tiny apps & big ideas"),
        PulsePerson(id: "kaiplays", name: "Kai Bennett", username: "kaiplays", bio: "Games, clips and occasional wins"),
        PulsePerson(id: "arisol", name: "Ari Sol", username: "arisol", bio: "Illustration, music and daily life"),
        PulsePerson(id: "noahdraws", name: "Noah Rivera", username: "noahdraws", bio: "Making things and sharing the process")
    ]
    private let activities: [PulseActivity] = [
        PulseActivity(name: "Mika Torres", username: "mikamakes", action: "liked your post", date: "4m", symbol: "heart"),
        PulseActivity(name: "Kai Bennett", username: "kaiplays", action: "started following you", date: "22m", symbol: "person.badge.plus"),
        PulseActivity(name: "Ari Sol", username: "arisol", action: "replied to a conversation", date: "1h", symbol: "bubble.left"),
        PulseActivity(name: "Noah Rivera", username: "noahdraws", action: "mentioned you in a post", date: "3h", symbol: "at")
    ]
    private let conversations: [PulseConversation] = [
        PulseConversation(id: "mikamakes", name: "Mika Torres", username: "mikamakes", preview: "That new post was so good!", time: "2m"),
        PulseConversation(id: "kaiplays", name: "Kai Bennett", username: "kaiplays", preview: "Are you playing later?", time: "18m"),
        PulseConversation(id: "arisol", name: "Ari Sol", username: "arisol", preview: "Sent you a photo", time: "1h")
    ]

    var body: some View {
        TabView(selection: $selectedTab) {
            homeTab
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            exploreTab
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            createTab
                .tabItem { Label("Create", systemImage: "plus.square") }
                .tag(2)
            activityTab
                .tabItem { Label("Notifications", systemImage: "bell") }
                .tag(3)
            profileTab
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(4)
        }
        .sheet(isPresented: $showComposer) {
            composeSheet
        }
        .sheet(item: $replyTarget) { post in
            replySheet(for: post)
        }
        .sheet(isPresented: $showSettings) {
            settingsSheet
        }
        .sheet(isPresented: $showMessages) {
            messagesTab
        }
        .alert("PULSE", isPresented: $showStatus) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(statusMessage ?? "")
        }
    }

    private var homeTab: some View {
        NavigationStack {
            List {
                Picker("Feed", selection: $selectedFeed) {
                    ForEach(PulseFeed.allCases) { feed in
                        Text(feed.rawValue).tag(feed)
                    }
                }
                .pickerStyle(.segmented)
                .listRowSeparator(.hidden)

                let visiblePosts = selectedFeed == .following
                    ? posts.filter { followedUsers.contains($0.username) || $0.username == "alexm" }
                    : posts

                if visiblePosts.isEmpty {
                    ContentUnavailableView(
                        "Your feed is quiet",
                        systemImage: "person.2",
                        description: Text("Follow people in Search to see their posts here.")
                    )
                    .listRowSeparator(.hidden)
                } else {
                    ForEach(visiblePosts) { post in
                        postCell(post)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("PULSE")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showMessages = true
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    .accessibilityLabel("Messages")

                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .accessibilityLabel("Settings")
                }
            }
            .refreshable {
                statusMessage = "You're all caught up."
                showStatus = true
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    composerText = ""
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.title2)
                        .frame(width: 54, height: 54)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Circle())
                .padding()
                .accessibilityLabel("Write a post")
            }
        }
    }

    private var exploreTab: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Search posts and people", text: $searchText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                Section("Topics") {
                    Picker("Topic", selection: $selectedTopic) {
                        ForEach(topics, id: \.self) { topic in
                            Text(topic).tag(topic)
                        }
                    }
                    .pickerStyle(.menu)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(topics, id: \.self) { topic in
                                Button {
                                    selectedTopic = topic
                                } label: {
                                    Text(topic)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 7)
                                }
                                .buttonStyle(.bordered)
                                .tint(selectedTopic == topic ? .accentColor : .secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                Section("People to follow") {
                    ForEach(people) { person in
                        personRow(person)
                    }
                }

                Section("Posts") {
                    let matchingPosts = posts.filter { post in
                        let matchesTopic = selectedTopic == "All" || post.topic == selectedTopic
                        let matchesSearch = searchText.isEmpty ||
                            post.text.localizedCaseInsensitiveContains(searchText) ||
                            post.name.localizedCaseInsensitiveContains(searchText) ||
                            post.username.localizedCaseInsensitiveContains(searchText)
                        return matchesTopic && matchesSearch
                    }
                    if matchingPosts.isEmpty {
                        ContentUnavailableView.search(text: searchText.isEmpty ? selectedTopic : searchText)
                    } else {
                        ForEach(matchingPosts) { post in
                            postCell(post)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var createTab: some View {
        NavigationStack {
            Form {
                Section("Your post") {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        TextField("What's happening?", text: $draft, axis: .vertical)
                            .lineLimit(5...10)
                            .accessibilityLabel("Post text")
                    }
                    HStack {
                        Text("Topic")
                        Spacer()
                        Picker("Topic", selection: $selectedTopic) {
                            ForEach(Array(topics.dropFirst()), id: \.self) { topic in
                                Text(topic).tag(topic)
                            }
                        }
                        .labelsHidden()
                    }
                    HStack {
                        Spacer()
                        Text("\(draft.count)/2000")
                            .font(.caption)
                            .foregroundStyle(draft.count > 2000 ? .red : .secondary)
                    }
                }

                Section {
                    Button {
                        publishDraft()
                    } label: {
                        Label("Post", systemImage: "paperplane")
                    }
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || draft.count > 2000)
                } footer: {
                    Text("This demo keeps posts in memory for the current app session. A backend is not connected yet.")
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Clear") {
                        draft = ""
                    }
                    .disabled(draft.isEmpty)
                }
            }
        }
    }

    private var activityTab: some View {
        NavigationStack {
            List {
                Section("Today") {
                    ForEach(activities) { activity in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: activity.symbol)
                                .font(.title3)
                                .foregroundStyle(.tint)
                                .frame(width: 30)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(activity.name) (@\(activity.username))")
                                    .font(.subheadline.weight(.semibold))
                                Text(activity.action)
                                    .font(.subheadline)
                                Text(activity.date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                Section {
                    Text("Notifications are sample content in this demo.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .listStyle(.insetGrouped)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var messagesTab: some View {
        NavigationStack {
            List {
                ForEach(conversations) { conversation in
                    Button {
                        statusMessage = "Messaging is a local demo and isn't connected to a server yet."
                        showStatus = true
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(conversation.name)
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(.primary)
                                    Text("@\(conversation.username)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                    Text(conversation.time)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Text(conversation.preview)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .buttonStyle(.plain)
                }
                Section {
                    Text("Direct messages are sample conversations in this demo.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Messages")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        statusMessage = "New messages will be available when messaging is connected."
                        showStatus = true
                    } label: {
                        Image(systemName: "envelope.badge")
                    }
                    .accessibilityLabel("New message")
                }
            }
        }
    }

    private var profileTab: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // A full-width profile banner, not a card.
                    Rectangle()
                        .fill(Color.accentColor.opacity(0.28))
                        .frame(height: 150)
                        .accessibilityLabel("Profile banner")

                    HStack(alignment: .top) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 82))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.secondary)
                            .background(.background, in: Circle())
                            .overlay(Circle().stroke(.background, lineWidth: 4))
                            .offset(y: -34)
                            .padding(.bottom, -34)

                        Spacer()

                        Button("Edit profile") {
                            statusMessage = "Profile editing will be available when account settings are connected."
                            showStatus = true
                        }
                        .buttonStyle(.bordered)
                        .padding(.top, 12)
                    }
                    .padding(.horizontal, 16)

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Alex Morgan")
                            .font(.title2.weight(.bold))
                        Text("@alexm")
                            .foregroundStyle(.secondary)

                        Text("Collecting little moments and interesting ideas.")
                            .padding(.top, 5)

                        HStack(spacing: 18) {
                            HStack(spacing: 4) {
                                Text("\(posts.filter { $0.username == "alexm" }.count)")
                                    .fontWeight(.semibold)
                                Text("Posts")
                                    .foregroundStyle(.secondary)
                            }
                            HStack(spacing: 4) {
                                Text("\(followedUsers.count)")
                                    .fontWeight(.semibold)
                                Text("Following")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .font(.subheadline)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 14)

                    Divider()

                    HStack(spacing: 0) {
                        profileSectionButton("Posts")
                        profileSectionButton("Replies")
                        profileSectionButton("Media")
                        profileSectionButton("Likes")
                    }

                    Divider()

                    Group {
                        switch selectedProfileSection {
                        case "Posts":
                            let ownPosts = posts.filter { $0.username == "alexm" }
                            if ownPosts.isEmpty {
                                ContentUnavailableView(
                                    "No posts yet",
                                    systemImage: "text.bubble",
                                    description: Text("Anything you publish will appear here.")
                                )
                                .frame(maxWidth: .infinity)
                                .padding(.top, 28)
                            } else {
                                ForEach(ownPosts) { post in
                                    postCell(post)
                                        .padding(.horizontal, 16)
                                    Divider().padding(.leading, 16)
                                }
                            }
                        case "Replies":
                            ContentUnavailableView(
                                "Your replies",
                                systemImage: "bubble.left.and.bubble.right",
                                description: Text("Conversations you reply to will appear here.")
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.top, 28)
                        case "Media":
                            ContentUnavailableView(
                                "Your media",
                                systemImage: "photo",
                                description: Text("Photos and videos you share will appear here.")
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.top, 28)
                        default:
                            let likedPosts = posts.filter(\.isLiked)
                            if likedPosts.isEmpty {
                                ContentUnavailableView(
                                    "No likes yet",
                                    systemImage: "heart",
                                    description: Text("Posts you like will appear here.")
                                )
                                .frame(maxWidth: .infinity)
                                .padding(.top, 28)
                            } else {
                                ForEach(likedPosts) { post in
                                    postCell(post)
                                        .padding(.horizontal, 16)
                                    Divider().padding(.leading, 16)
                                }
                            }
                        }
                    }
                }
            }
            .background(.background)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private func profileSectionButton(_ section: String) -> some View {
        Button {
            selectedProfileSection = section
        } label: {
            VStack(spacing: 10) {
                Text(section)
                    .font(.subheadline.weight(selectedProfileSection == section ? .semibold : .regular))
                    .foregroundStyle(selectedProfileSection == section ? .primary : .secondary)
                Capsule()
                    .fill(selectedProfileSection == section ? Color.accentColor : .clear)
                    .frame(height: 3)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private func postCell(_ post: PulsePost) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title)
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 5) {
                        Text(post.name)
                            .font(.subheadline.weight(.semibold))
                        if post.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.blue)
                                .font(.caption)
                        }
                    }
                    Text("@\(post.username) · \(post.createdAt, style: .relative)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Menu {
                    Button {
                        toggleSaved(post)
                    } label: {
                        Label(savedPostIDs.contains(post.id) ? "Remove bookmark" : "Bookmark", systemImage: savedPostIDs.contains(post.id) ? "bookmark.fill" : "bookmark")
                    }
                    Button {
                        replyTarget = post
                    } label: {
                        Label("Reply", systemImage: "bubble.left")
                    }
                    Button {
                        statusMessage = "Report options will be available when PULSE has an account backend."
                        showStatus = true
                    } label: {
                        Label("Report post", systemImage: "flag")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.secondary)
                        .padding(.leading, 8)
                }
            }

            Text(post.text)
                .font(.body)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button {
                    toggleLike(post)
                } label: {
                    Label("\(post.likes + (post.isLiked ? 1 : 0))", systemImage: post.isLiked ? "heart.fill" : "heart")
                }
                .tint(post.isLiked ? .red : .secondary)

                Spacer()

                Button {
                    replyTarget = post
                } label: {
                    Label("\(post.replies)", systemImage: "bubble.left")
                }
                .tint(.secondary)

                Spacer()

                Button {
                    toggleRepost(post)
                } label: {
                    Label("\(post.reposts + (post.isReposted ? 1 : 0))", systemImage: post.isReposted ? "repeat" : "arrow.2.squarepath")
                }
                .tint(post.isReposted ? .green : .secondary)

                Spacer()

                ShareLink(item: post.text) {
                    Image(systemName: "square.and.arrow.up")
                }
                .tint(.secondary)
            }
            .buttonStyle(.borderless)
            .font(.caption)
        }
        .padding(.vertical, 7)
    }

    private func personRow(_ person: PulsePerson) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 3) {
                Text(person.name)
                    .font(.subheadline.weight(.semibold))
                Text("@\(person.username)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(person.bio)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(followedUsers.contains(person.username) ? "Following" : "Follow") {
                if followedUsers.contains(person.username) {
                    followedUsers.remove(person.username)
                } else {
                    followedUsers.insert(person.username)
                }
            }
            .buttonStyle(.bordered)
        }
        .padding(.vertical, 4)
    }

    private var composeSheet: some View {
        NavigationStack {
            Form {
                Section("New post") {
                    TextField("What's happening?", text: $composerText, axis: .vertical)
                        .lineLimit(6...12)
                }
                Section {
                    Text("\(composerText.count)/2000")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Button("Publish") {
                        let text = composerText.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !text.isEmpty, text.count <= 2000 else { return }
                        posts.insert(PulsePost(name: "Alex Morgan", username: "alexm", text: text), at: 0)
                        composerText = ""
                        showComposer = false
                        selectedTab = 0
                    }
                    .disabled(composerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || composerText.count > 2000)
                }
            }
            .navigationTitle("New post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { showComposer = false }
                }
            }
        }
    }

    private func replySheet(for post: PulsePost) -> some View {
        NavigationStack {
            Form {
                Section("Replying to @\(post.username)") {
                    Text(post.text)
                        .foregroundStyle(.secondary)
                    TextField("Write a reply", text: $replyDraft, axis: .vertical)
                        .lineLimit(3...8)
                }
                Section {
                    Button("Reply") {
                        guard !replyDraft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                        if let index = posts.firstIndex(where: { $0.id == post.id }) {
                            posts[index].replies += 1
                        }
                        replyDraft = ""
                        replyTarget = nil
                        statusMessage = "Reply added to the demo conversation."
                        showStatus = true
                    }
                    .disabled(replyDraft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                } footer: {
                    Text("Replies are simulated locally and aren't uploaded.")
                }
            }
            .navigationTitle("Reply")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        replyDraft = ""
                        replyTarget = nil
                    }
                }
            }
        }
    }

    private var settingsSheet: some View {
        NavigationStack {
            Form {
                Section("Account") {
                    NavigationLink("Edit profile") {
                        Form {
                            TextField("Display name", text: .constant("Alex Morgan"))
                            TextField("Username", text: .constant("alexm"))
                            TextField("Bio", text: .constant("Collecting little moments and interesting ideas."))
                        }
                        .navigationTitle("Edit profile")
                    }
                    Label("Privacy and audience", systemImage: "hand.raised")
                    Label("Blocked accounts", systemImage: "person.crop.circle.badge.xmark")
                }
                Section("Preferences") {
                    Label("Notifications", systemImage: "bell")
                    Label("Feed preferences", systemImage: "slider.horizontal.3")
                    Label("Appearance", systemImage: "circle.lefthalf.filled")
                }
                Section("About") {
                    LabeledContent("Version", value: "0.2.0 demo")
                    Text("PULSE is currently a local prototype. Account, privacy, and notification settings are not connected to a server.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { showSettings = false }
                }
            }
        }
    }

    private func publishDraft() {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, text.count <= 2000 else { return }
        posts.insert(PulsePost(name: "Alex Morgan", username: "alexm", text: text, topic: selectedTopic == "All" ? "General" : selectedTopic), at: 0)
        draft = ""
        selectedTopic = "All"
        selectedTab = 0
        statusMessage = "Your post was added to the feed."
        showStatus = true
    }

    private func toggleLike(_ post: PulsePost) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        posts[index].isLiked.toggle()
    }

    private func toggleRepost(_ post: PulsePost) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        posts[index].isReposted.toggle()
    }

    private func toggleSaved(_ post: PulsePost) {
        if savedPostIDs.contains(post.id) {
            savedPostIDs.remove(post.id)
        } else {
            savedPostIDs.insert(post.id)
        }
    }
}

#Preview {
    ContentView()
}
