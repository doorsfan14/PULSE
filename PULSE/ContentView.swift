import SwiftUI
import CoreMotion
import UIKit

private enum AuthScreen {
    case welcome
    case createAccount
    case signIn
}

struct ContentView: View {
    @State private var screen: AuthScreen = .welcome
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var signInEmail = ""
    @State private var signInPassword = ""
    @State private var showPassword = false
    @State private var showMessage = false
    @State private var message = ""
    @State private var typedTitle = ""
    @State private var titleTask: Task<Void, Never>?
    @StateObject private var motion = WelcomeMotionManager()

    private let welcomeTitle = "Connect in one place."

    private var passwordsMatch: Bool {
        !password.isEmpty && password == confirmPassword
    }

    private var canCreateAccount: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        isValidUsername(username) &&
        isValidEmail(email) &&
        password.count >= 8 &&
        passwordsMatch
    }

    var body: some View {
        NavigationStack {
            Group {
                switch screen {
                case .welcome:
                    welcomeScreen
                case .createAccount:
                    createAccountScreen
                case .signIn:
                    signInScreen
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .animation(.easeInOut(duration: 0.2), value: screen == .welcome)
            .alert("PULSE", isPresented: $showMessage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(message)
            }
        }
    }

    private var welcomeScreen: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.012, green: 0.018, blue: 0.045)
                    .ignoresSafeArea()

                // Soft ambient light fields drift with the device's motion.
                Circle()
                    .fill(Color(red: 0.10, green: 0.35, blue: 0.82).opacity(0.22))
                    .frame(width: geometry.size.width * 0.88)
                    .blur(radius: 78)
                    .offset(
                        x: -geometry.size.width * 0.34,
                        y: -geometry.size.height * 0.31
                    )

                Circle()
                    .fill(Color(red: 0.24, green: 0.58, blue: 0.98).opacity(0.13))
                    .frame(width: geometry.size.width * 0.68)
                    .blur(radius: 72)
                    .offset(
                        x: geometry.size.width * 0.40,
                        y: geometry.size.height * 0.22
                    )

                VStack(spacing: 0) {
                    Spacer(minLength: 0)

                    Text(typedTitle)
                        .font(.system(size: 39, weight: .bold, design: .default))
                        .tracking(-1.35)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fixedSize(horizontal: false, vertical: true)
                        .shadow(color: Color(red: 0.35, green: 0.65, blue: 1).opacity(0.12), radius: 18)
                        .accessibilityLabel(welcomeTitle)

                    Spacer(minLength: 0)

                    VStack(spacing: 12) {
                        welcomeButton(title: "Create account", brighter: true) {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.76)) {
                                screen = .createAccount
                            }
                        }

                        welcomeButton(title: "Log in", brighter: false) {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.76)) {
                                screen = .signIn
                            }
                        }
                    }
                    .frame(maxWidth: 320)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 22)

                    Spacer(minLength: 0)
                        .frame(maxHeight: 18)
                }
                .padding(.horizontal, 28)
                .frame(maxWidth: 480)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .onAppear {
                motion.start()
                startTypewriter()
            }
            .onDisappear {
                motion.stop()
                titleTask?.cancel()
            }
        }
        .ignoresSafeArea(.container, edges: .all)
    }

    private func welcomeButton(
        title: String,
        brighter: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold, design: .default))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .contentShape(Capsule())
                .background {
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: brighter
                                    ? [
                                        Color(red: 0.012, green: 0.027, blue: 0.075),
                                        Color(red: 0.035, green: 0.085, blue: 0.20)
                                    ]
                                    : [
                                        Color(red: 0.010, green: 0.020, blue: 0.060),
                                        Color(red: 0.025, green: 0.060, blue: 0.15)
                                    ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
                .overlay {
                    // A restrained rim light that shifts with device tilt.
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                stops: [
                                    .init(color: Color.white.opacity(0.18 + abs(motion.roll) * 0.13), location: 0),
                                    .init(color: Color(red: 0.48, green: 0.76, blue: 1).opacity(0.12 + abs(motion.pitch) * 0.18), location: 0.30),
                                    .init(color: Color.white.opacity(0.035), location: 0.68),
                                    .init(color: Color(red: 0.55, green: 0.80, blue: 1).opacity(0.12 + abs(motion.roll) * 0.16), location: 1)
                                ],
                                startPoint: UnitPoint(
                                    x: 0.5 + CGFloat(motion.roll) * 0.28,
                                    y: 0.0 + CGFloat(motion.pitch) * 0.12
                                ),
                                endPoint: UnitPoint(
                                    x: 0.5 - CGFloat(motion.roll) * 0.28,
                                    y: 1.0 - CGFloat(motion.pitch) * 0.12
                                )
                            ),
                            lineWidth: 0.8
                        )
                        .shadow(
                            color: Color(red: 0.28, green: 0.57, blue: 1).opacity(0.06),
                            radius: 3,
                            x: CGFloat(motion.roll) * 2,
                            y: CGFloat(motion.pitch) * 2
                        )
                }
        }
        .buttonStyle(WelcomeBounceButtonStyle())
    }

    private func startTypewriter() {
        titleTask?.cancel()
        typedTitle = ""
        titleTask = Task { @MainActor in
            for character in welcomeTitle {
                guard !Task.isCancelled else { return }
                typedTitle.append(character)
                let haptic = UIImpactFeedbackGenerator(style: .soft)
                haptic.prepare()
                haptic.impactOccurred(intensity: 0.35)
                try? await Task.sleep(for: .milliseconds(52))
            }
        }
    }

    private var createAccountScreen: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                backButton
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Create your account")
                        .font(.largeTitle.bold())
                        .tracking(-0.5)
                    Text("A few details and you're ready to get started.")
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 17) {
                    inputField("Full name", placeholder: "Your name", text: $name, symbol: "person")
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)

                    inputField("Username", placeholder: "Choose a username", text: $username, symbol: "at")
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    if !username.isEmpty && !isValidUsername(username) {
                        validationHint("Use 3–20 letters, numbers, or underscores.")
                    }

                    inputField("Email address", placeholder: "you@example.com", text: $email, symbol: "envelope")
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline.weight(.medium))
                        HStack(spacing: 12) {
                            Image(systemName: "lock")
                                .foregroundStyle(.secondary)
                                .frame(width: 20)
                            Group {
                                if showPassword {
                                    TextField("At least 8 characters", text: $password)
                                } else {
                                    SecureField("At least 8 characters", text: $password)
                                }
                            }
                            .textContentType(.newPassword)
                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(showPassword ? "Hide password" : "Show password")
                        }
                        .inputSurface()
                        if !password.isEmpty && password.count < 8 {
                            validationHint("Use at least 8 characters.")
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm password")
                            .font(.subheadline.weight(.medium))
                        HStack(spacing: 12) {
                            Image(systemName: "lock.shield")
                                .foregroundStyle(.secondary)
                                .frame(width: 20)
                            SecureField("Enter your password again", text: $confirmPassword)
                                .textContentType(.newPassword)
                        }
                        .inputSurface()
                        if !confirmPassword.isEmpty && !passwordsMatch {
                            validationHint("Passwords don't match.", color: .red)
                        }
                    }
                }

                Button {
                    showBackendNotice("Account registration")
                } label: {
                    Text("Create account")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!canCreateAccount)

                separatorLabel("OR")

                passkeyButton(title: "Create account with a passkey", symbol: "person.badge.key.fill")

                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .foregroundStyle(.secondary)
                    Button("Sign in") { screen = .signIn }
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)
        }
    }

    private var signInScreen: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                backButton
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back")
                        .font(.largeTitle.bold())
                    Text("Pick up where you left off.")
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 17) {
                    inputField("Email address", placeholder: "you@example.com", text: $signInEmail, symbol: "envelope")
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline.weight(.medium))
                        HStack(spacing: 12) {
                            Image(systemName: "lock")
                                .foregroundStyle(.secondary)
                                .frame(width: 20)
                            SecureField("Your password", text: $signInPassword)
                                .textContentType(.password)
                        }
                        .inputSurface()
                    }
                }

                Button {
                    showBackendNotice("Sign in")
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValidEmail(signInEmail) || signInPassword.isEmpty)

                separatorLabel("OR")

                passkeyButton(title: "Continue with a passkey", symbol: "person.badge.key.fill")

                HStack(spacing: 5) {
                    Text("New to PULSE?")
                        .foregroundStyle(.secondary)
                    Button("Create an account") { screen = .createAccount }
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)
        }
    }

    private var backButton: some View {
        Button {
            screen = .welcome
        } label: {
            Label("Back", systemImage: "chevron.left")
                .font(.body.weight(.medium))
        }
        .buttonStyle(.plain)
        .padding(.bottom, 4)
    }

    private func passkeyButton(title: String, symbol: String) -> some View {
        Button {
            showBackendNotice("Passkeys")
        } label: {
            Label(title, systemImage: symbol)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .contentShape(Rectangle())
        }
        .buttonStyle(.bordered)
    }

    private func separatorLabel(_ title: String) -> some View {
        HStack(spacing: 12) {
            Rectangle().fill(Color.secondary.opacity(0.22)).frame(height: 1)
            Text(title)
                .font(.caption.weight(.medium))
                .foregroundStyle(.tertiary)
            Rectangle().fill(Color.secondary.opacity(0.22)).frame(height: 1)
        }
    }

    private func inputField(
        _ title: String,
        placeholder: String,
        text: Binding<String>,
        symbol: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline.weight(.medium))
            HStack(spacing: 12) {
                Image(systemName: symbol)
                    .foregroundStyle(.secondary)
                    .frame(width: 20)
                TextField(placeholder, text: text)
            }
            .inputSurface()
        }
    }

    private func validationHint(_ text: String, color: Color = .secondary) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(color)
    }

    private func isValidEmail(_ value: String) -> Bool {
        let parts = value.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "@")
        return parts.count == 2 && parts[1].contains(".") && !parts[0].isEmpty
    }

    private func isValidUsername(_ value: String) -> Bool {
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_")
        return value.count >= 3 && value.count <= 20 && value.unicodeScalars.allSatisfy { allowed.contains($0) }
    }

    private func showBackendNotice(_ feature: String) {
        message = "\(feature) is designed in the interface, but it won't work until PULSE is connected to an authentication backend. Passkeys also need server-generated challenges and a registered relying-party domain."
        showMessage = true
    }
}

private struct WelcomeBounceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(
                .spring(response: 0.26, dampingFraction: 0.48),
                value: configuration.isPressed
            )
    }
}

private final class WelcomeMotionManager: ObservableObject {
    @Published var roll: Double = 0
    @Published var pitch: Double = 0

    private let manager = CMMotionManager()
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.azure.pulse.welcome-motion"
        queue.qualityOfService = .userInteractive
        return queue
    }()

    func start() {
        guard manager.isDeviceMotionAvailable, !manager.isDeviceMotionActive else { return }
        manager.deviceMotionUpdateInterval = 1.0 / 30.0
        manager.startDeviceMotionUpdates(to: queue) { [weak self] motion, _ in
            guard let motion else { return }
            let nextRoll = max(-1.0, min(1.0, motion.attitude.roll))
            let nextPitch = max(-1.0, min(1.0, motion.attitude.pitch))
            DispatchQueue.main.async {
                self?.roll = nextRoll
                self?.pitch = nextPitch
            }
        }
    }

    func stop() {
        manager.stopDeviceMotionUpdates()
    }
}

private extension View {
    func inputSurface() -> some View {
        self
            .padding(.horizontal, 14)
            .frame(minHeight: 50)
            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ContentView()
}
