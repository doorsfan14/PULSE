import SwiftUI

private enum PulseTab: String, CaseIterable {
    case home = "Home"
    case explore = "Explore"
    case create = "Create"
    case activity = "Activity"
    case profile = "Profile"

    var symbol: String {
        switch self {
        case .home: "house.fill"
        case .explore: "magnifyingglass"
        case .create: "plus"
        case .activity: "heart.text.square"
        case .profile: "person.crop.square"
        }
    }

    var selectedSymbol: String {
        switch self {
        case .home: "house.fill"
        case .explore: "safari.fill"
        case .create: "plus"
        case .activity: "heart.text.square.fill"
        case .profile: "person.crop.square.fill"
        }
    }
}

private enum FeedMode: String, CaseIterable {
    case forYou = "For You"
    case following = "Following"
}

private enum PulseAccent {
    static let purple = Color(red: 0.43, green: 0.32, blue: 0.92)
    static let blue = Color(red: 0.27, green: 0.61, blue: 0.96)
    static let mint = Color(red: 0.29, green: 0.76, blue: 0.66)
    static let pink = Color(red: 0.94, green: 0.39, blue: 0.63)
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
    let avatarSymbol: String
    let avatarColors: [Color]
    let topic: String
    var isVerified: Bool = false
}

private struct DemoPerson: Identifiable {
    let id: Int
    let name: String
    let username: String
    let detail: String
    let symbol: String
    let colors: [Color]
}

