import SwiftUI

private struct PulsePost: Identifiable {
    let id: Int
    let name: String
    let username: String
    let time: String
    let message: String
    var likes: Int
    let replies: Int
}

private struct PulsePerson: Identifiable {
    let id: Int
    let name: String
    let username: String
    let bio: String
}

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var feedSelection = "For You"
    @State private var likedPosts: Set<Int> = []
    @State private var followedPeople: Set<Int> = []
    @State private var searchText = ""
    @State private var showingComposer = false
    @State private var showingSettings = false
    @State private var draft = ""

    private let posts: [PulsePost] = [
        PulsePost(id: 1, name: "Alex Morgan", username: "alexm", time: "12m", message: "A little reminder that you don't have to turn every hobby into a side hustle. Sometimes it's enough to just enjoy it.", likes: 128, replies: 18),
        PulsePost(id: 2, name: "Jamie Chen", username: "jamie", time: "34m", message: "Finally beat the level that's been bullying me all week 😭", likes: 64, replies: 12),
        PulsePost(id: 3, name: "Riley Park", username: "rileypark", time: "1h", message: "What is one tiny thing that made today better?", likes: 42, replies: 29),
        PulsePost(id: 4, name: "Noah Rivera", username: "noahdraws", time: "2h", message: "A good empty state should feel like an invitation, not a dead end.", likes: 203, replies: 24)
    ]

    private let people: [PulsePerson] = [
        PulsePerson(id: 1, name: "Mika Torres", username: "mikamakes", bio: "Design, tiny apps & big ideas"),
        PulsePerson(id: 2, name: "Kai Bennett", username: "kaiplays", bio: "Games, clips and occasional wins"),
        PulsePerson(id: 3, name: "Ari Sol", username: "arisol", bio: "Illustration, music and daily life")
    ]

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                feedView
                    .navigationTitle("PULSE")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showingSettings = true
                            } label: {
                                Image(systemName: "gearshape")
                            }
                            .accessibilityLabel("Settings")
                        }
                    }
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(0)

            NavigationStack {
                exploreView
                    .navigationTitle("Explore")
            }
            .tabItem { Label("Explore", systemImage: "magnifyingglass") }
            .tag(1)

            NavigationStack {
                activityView
                    .navigationTitle("Activity")
            }
            .tabItem { Label("Activity", systemImage: "heart") }
            .tag(2)

            NavigationStack {
                profileView
                    .navigationTitle("Profile")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Edit") {
                                showingSettings = true
                            }
                        }
                    }
            }
            .tabItem { Label("Profile", systemImage: "person.crop.circle") }
            .tag(3)
        }
        .sheet(isPresented: $showingComposer) {
            NavigationStack {
                Form {
                    Section("What's happening?") {
                        TextEditor(text: $draft)
                            .frame(minHeight: 160)
                    }
                    Section {
                        Text("\(draft.count) / 2000 characters")
                            .foregroundStyle(draft.count > 2000 ? .red : .secondary)
                    }
                }
                .navigationTitle("New Post")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { showingComposer = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Post") {
                            draft = ""
                            showingComposer = false
                        }
                        .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || draft.count > 2000)
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showingSettings) {
            NavigationStack {
                Form {
                    Section("Account") {
                        LabeledContent("Username", value: "@alexm")
                        LabeledContent("Account type", value: "Public")
                    }
                    Section("Preferences") {
                        Toggle("Private account", isOn: .constant(false))
                        NavigationLink("Notifications") {
                            Form {
                                Toggle("Likes", isOn: .constant(true))
                                Toggle("New followers", isOn: .constant(true))
                                Toggle("Mentions", isOn: .constant(true))
                            }
                            .navigationTitle("Notifications")
                        }
                    }
                    Section {
                        Text("PULSE is currently a UI demo. Settings are not saved.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { showingSettings = false }
                    }
                }
            }
        }
    }

    private var feedView: some View {
        List {
            Section {
                Picker("Feed", selection: $feedSelection) {
                    Text("For You").tag("For You")
                    Text("Following").tag("Following")
                }
                .pickerStyle(.segmented)
            }

            if feedSelection == "Following" {
                ContentUnavailableView(
                    "No posts yet",
                    systemImage: "person.2",
                    description: Text("Follow people to see their posts here.")
                )
                Button("Find people") { selectedTab = 1 }
            } else {
                Section {
                    ForEach(posts) { post in
                        postRow(post)
                    }
                } header: {
                    Text("Latest posts · Demo")
                }
            }

            Section {
                Button {
                    showingComposer = true
                } label: {
                    Label("Write a post", systemImage: "square.and.pencil")
                }
            }
        }
        .listStyle(.insetGrouped)
        .refreshable { }
    }

    private func postRow(_ post: PulsePost) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text(post.name).fontWeight(.semibold)
                        Text("@\(post.username)")
                            .foregroundStyle(.secondary)
                        Text("· \(post.time)")
                            .foregroundStyle(.secondary)
                    }
                    .font(.subheadline)
                    Text(post.message)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            HStack {
                Button {
                    if likedPosts.contains(post.id) {
                        likedPosts.remove(post.id)
                    } else {
                        likedPosts.insert(post.id)
                    }
                } label: {
                    Label("\(post.likes + (likedPosts.contains(post.id) ? 1 : 0))", systemImage: likedPosts.contains(post.id) ? "heart.fill" : "heart")
                }
                .tint(likedPosts.contains(post.id) ? .pink : .secondary)

                Spacer()

                Label("\(post.replies)", systemImage: "bubble")
                    .foregroundStyle(.secondary)

                Spacer()

                Button {
                    showingComposer = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .accessibilityLabel("Share post")
            }
            .buttonStyle(.borderless)
            .font(.subheadline)
        }
        .padding(.vertical, 5)
    }

    private var exploreView: some View {
        List {
            Section {
                ForEach(filteredPeople) { person in
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(person.name).fontWeight(.semibold)
                            Text("@\(person.username)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(person.bio)
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(followedPeople.contains(person.id) ? "Following" : "Follow") {
                            if followedPeople.contains(person.id) {
                                followedPeople.remove(person.id)
                            } else {
                                followedPeople.insert(person.id)
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.vertical, 4)
                }
            } header: {
                Text("People to discover")
            }

            Section("Trending topics") {
                ForEach(["Design", "Gaming", "Technology", "Art", "Everyday life"], id: \.self) { topic in
                    Label(topic, systemImage: "number")
                }
            }
        }
        .listStyle(.insetGrouped)
        .searchable(text: $searchText, prompt: "People and topics")
    }

    private var filteredPeople: [PulsePerson] {
        guard !searchText.isEmpty else { return people }
        return people.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
            || $0.username.localizedCaseInsensitiveContains(searchText)
            || $0.bio.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var activityView: some View {
        List {
            Section("Today") {
                Label {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Mika Torres liked your post").fontWeight(.medium)
                        Text("4 minutes ago").font(.caption).foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: "heart.fill").foregroundStyle(.pink)
                }
                Label {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Kai Bennett started following you").fontWeight(.medium)
                        Text("22 minutes ago").font(.caption).foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: "person.badge.plus")
                }
                Label {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Ari Sol mentioned you in a post").fontWeight(.medium)
                        Text("1 hour ago").font(.caption).foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: "at")
                }
            }
            Section {
                Text("These notifications are sample content.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .listStyle(.insetGrouped)
    }

    private var profileView: some View {
        List {
            Section {
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 72, height: 72)
                        .foregroundStyle(.secondary)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Alex Morgan").font(.title3).fontWeight(.bold)
                        Text("@alexm").foregroundStyle(.secondary)
                        Text("Collecting little moments and interesting ideas. ✨")
                            .font(.subheadline)
                    }
                }
                .padding(.vertical, 8)

                HStack {
                    Label("128", systemImage: "text.bubble")
                    Spacer()
                    Label("842", systemImage: "person.2")
                    Spacer()
                    Label("391", systemImage: "person.badge.plus")
                }
                .font(.subheadline)
            }

            Section("Posts") {
                ForEach(posts) { post in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(post.message)
                        Text("@\(post.username) · \(post.time)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}
