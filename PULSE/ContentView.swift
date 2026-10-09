import SwiftUI

private enum PulseTab: String, CaseIterable {
    case home = "Home"
    case explore = "Explore"
    case create = "Create"
    case activity = "Activity"
    case profile = "Profile"

    var symbol: String {
        switch self {
        case .home: "house"
        case .explore: "safari"
        case .create: "plus.square"
        case .activity: "bell"
        case .profile: "person.crop.circle"
        }
    }
}

private enum FeedMode: String, CaseIterable {
    case forYou = "For You"
    case following = "Following"
}

private struct DemoPost: Identifiable {
    let id: Int
    let name: String
    let username: String
    let time: String
    let text: String
    let likes: Int
    let replies: Int
    let reposts: Int
    let symbol: String
}

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedTab: PulseTab = .home
    @State private var feedMode: FeedMode = .forYou
    @State private var likedPosts: Set<Int> = []
    @State private var showComposer = false

    private let posts: [DemoPost] = [
        DemoPost(
            id: 1, name: "Alex Morgan", username: "alexm", time: "12m",
            text: "A little reminder that you don't have to turn every hobby into a side hustle. Sometimes it's enough to just enjoy it.",
            likes: 128, replies: 18, reposts: 7, symbol: "sparkles"
        ),
        DemoPost(
            id: 2, name: "Jamie Chen", username: "jamie", time: "34m",
            text: "Finally beat the level that's been bullying me all week 😭",
            likes: 64, replies: 12, reposts: 3, symbol: "gamecontroller"
        ),
        DemoPost(
            id: 3, name: "Riley Park", username: "rileypark", time: "1h",
            text: "What is one tiny thing that made today better?",
            likes: 42, replies: 29, reposts: 2, symbol: "sun.max"
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            header

            if selectedTab == .home {
                feed
            } else {
                placeholder(for: selectedTab)
            }

            bottomNavigation
        }
        .background(Color(uiColor: .systemBackground))
        .preferredColorScheme(nil)
        .sheet(isPresented: $showComposer) {
            composer
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("PULSE")
                    .font(.system(size: 27, weight: .black, design: .rounded))
                    .tracking(-1.2)
                Text("Your world, in conversation.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                selectedTab = .activity
            } label: {
                Image(systemName: "bell.badge")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 42, height: 42)
                    .background(Color(uiColor: .secondarySystemBackground), in: Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Activity")
        }
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 14)
    }

    private var feed: some View {
        ScrollView {
            VStack(spacing: 0) {
                Picker("Feed", selection: $feedMode) {
                    ForEach(FeedMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)

                if feedMode == .following {
                    ContentUnavailableView(
                        "Your Following feed",
                        systemImage: "person.2",
                        description: Text("Posts from accounts you follow will appear here in newest-first order.")
                    )
                    .padding(.top, 44)
                } else {
                    ForEach(posts) { post in
                        postCard(post)
                    }
                }

                Text("You're all caught up")
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
                    .padding(.vertical, 28)
            }
        }
        .scrollIndicators(.hidden)
    }

    private func postCard(_ post: DemoPost) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 11) {
                ZStack {
                    Circle()
                        .fill(Color.primary.opacity(0.07))
                    Image(systemName: post.symbol)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primary)
                }
                .frame(width: 43, height: 43)
                .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 5) {
                        Text(post.name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)
                        Text("@\(post.username)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text("· \(post.time)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer(minLength: 0)
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.secondary)
                    }

                    Text(post.text)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 4)
                }
            }

            HStack {
                actionButton(
                    symbol: likedPosts.contains(post.id) ? "heart.fill" : "heart",
                    value: compactCount(post.likes + (likedPosts.contains(post.id) ? 1 : 0)),
                    label: likedPosts.contains(post.id) ? "Unlike post" : "Like post",
                    tint: likedPosts.contains(post.id) ? .pink : .secondary
                ) {
                    if likedPosts.contains(post.id) {
                        likedPosts.remove(post.id)
                    } else {
                        likedPosts.insert(post.id)
                    }
                }

                Spacer(minLength: 12)
                actionButton(symbol: "bubble", value: compactCount(post.replies), label: "Replies") {}
                Spacer(minLength: 12)
                actionButton(symbol: "arrow.2.squarepath", value: compactCount(post.reposts), label: "Reposts") {}
                Spacer(minLength: 12)
                Button {} label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Share post")
            }
            .padding(.leading, 54)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 17)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.primary.opacity(0.07))
                .frame(height: 1)
        }
    }

    private func actionButton(
        symbol: String,
        value: String,
        label: String,
        tint: Color = .secondary,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: symbol)
                    .font(.system(size: 15))
                Text(value)
                    .font(.caption)
                    .monospacedDigit()
            }
            .foregroundStyle(tint)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(label), \(value)")
    }

    private var bottomNavigation: some View {
        HStack(spacing: 0) {
            ForEach(PulseTab.allCases, id: \.self) { tab in
                Button {
                    if tab == .create {
                        showComposer = true
                    } else {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: tab.symbol)
                            .font(.system(size: 20, weight: selectedTab == tab ? .semibold : .regular))
                        Text(tab.rawValue)
                            .font(.system(size: 10, weight: selectedTab == tab ? .semibold : .regular))
                    }
                    .foregroundStyle(selectedTab == tab ? Color.primary : Color.secondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(selectedTab == tab ? .isSelected : [])
            }
        }
        .padding(.horizontal, 7)
        .padding(.top, 6)
        .background {
            Color(uiColor: .systemBackground)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Color.primary.opacity(0.08))
                        .frame(height: 1)
                }
                .ignoresSafeArea(edges: .bottom)
        }
    }

    private func placeholder(for tab: PulseTab) -> some View {
        VStack(spacing: 14) {
            Image(systemName: tab.symbol)
                .font(.system(size: 34, weight: .light))
                .foregroundStyle(.secondary)
            Text(placeholderTitle(for: tab))
                .font(.title3.weight(.semibold))
            Text(placeholderDescription(for: tab))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 280)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(28)
    }

    private func placeholderTitle(for tab: PulseTab) -> String {
        switch tab {
        case .home: "Your feed"
        case .explore: "Explore PULSE"
        case .create: "Create a post"
        case .activity: "Your activity"
        case .profile: "Your profile"
        }
    }

    private func placeholderDescription(for tab: PulseTab) -> String {
        switch tab {
        case .home: "See posts from your community."
        case .explore: "Discover people and public posts that match your interests."
        case .create: "Share something with your community."
        case .activity: "Likes, replies, follows, and mentions will appear here."
        case .profile: "Your profile and posts will live here."
        }
    }

    private var composer: some View {
        NavigationStack {
            ComposerView()
        }
    }

    private func compactCount(_ count: Int) -> String {
        if count >= 1_000 {
            return String(format: "%.1fk", Double(count) / 1_000)
        }
        return String(count)
    }
}

private struct ComposerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""

    private let maximumLength = 2_000

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("What's happening?", text: $text, axis: .vertical)
                .font(.title3)
                .lineLimit(5...10)
                .accessibilityLabel("Post text")
                .onChange(of: text) { _, newValue in
                    if newValue.count > maximumLength {
                        text = String(newValue.prefix(maximumLength))
                    }
                }

            Spacer()

            HStack {
                Text("\(text.count)/\(maximumLength)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Demo only — posting isn't connected yet")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(20)
        .navigationTitle("New post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Post") { dismiss() }
                    .fontWeight(.semibold)
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}