private struct DemoNotification: Identifiable {
    let id: Int
    let name: String
    let username: String
    let action: String
    let time: String
    let symbol: String
    let colors: [Color]
}

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var selectedTab: PulseTab = .home
    @State private var feedMode: FeedMode = .forYou
    @State private var likedPosts: Set<Int> = []
    @State private var followedPeople: Set<Int> = []
    @State private var showComposer = false
    @State private var searchText = ""
    @State private var selectedExploreCategory = "For you"
    @State private var selectedProfileSegment = "Posts"
    @State private var splashVisible = true
    @State private var contentVisible = false
    @State private var showSettings = false
    @State private var showAllNotifications = false
    @State private var toastMessage: String?

    private let exploreCategories = ["For you", "Design", "Gaming", "Tech", "Art", "Life"]
    private let profileSegments = ["Posts", "Replies", "Media", "Likes"]

    private let posts: [DemoPost] = [
        DemoPost(
            id: 1, name: "Alex Morgan", username: "alexm", time: "12m",
            text: "A little reminder that you don't have to turn every hobby into a side hustle. Sometimes it's enough to just enjoy it.",
            likes: 128, replies: 18, reposts: 7, avatarSymbol: "sparkles",
            avatarColors: [PulseAccent.purple, PulseAccent.pink], topic: "Life"
        ),
        DemoPost(
            id: 2, name: "Jamie Chen", username: "jamie", time: "34m",
            text: "Finally beat the level that's been bullying me all week 😭",
            likes: 64, replies: 12, reposts: 3, avatarSymbol: "gamecontroller.fill",
            avatarColors: [PulseAccent.blue, PulseAccent.purple], topic: "Gaming"
        ),
        DemoPost(
            id: 3, name: "Riley Park", username: "rileypark", time: "1h",
            text: "What is one tiny thing that made today better?",
            likes: 42, replies: 29, reposts: 2, avatarSymbol: "sun.max.fill",
            avatarColors: [Color.orange, PulseAccent.pink], topic: "Life"
        ),
        DemoPost(
            id: 4, name: "Noah Rivera", username: "noahdraws", time: "2h",
            text: "Tiny UI detail of the day: a good empty state should feel like an invitation, not a dead end.",
            likes: 203, replies: 24, reposts: 31, avatarSymbol: "scribble.variable",
            avatarColors: [PulseAccent.mint, PulseAccent.blue], topic: "Design",
            isVerified: true
        )
    ]

    private let people: [DemoPerson] = [
        DemoPerson(id: 1, name: "Mika Torres", username: "mikamakes", detail: "Design, tiny apps & big ideas", symbol: "paintpalette.fill", colors: [PulseAccent.pink, PulseAccent.purple]),
        DemoPerson(id: 2, name: "Kai Bennett", username: "kaiplays", detail: "Games, clips and occasional wins", symbol: "gamecontroller.fill", colors: [PulseAccent.blue, PulseAccent.mint]),
        DemoPerson(id: 3, name: "Ari Sol", username: "arisol", detail: "Illustration • music • daily life", symbol: "music.note", colors: [Color.orange, PulseAccent.pink])
    ]

    private let notifications: [DemoNotification] = [
        DemoNotification(id: 1, name: "Mika Torres", username: "mikamakes", action: "liked your post", time: "4m", symbol: "heart.fill", colors: [PulseAccent.pink, PulseAccent.purple]),
        DemoNotification(id: 2, name: "Kai Bennett", username: "kaiplays", action: "started following you", time: "22m", symbol: "person.fill.badge.plus", colors: [PulseAccent.blue, PulseAccent.mint]),
        DemoNotification(id: 3, name: "Ari Sol", username: "arisol", action: "replied: “this is such a good point!”", time: "1h", symbol: "bubble.left.fill", colors: [Color.orange, PulseAccent.pink]),
        DemoNotification(id: 4, name: "Noah Rivera", username: "noahdraws", action: "mentioned you in a post", time: "3h", symbol: "at", colors: [PulseAccent.mint, PulseAccent.blue])
    ]

    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                header

                Group {
                    switch selectedTab {
                    case .home: feed
                    case .explore: explore
                    case .create: feed
                    case .activity: activity
                    case .profile: profile
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(contentVisible ? 1 : 0)
                .offset(y: contentVisible || reduceMotion ? 0 : 8)

                bottomNavigation
            }
            .opacity(splashVisible ? 0 : 1)
            .scaleEffect(splashVisible && !reduceMotion ? 0.985 : 1)

            if splashVisible {
                launchReveal
                    .transition(.opacity)
                    .zIndex(10)
            }

            if let toastMessage {
                VStack {
                    Spacer()
                    Text(toastMessage)
                        .font(.subheadline.weight(.medium))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 11)
                        .background(.regularMaterial, in: Capsule())
                        .overlay(Capsule().strokeBorder(Color.primary.opacity(0.08)))
                        .padding(.bottom, 82)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(20)
            }
        }
        .preferredColorScheme(nil)
        .task {
            try? await Task.sleep(for: .milliseconds(reduceMotion ? 180 : 900))
            withAnimation(reduceMotion ? nil : .easeOut(duration: 0.38)) {
                splashVisible = false
                contentVisible = true
            }
        }
        .sheet(isPresented: $showComposer) {
            ComposerView { message in
                showComposer = false
                showToast(message)
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showSettings) {
            settingsSheet
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .animation(.easeInOut(duration: 0.18), value: selectedTab)
        .animation(.snappy(duration: 0.22), value: feedMode)
        .animation(.snappy(duration: 0.22), value: selectedExploreCategory)
    }

    private var launchReveal: some View {
        ZStack {
            Color(uiColor: .systemBackground).ignoresSafeArea()
            ProgressView()
                .controlSize(.regular)
                .tint(PulseAccent.purple)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Loading PULSE")
    }

    private var header: some View {
        HStack(spacing: 12) {
            Text(headerTitle)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.primary)
                .contentTransition(.opacity)

            Spacer()

            if selectedTab != .explore {
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.primary)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Settings")
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .background(Color(uiColor: .systemBackground))
    }

    private var headerTitle: String {
        switch selectedTab {
        case .home: "PULSE"
        case .explore: "Explore"
        case .create: "PULSE"
        case .activity: "Activity"
        case .profile: "Profile"
        }
    }

    private var headerSubtitle: String {
        switch selectedTab {
        case .home: "Your world, in conversation."
        case .explore: "Find your next rabbit hole."
        case .create: "Share something with your world."
        case .activity: "The little things add up."
        case .profile: "Your corner of PULSE."
        }
    }

    private var feed: some View {
        ScrollView {
            VStack(spacing: 0) {
                feedSwitcher

                if feedMode == .following {
                    emptyFollowing
                } else {
                    HStack {
                        Label("A little bit of everything", systemImage: "sparkles")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("DEMO FEED")
                            .font(.system(size: 9, weight: .bold, design: .rounded))
                            .tracking(1.1)
                            .foregroundStyle(PulseAccent.purple)
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 5)
                    .padding(.bottom, 4)

                    ForEach(posts) { post in
                        postCard(post)
                    }

                    Text("You're all caught up")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.tertiary)
                        .padding(.vertical, 26)
                }
            }
            .padding(.bottom, 12)
        }
        .refreshable {
            try? await Task.sleep(for: .milliseconds(500))
            showToast("You're up to date")
        }
        .scrollIndicators(.hidden)
    }

    private var feedSwitcher: some View {
        HStack(spacing: 4) {
            ForEach(FeedMode.allCases, id: \.self) { mode in
                Button {
                    feedMode = mode
                } label: {
                    Text(mode.rawValue)
                        .font(.subheadline.weight(feedMode == mode ? .semibold : .medium))
                        .foregroundStyle(feedMode == mode ? .primary : .secondary)
                        .padding(.horizontal, 17)
                        .padding(.vertical, 9)
                        .background {
                            if feedMode == mode {
                                Capsule().fill(Color(uiColor: .secondarySystemBackground))
                                    .overlay(Capsule().strokeBorder(Color.primary.opacity(0.05)))
                            }
                        }
                }
                .buttonStyle(.plain)
            }
            Spacer()
            Button {
                showToast("Feed preferences are coming soon")
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.secondary)
                    .frame(width: 36, height: 36)
                    .background(Color(uiColor: .secondarySystemBackground), in: Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Feed preferences")
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 12)
    }

    private var emptyFollowing: some View {
        VStack(alignment: .leading, spacing: 18) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(colors: [PulseAccent.purple.opacity(0.14), PulseAccent.blue.opacity(0.10)], startPoint: .topLeading, endPoint: .bottomTrailing))
                Circle()
                    .stroke(PulseAccent.purple.opacity(0.25), lineWidth: 1)
                    .frame(width: 100, height: 100)
                Image(systemName: "person.2.wave.2")
                    .font(.system(size: 34, weight: .medium))
                    .foregroundStyle(PulseAccent.purple)
            }
            .frame(height: 150)

            VStack(alignment: .leading, spacing: 7) {
                Text("Your people, in order.")
                    .font(.title2.weight(.bold))
                Text("Follow a few accounts and their newest posts will show up here, newest first.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Button {
                selectedTab = .explore
            } label: {
                Label("Find people to follow", systemImage: "person.badge.plus")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(PulseAccent.purple, in: RoundedRectangle(cornerRadius: 15))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
        }
        .padding(18)
        .padding(.top, 10)
    }

    private func postCard(_ post: DemoPost) -> some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .top, spacing: 11) {
                AvatarView(symbol: post.avatarSymbol, colors: post.avatarColors, size: 44)

                VStack(alignment: .leading, spacing: 7) {
                    HStack(spacing: 5) {
                        Text(post.name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                        if post.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(PulseAccent.blue)
                        }
                        Text("@\(post.username)")
                            .lineLimit(1)
                        Text("· \(post.time)")
                            .fixedSize()
                        Spacer(minLength: 0)
                        Button {
                            showToast("Post options are a demo placeholder")
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.secondary)
                                .frame(width: 25, height: 25)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("More post options")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                    Text(post.text)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(2)

                    HStack(spacing: 6) {
                        Circle().fill(post.avatarColors.first ?? PulseAccent.purple).frame(width: 6, height: 6)
                        Text(post.topic)
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(Color(uiColor: .secondarySystemBackground), in: Capsule())
                    .padding(.top, 1)
                }
            }

            HStack(spacing: 0) {
                postAction(
                    symbol: likedPosts.contains(post.id) ? "heart.fill" : "heart",
                    count: compactCount(post.likes + (likedPosts.contains(post.id) ? 1 : 0)),
                    tint: likedPosts.contains(post.id) ? PulseAccent.pink : .secondary,
                    label: likedPosts.contains(post.id) ? "Unlike post" : "Like post"
                ) {
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.58)) {
                        if likedPosts.contains(post.id) { likedPosts.remove(post.id) }
                        else { likedPosts.insert(post.id) }
                    }
                }
                Spacer(minLength: 8)
                postAction(symbol: "bubble", count: compactCount(post.replies), label: "Replies") {
                    showToast("Replies are not connected yet")
                }
                Spacer(minLength: 8)
                postAction(symbol: "arrow.2.squarepath", count: compactCount(post.reposts), label: "Reposts") {
                    showToast("Reposting is not connected yet")
                }
                Spacer(minLength: 8)
                Button {
                    showToast("Share sheet is coming soon")
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.secondary)
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Share post")
            }
            .padding(.leading, 54)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.primary.opacity(0.065)).frame(height: 1)
        }
    }

    private func postAction(
        symbol: String,
        count: String,
        tint: Color = .secondary,
        label: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: symbol)
                    .font(.system(size: 15, weight: .medium))
                    .symbolEffect(.bounce, value: likedPosts.count)
                Text(count)
                    .font(.caption)
                    .monospacedDigit()
            }
            .foregroundStyle(tint)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(label), \(count)")
    }

    private var explore: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search people, posts, topics", text: $searchText)
                        .font(.subheadline)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill").foregroundStyle(.tertiary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 13)
                .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.primary.opacity(0.045)))

                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(exploreCategories, id: \.self) { category in
                            Button {
                                selectedExploreCategory = category
                            } label: {
                                Text(category)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(selectedExploreCategory == category ? Color.white : Color.secondary)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 9)
                                    .background {
                                        Capsule().fill(selectedExploreCategory == category ? PulseAccent.purple : Color(uiColor: .secondarySystemBackground))
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .scrollIndicators(.hidden)

                featuredCard

                sectionHeading("People you might like", subtitle: "A few good follows to start with")
                VStack(spacing: 0) {
                    ForEach(filteredPeople) { person in
                        personRow(person)
                    }
                }
                .padding(.horizontal, 13)
                .padding(.vertical, 4)
                .background(Color(uiColor: .secondarySystemBackground).opacity(0.72), in: RoundedRectangle(cornerRadius: 22))

                sectionHeading("What's moving", subtitle: "Topics picking up today")
                VStack(spacing: 0) {
                    trendRow(rank: "01", category: "TECH · TRENDING", title: "Tiny tools, big ideas", posts: "2.4K posts", colors: [PulseAccent.blue, PulseAccent.purple])
                    Divider().padding(.leading, 52)
                    trendRow(rank: "02", category: "GAMING · POPULAR", title: "What are you playing?", posts: "1.8K posts", colors: [PulseAccent.mint, PulseAccent.blue])
                    Divider().padding(.leading, 52)
                    trendRow(rank: "03", category: "DESIGN · RISING", title: "Details matter", posts: "940 posts", colors: [PulseAccent.pink, PulseAccent.purple])
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .background(Color(uiColor: .secondarySystemBackground).opacity(0.72), in: RoundedRectangle(cornerRadius: 22))
            }
            .padding(18)
            .padding(.bottom, 18)
        }
        .scrollIndicators(.hidden)
    }

    private var featuredCard: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(colors: [Color(red: 0.23, green: 0.19, blue: 0.57), PulseAccent.purple, PulseAccent.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            Circle()
                .stroke(.white.opacity(0.17), lineWidth: 1)
                .frame(width: 180, height: 180)
                .offset(x: 185, y: -52)
            Circle()
                .stroke(.white.opacity(0.13), lineWidth: 1)
                .frame(width: 125, height: 125)
                .offset(x: 220, y: -78)
            Circle()
                .fill(.white.opacity(0.07))
                .frame(width: 105, height: 105)
                .offset(x: 215, y: -20)

            VStack(alignment: .leading, spacing: 11) {
                HStack {
                    Label("THE PULSE PICK", systemImage: "sparkles")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.2)
                        .foregroundStyle(.white.opacity(0.82))
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.85))
                }
                Text("Good things start\nwith a conversation.")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .tracking(-0.6)
                    .foregroundStyle(.white)
                Text("Find your people. Follow your curiosity.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.82))
            }
            .padding(20)
        }
        .frame(height: 190)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .overlay(RoundedRectangle(cornerRadius: 25).strokeBorder(.white.opacity(0.14)))
    }

    private var filteredPeople: [DemoPerson] {
        guard !searchText.isEmpty else { return people }
        return people.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.username.localizedCaseInsensitiveContains(searchText) ||
            $0.detail.localizedCaseInsensitiveContains(searchText)
        }
    }

    private func personRow(_ person: DemoPerson) -> some View {
        HStack(spacing: 11) {
            AvatarView(symbol: person.symbol, colors: person.colors, size: 46)
            VStack(alignment: .leading, spacing: 3) {
                Text(person.name).font(.subheadline.weight(.semibold))
                Text("@\(person.username)").font(.caption).foregroundStyle(.secondary)
                Text(person.detail).font(.caption).foregroundStyle(.secondary).lineLimit(1)
            }
            Spacer(minLength: 5)
            Button {
                withAnimation(.snappy) {
                    if followedPeople.contains(person.id) { followedPeople.remove(person.id) }
                    else { followedPeople.insert(person.id) }
                }
            } label: {
                Text(followedPeople.contains(person.id) ? "Following" : "Follow")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(followedPeople.contains(person.id) ? Color.primary : Color.white)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 8)
                    .background(followedPeople.contains(person.id) ? Color(uiColor: .tertiarySystemFill) : PulseAccent.purple, in: Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 12)
    }

    private func trendRow(rank: String, category: String, title: String, posts: String, colors: [Color]) -> some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 40, height: 44)
                .overlay {
                    Text(rank)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
            VStack(alignment: .leading, spacing: 4) {
                Text(category)
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .tracking(0.8)
                    .foregroundStyle(.secondary)
                Text(title).font(.subheadline.weight(.semibold))
                Text(posts).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "arrow.up.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 12)
    }

    private var activity: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HStack(spacing: 8) {
                    activityFilter("All", selected: !showAllNotifications) { showAllNotifications = false }
                    activityFilter("Mentions", selected: showAllNotifications) { showAllNotifications = true }
                    Spacer()
                    Button {
                        showToast("You're all caught up")
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 17))
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Mark all as read")
                }

                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .foregroundStyle(PulseAccent.purple)
                    Text("You're in the loop")
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Text("DEMO")
                        .font(.system(size: 9, weight: .bold))
                        .tracking(1)
                        .foregroundStyle(.secondary)
                }
                .padding(14)
                .background(LinearGradient(colors: [PulseAccent.purple.opacity(0.11), PulseAccent.blue.opacity(0.07)], startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 16))

                Text("TODAY")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(.secondary)

                VStack(spacing: 0) {
                    ForEach(notifications) { item in
                        notificationRow(item)
                    }
                }

                HStack {
                    Spacer()
                    Text("That's everything for now.")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                    Spacer()
                }
                .padding(.top, 8)
            }
            .padding(18)
        }
        .scrollIndicators(.hidden)
    }

    private func activityFilter(_ title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(selected ? Color.white : Color.secondary)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(selected ? PulseAccent.purple : Color(uiColor: .secondarySystemBackground), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private func notificationRow(_ item: DemoNotification) -> some View {
        HStack(alignment: .top, spacing: 12) {
            AvatarView(symbol: item.symbol == "at" ? "person.fill" : item.symbol, colors: item.colors, size: 43)
                .overlay(alignment: .bottomTrailing) {
                    Image(systemName: item.symbol)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                        .background(PulseAccent.purple, in: Circle())
                        .overlay(Circle().stroke(Color(uiColor: .systemBackground), lineWidth: 2))
                        .offset(x: 3, y: 3)
                }
            VStack(alignment: .leading, spacing: 5) {
                (
                    Text(item.name).fontWeight(.semibold) +
                    Text(" \(item.action)").fontWeight(.regular)
                )
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                Text("@\(item.username) · \(item.time)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
            Circle().fill(PulseAccent.purple).frame(width: 7, height: 7).padding(.top, 7)
        }
        .padding(.vertical, 15)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.primary.opacity(0.06)).frame(height: 1)
        }
    }

    private var profile: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                profileBanner

                HStack(alignment: .top) {
                    ZStack {
                        Circle().fill(Color(uiColor: .systemBackground)).frame(width: 94, height: 94)
                        AvatarView(symbol: "sparkles", colors: [PulseAccent.purple, PulseAccent.pink], size: 84)
                            .overlay(Circle().stroke(Color(uiColor: .systemBackground), lineWidth: 3))
                    }
                    .offset(y: -35)
                    .padding(.bottom, -35)

                    Spacer()

                    Button {
                        showSettings = true
                    } label: {
                        Label("Edit profile", systemImage: "pencil")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 9)
                            .background(Color(uiColor: .secondarySystemBackground), in: Capsule())
                            .overlay(Capsule().strokeBorder(Color.primary.opacity(0.07)))
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 12)
                }
                .padding(.horizontal, 18)

                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 6) {
                        Text("Alex Morgan").font(.title2.weight(.bold))
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(PulseAccent.blue)
                    }
                    Text("@alexm")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Collecting little moments and interesting ideas. ✨")
                        .font(.subheadline)
                        .padding(.top, 7)
                    HStack(spacing: 5) {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Somewhere creative")
                        Text("·")
                        Image(systemName: "calendar")
                        Text("Joined September 2026")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)

                    HStack(spacing: 18) {
                        profileStat("248", label: "Following")
                        profileStat("1.2K", label: "Followers")
                    }
                    .padding(.top, 11)
                }
                .padding(.horizontal, 18)
                .padding(.top, 11)

                profileHighlights
                    .padding(.top, 19)

                HStack(spacing: 0) {
                    ForEach(profileSegments, id: \.self) { segment in
                        Button {
                            selectedProfileSegment = segment
                        } label: {
                            VStack(spacing: 10) {
                                Text(segment)
                                    .font(.subheadline.weight(selectedProfileSegment == segment ? .semibold : .medium))
                                    .foregroundStyle(selectedProfileSegment == segment ? .primary : .secondary)
                                Capsule()
                                    .fill(selectedProfileSegment == segment ? PulseAccent.purple : .clear)
                                    .frame(height: 3)
                            }
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 16)

                profileContent
            }
            .padding(.bottom, 20)
        }
        .scrollIndicators(.hidden)
    }

    private var profileBanner: some View {
        ZStack(alignment: .topTrailing) {
            LinearGradient(
                colors: [
                    Color(red: 0.22, green: 0.18, blue: 0.50),
                    PulseAccent.purple,
                    Color(red: 0.26, green: 0.63, blue: 0.79)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Layered details give the banner depth and tie it into the profile's color palette.
            Circle()
                .fill(.white.opacity(0.075))
                .frame(width: 200, height: 200)
                .offset(x: 52, y: -90)
            Circle()
                .stroke(.white.opacity(0.20), lineWidth: 1)
                .frame(width: 152, height: 152)
                .offset(x: 25, y: -49)
            Circle()
                .stroke(.white.opacity(0.12), lineWidth: 1)
                .frame(width: 105, height: 105)
                .offset(x: 25, y: -49)
            Ellipse()
                .fill(PulseAccent.mint.opacity(0.35))
                .frame(width: 150, height: 38)
                .blur(radius: 25)
                .rotationEffect(.degrees(-24))
                .offset(x: -45, y: 98)
            VStack(alignment: .leading, spacing: 5) {
                Text("A LITTLE SPACE TO BE YOU")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .tracking(1.5)
                    .foregroundStyle(.white.opacity(0.77))
                Text("Make room for wonder.")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.96))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(17)
        }
        .frame(height: 166)
        .clipped()
        .overlay(alignment: .bottom) {
            LinearGradient(colors: [.clear, .black.opacity(0.12)], startPoint: .top, endPoint: .bottom)
                .frame(height: 50)
        }
    }

    private var profileHighlights: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                highlight(title: "Little wins", symbol: "sun.max.fill", colors: [Color.orange, PulseAccent.pink])
                highlight(title: "My setup", symbol: "desktopcomputer", colors: [PulseAccent.blue, PulseAccent.purple])
                highlight(title: "Sketchbook", symbol: "scribble.variable", colors: [PulseAccent.mint, PulseAccent.blue])
                highlight(title: "Favorites", symbol: "heart.fill", colors: [PulseAccent.pink, PulseAccent.purple])
            }
            .padding(.horizontal, 18)
        }
        .scrollIndicators(.hidden)
    }

    private func highlight(title: String, symbol: String, colors: [Color]) -> some View {
        VStack(spacing: 7) {
            RoundedRectangle(cornerRadius: 19)
                .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 60, height: 60)
                .overlay {
                    Circle().stroke(.white.opacity(0.3), lineWidth: 1).padding(5)
                    Image(systemName: symbol)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white)
                }
                .overlay(RoundedRectangle(cornerRadius: 19).strokeBorder(Color.primary.opacity(0.08)))
            Text(title)
                .font(.caption2.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .frame(width: 72)
    }

    private func profileStat(_ count: String, label: String) -> some View {
        HStack(spacing: 4) {
            Text(count).font(.subheadline.weight(.bold)).foregroundStyle(.primary)
            Text(label).font(.subheadline).foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private var profileContent: some View {
        switch selectedProfileSegment {
        case "Posts":
            VStack(spacing: 0) {
                postCard(posts[0])
                postCard(posts[3])
            }
            .padding(.top, 4)
        case "Replies":
            profileEmptyState(symbol: "bubble.left.and.bubble.right", title: "Your replies live here", detail: "Conversations you join will show up on this tab.")
        case "Media":
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                mediaTile(symbol: "photo", title: "Creative moments", colors: [PulseAccent.purple, PulseAccent.blue])
                mediaTile(symbol: "gamecontroller.fill", title: "Play time", colors: [PulseAccent.blue, PulseAccent.mint])
                mediaTile(symbol: "scribble.variable", title: "Sketchbook", colors: [PulseAccent.pink, PulseAccent.purple])
                mediaTile(symbol: "music.note", title: "On repeat", colors: [Color.orange, PulseAccent.pink])
            }
            .padding(18)
        default:
            profileEmptyState(symbol: "heart", title: "Your likes, your taste", detail: "Posts you like will be collected here in the full app.")
        }
    }

    private func mediaTile(symbol: String, title: String, colors: [Color]) -> some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(height: 130)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 8) {
                    Image(systemName: symbol).font(.title2.weight(.medium))
                    Text(title).font(.caption.weight(.semibold))
                }
                .foregroundStyle(.white)
                .padding(13)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(LinearGradient(colors: [.clear, .black.opacity(0.35)], startPoint: .top, endPoint: .bottom), in: RoundedRectangle(cornerRadius: 18))
            }
    }

    private func profileEmptyState(symbol: String, title: String, detail: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.system(size: 27, weight: .light))
                .foregroundStyle(PulseAccent.purple)
                .frame(width: 60, height: 60)
                .background(PulseAccent.purple.opacity(0.10), in: Circle())
            Text(title).font(.headline)
            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 260)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 36)
        .padding(.horizontal, 22)
    }

    private func sectionHeading(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.title3.weight(.bold))
            Text(subtitle).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var bottomNavigation: some View {
        HStack(spacing: 0) {
            ForEach(PulseTab.allCases, id: \.self) { tab in
                Button {
                    if tab == .create {
                        showComposer = true
                    } else {
                        withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.18)) {
                            selectedTab = tab
                        }
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == tab ? tab.selectedSymbol : tab.symbol)
                            .font(.system(size: 22, weight: selectedTab == tab ? .semibold : .regular))
                            .symbolRenderingMode(.hierarchical)
                        Text(tab.rawValue)
                            .font(.system(size: 10, weight: selectedTab == tab ? .semibold : .regular))
                    }
                    .foregroundStyle(selectedTab == tab ? PulseAccent.purple : Color.secondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 49)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(selectedTab == tab ? .isSelected : [])
            }
        }
        .padding(.horizontal, 4)
        .padding(.top, 4)
        .background {
            Color(uiColor: .systemBackground)
                .overlay(alignment: .top) {
                    Rectangle().fill(Color(uiColor: .separator).opacity(0.45)).frame(height: 0.5)
                }
                .ignoresSafeArea(edges: .bottom)
        }
    }

    private var settingsSheet: some View {
        NavigationStack {
            List {
                Section("Your account") {
                    Label("Edit profile", systemImage: "person.crop.circle")
                    Label("Privacy and audience", systemImage: "hand.raised")
                    Label("Blocked and muted accounts", systemImage: "person.crop.circle.badge.xmark")
                }
                Section("Preferences") {
                    Label("Notifications", systemImage: "bell.badge")
                    Label("Feed preferences", systemImage: "slider.horizontal.3")
                    Label("Appearance", systemImage: "circle.lefthalf.filled")
                }
                Section {
                    Text("PULSE demo · 0.1.0")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("These settings are visual placeholders. Account and privacy controls aren't connected yet.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { showSettings = false }
                }
            }
        }
    }

    private func showToast(_ message: String) {
        withAnimation(.snappy) { toastMessage = message }
        Task {
            try? await Task.sleep(for: .seconds(1.8))
            withAnimation(.easeOut(duration: 0.2)) { toastMessage = nil }
        }
    }

    private func compactCount(_ count: Int) -> String {
        if count >= 1_000 {
            return String(format: "%.1fk", Double(count) / 1_000)
        }
        return String(count)
    }
}

