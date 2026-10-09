import SwiftUI

private struct PulsePost: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let text: String
    let date = Date()
    var likes = 0
    var isLiked = false
}

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var posts = [
        PulsePost(name: "Alex Morgan", username: "alexm", text: "A little reminder that you don't have to turn every hobby into a side hustle. Sometimes it's enough to just enjoy it.", likes: 128),
        PulsePost(name: "Jamie Chen", username: "jamie", text: "Finally beat the level that's been bullying me all week 😭", likes: 64),
        PulsePost(name: "Riley Park", username: "rileypark", text: "What is one tiny thing that made today better?", likes: 42),
        PulsePost(name: "Noah Rivera", username: "noahdraws", text: "A good empty state should feel like an invitation, not a dead end.", likes: 203)
    ]
    @State private var draft = ""
    @State private var searchText = ""
    @State private var followedUsers: Set<String> = []
    @State private var showPostAlert = false

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                List {
                    Section {
                        ForEach(posts) { post in
                            postRow(post)
                        }
                    } header: {
                        Text("For You")
                    }
                }
                .listStyle(.plain)
                .navigationTitle("PULSE")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            selectedTab = 2
                        } label: {
                            Image(systemName: "plus")
                        }
                        .accessibilityLabel("Create post")
                    }
                }
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(0)

            NavigationStack {
                List {
                    Section {
                        TextField("Search people and posts", text: $searchText)
                            .textInputAutocapitalization(.never)
                    }
                    Section("People to follow") {
                        personRow(name: "Mika Torres", username: "mikamakes", detail: "Design, tiny apps & big ideas")
                        personRow(name: "Kai Bennett", username: "kaiplays", detail: "Games, clips and occasional wins")
                        personRow(name: "Ari Sol", username: "arisol", detail: "Illustration, music and daily life")
                    }
                    if !searchText.isEmpty {
                        Section("Matching posts") {
                            ForEach(posts.filter {
                                $0.text.localizedCaseInsensitiveContains(searchText) ||
                                $0.name.localizedCaseInsensitiveContains(searchText) ||
                                $0.username.localizedCaseInsensitiveContains(searchText)
                            }) { post in
                                postRow(post)
                            }
                        }
                    }
                }
                .navigationTitle("Explore")
            }
            .tabItem { Label("Explore", systemImage: "magnifyingglass") }
            .tag(1)

            NavigationStack {
                Form {
                    Section("Your post") {
                        TextEditor(text: $draft)
                            .frame(minHeight: 180)
                            .accessibilityLabel("Post text")
                        HStack {
                            Spacer()
                            Text("\(draft.count)/2000")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Section {
                        Button("Post") {
                            let message = draft.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !message.isEmpty else { return }
                            posts.insert(PulsePost(name: "Alex Morgan", username: "alexm", text: message), at: 0)
                            draft = ""
                            selectedTab = 0
                            showPostAlert = true
                        }
                        .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || draft.count > 2000)
                    }
                    Section {
                        Text("Posts are saved in this demo's current app session only.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle("Create")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Clear") { draft = "" }
                            .disabled(draft.isEmpty)
                    }
                }
                .alert("Post published", isPresented: $showPostAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Your post was added to the demo feed.")
                }
            }
            .tabItem { Label("Create", systemImage: "plus.square") }
            .tag(2)

            NavigationStack {
                List {
                    Label("Mika Torres liked your post", systemImage: "heart")
                    Label("Kai Bennett started following you", systemImage: "person.badge.plus")
                    Label("Ari Sol replied to a post", systemImage: "bubble.left")
                }
                .navigationTitle("Activity")
            }
            .tabItem { Label("Activity", systemImage: "heart") }
            .tag(3)

            NavigationStack {
                List {
                    Section {
                        HStack(spacing: 12) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 56))
                                .foregroundStyle(.secondary)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Alex Morgan")
                                    .font(.headline)
                                Text("@alexm")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                        Text("Collecting little moments and interesting ideas.")
                    }
                    Section("Posts") {
                        ForEach(posts.filter { $0.username == "alexm" }) { post in
                            postRow(post)
                        }
                    }
                    Section("Account") {
                        NavigationLink("Settings") {
                            Form {
                                Section("Preferences") {
                                    Label("Notifications", systemImage: "bell")
                                    Label("Privacy", systemImage: "hand.raised")
                                    Label("Appearance", systemImage: "circle.lefthalf.filled")
                                }
                                Section {
                                    Text("PULSE demo · Account settings are not connected yet.")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .navigationTitle("Settings")
                        }
                    }
                }
                .navigationTitle("Profile")
            }
            .tabItem { Label("Profile", systemImage: "person.crop.circle") }
            .tag(4)
        }
    }

    @ViewBuilder
    private func postRow(_ post: PulsePost) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title)
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 3) {
                    Text(post.name)
                        .font(.headline)
                    Text("@\(post.username)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(post.date, style: .relative)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(post.text)
                .font(.body)
                .textSelection(.enabled)
            HStack {
                Button {
                    toggleLike(for: post)
                } label: {
                    Label("\(post.likes + (post.isLiked ? 1 : 0))", systemImage: post.isLiked ? "heart.fill" : "heart")
                }
                .buttonStyle(.plain)
                .foregroundStyle(post.isLiked ? .red : .secondary)
                Spacer()
                Label("Reply", systemImage: "bubble.left")
                    .foregroundStyle(.secondary)
                Spacer()
                Label("Share", systemImage: "square.and.arrow.up")
                    .foregroundStyle(.secondary)
            }
            .font(.subheadline)
        }
        .padding(.vertical, 8)
    }

    private func toggleLike(for post: PulsePost) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        posts[index].isLiked.toggle()
    }

    private func personRow(name: String, username: String, detail: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 3) {
                Text(name).font(.headline)
                Text("@\(username)").font(.subheadline).foregroundStyle(.secondary)
                Text(detail).font(.footnote).foregroundStyle(.secondary)
            }
            Spacer()
            Button(followedUsers.contains(username) ? "Following" : "Follow") {
                if followedUsers.contains(username) {
                    followedUsers.remove(username)
                } else {
                    followedUsers.insert(username)
                }
            }
            .buttonStyle(.bordered)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