private struct AvatarView: View {
    let symbol: String
    let colors: [Color]
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle().fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
            Circle()
                .stroke(.white.opacity(0.24), lineWidth: 1)
                .padding(size * 0.10)
            Circle()
                .fill(.white.opacity(0.10))
                .frame(width: size * 0.42, height: size * 0.42)
                .offset(x: size * 0.22, y: -size * 0.23)
            Image(systemName: symbol)
                .font(.system(size: size * 0.36, weight: .semibold))
                .foregroundStyle(.white)
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().strokeBorder(Color.primary.opacity(0.07)))
        .accessibilityHidden(true)
    }
}

private struct ComposerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var focused: Bool
    @State private var text = ""
    let onPost: (String) -> Void

    private let maximumLength = 2_000

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 17) {
                HStack(alignment: .top, spacing: 12) {
                    AvatarView(symbol: "sparkles", colors: [PulseAccent.purple, PulseAccent.pink], size: 44)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Alex Morgan").font(.subheadline.weight(.semibold))
                        Text("@alexm").font(.caption).foregroundStyle(.secondary)
                        TextField("What's happening?", text: $text, axis: .vertical)
                            .font(.title3)
                            .lineLimit(5...10)
                            .focused($focused)
                            .accessibilityLabel("Post text")
                            .onChange(of: text) { _, newValue in
                                if newValue.count > maximumLength {
                                    text = String(newValue.prefix(maximumLength))
                                }
                            }
                    }
                }

                HStack(spacing: 8) {
                    composerTool("photo", title: "Photo")
                    composerTool("number", title: "Poll")
                    composerTool("face.smiling", title: "Feeling")
                    Spacer()
                }

                Spacer()

                HStack {
                    Text("\(text.count)/\(maximumLength)")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(text.count > maximumLength - 100 ? PulseAccent.pink : .secondary)
                    Spacer()
                    Text("Demo only")
                        .font(.caption2.weight(.medium))
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
                    Button("Post") { onPost(text.trimmingCharacters(in: .whitespacesAndNewlines)) }
                        .fontWeight(.semibold)
                        .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func composerTool(_ symbol: String, title: String) -> some View {
        Button {
        } label: {
            Label(title, systemImage: symbol)
                .font(.caption.weight(.medium))
                .foregroundStyle(PulseAccent.purple)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(PulseAccent.purple.opacity(0.09), in: Capsule())
        }
        .buttonStyle(.plain)
    }
}
