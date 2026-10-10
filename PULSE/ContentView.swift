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
    @State private var ambientMotion = false
    @State private var titleTask: Task<Void, Never>?
    @StateObject private var motion = WelcomeMotionManager()

    private let welcomeTitle = "Welcome to PULSE"

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
            ZStack {
                switch screen {
                case .welcome:
                    welcomeScreen
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                case .createAccount:
                    createAccountScreen
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                case .signIn:
                    signInScreen
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar(.hidden, for: .navigationBar)
            .font(.custom("PlusJakartaSans-Regular", size: 17))
            .alert("PULSE", isPresented: $showMessage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(message)
            }
        }
        .preferredColorScheme(.dark)
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
                        x: -geometry.size.width * 0.34 + (ambientMotion ? 22 : -14),
                        y: -geometry.size.height * 0.31 + (ambientMotion ? -18 : 16)
                    )
                    .scaleEffect(ambientMotion ? 1.08 : 0.94)
                    .animation(.easeInOut(duration: 7.5).repeatForever(autoreverses: true), value: ambientMotion)

                Circle()
                    .fill(Color(red: 0.24, green: 0.58, blue: 0.98).opacity(0.13))
                    .frame(width: geometry.size.width * 0.68)
                    .blur(radius: 72)
                    .offset(
                        x: geometry.size.width * 0.40 + (ambientMotion ? -18 : 16),
                        y: geometry.size.height * 0.22 + (ambientMotion ? 20 : -14)
                    )
                    .scaleEffect(ambientMotion ? 0.93 : 1.07)
                    .animation(.easeInOut(duration: 9.0).repeatForever(autoreverses: true), value: ambientMotion)

                VStack(spacing: 0) {
                    Spacer(minLength: 0)

                    Text(typedTitle)
                        .font(.custom("PlusJakartaSans-Bold", size: 39))
                        .tracking(-1.35)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fixedSize(horizontal: false, vertical: true)
                        .shadow(color: Color(red: 0.35, green: 0.65, blue: 1).opacity(0.12), radius: 18)
                        .accessibilityLabel(welcomeTitle)

                    Spacer(minLength: 0)

                    VStack(spacing: 12) {
                        welcomeButton(title: "Create account", brighter: true) {
                            withAnimation(.spring(response: 0.78, dampingFraction: 0.90)) {
                                screen = .createAccount
                            }
                        }

                        welcomeButton(title: "Log in", brighter: false) {
                            withAnimation(.spring(response: 0.78, dampingFraction: 0.90)) {
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
                ambientMotion = true
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
                .font(.custom("PlusJakartaSans-SemiBold", size: 17))
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
                                        Color(red: 0.012, green: 0.020, blue: 0.043),
                                        Color(red: 0.032, green: 0.043, blue: 0.075)
                                    ]
                                    : [
                                        Color(red: 0.010, green: 0.016, blue: 0.036),
                                        Color(red: 0.023, green: 0.030, blue: 0.055)
                                    ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
                .overlay {
                    // Layered edge highlights mimic subtle glass refraction.
                    Capsule()
                        .strokeBorder(Color.white.opacity(0.055), lineWidth: 2.4)
                        .blur(radius: 2.2)
                        .padding(-1.2)

                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.20),
                                    Color(red: 0.62, green: 0.66, blue: 0.76).opacity(0.035),
                                    Color.white.opacity(0.10)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 0.55
                        )

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
        ZStack {
            PULSEBackdrop()

            ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                backButton
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Create your account")
                        .font(.custom("PlusJakartaSans-Bold", size: 34))
                        .tracking(-0.5)
                    Text("A few details and you're ready to get started.")
                        .foregroundStyle(.secondary)
                }
                .modifier(PULSEEntrance(delay: 0.06))

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
                            .font(.custom("PlusJakartaSans-Medium", size: 15))
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
                            .font(.custom("PlusJakartaSans-Medium", size: 15))
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
                .modifier(PULSEEntrance(delay: 0.12))

                Button {
                    showBackendNotice("Account registration")
                } label: {
                    Text("Create account")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 17))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                }
                .buttonStyle(PULSEPrimaryButtonStyle())
                .disabled(!canCreateAccount)
                .modifier(PULSEEntrance(delay: 0.20))

                separatorLabel("OR")

                passkeyButton(title: "Create account with a passkey", symbol: "person.badge.key.fill")

                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .foregroundStyle(.secondary)
                    Button("Sign in") {
                        withAnimation(.spring(response: 0.78, dampingFraction: 0.90)) {
                            screen = .signIn
                        }
                    }
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
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
            .scrollIndicators(.hidden)
        }
    }

    private var signInScreen: some View {
        ZStack {
            PULSEBackdrop()

            ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                backButton
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back")
                        .font(.custom("PlusJakartaSans-Bold", size: 34))
                        .tracking(-0.5)
                    Text("Pick up where you left off.")
                        .foregroundStyle(.secondary)
                }
                .modifier(PULSEEntrance(delay: 0.06))

                VStack(spacing: 17) {
                    inputField("Email address", placeholder: "you@example.com", text: $signInEmail, symbol: "envelope")
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.custom("PlusJakartaSans-Medium", size: 15))
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
                .modifier(PULSEEntrance(delay: 0.12))

                Button {
                    showBackendNotice("Sign in")
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                }
                .buttonStyle(PULSEPrimaryButtonStyle())
                .disabled(!isValidEmail(signInEmail) || signInPassword.isEmpty)
                .modifier(PULSEEntrance(delay: 0.18))

                separatorLabel("OR")

                passkeyButton(title: "Continue with a passkey", symbol: "person.badge.key.fill")

                HStack(spacing: 5) {
                    Text("New to PULSE?")
                        .foregroundStyle(.secondary)
                    Button("Create an account") {
                        withAnimation(.spring(response: 0.78, dampingFraction: 0.90)) {
                            screen = .createAccount
                        }
                    }
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
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
            .scrollIndicators(.hidden)
        }
    }

    private var backButton: some View {
        Button {
            withAnimation(.spring(response: 0.78, dampingFraction: 0.90)) {
                screen = .welcome
            }
        } label: {
            Label("Back", systemImage: "chevron.left")
                .font(.custom("PlusJakartaSans-Medium", size: 15))
                .foregroundStyle(.white.opacity(0.88))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.045), in: Capsule())
                .overlay(Capsule().stroke(Color.white.opacity(0.12), lineWidth: 0.7))
        }
        .buttonStyle(WelcomeBounceButtonStyle())
        .modifier(PULSEEntrance(delay: 0.02))
        .padding(.bottom, 4)
    }

    private func passkeyButton(title: String, symbol: String) -> some View {
        Button {
            showBackendNotice("Passkeys")
        } label: {
            Label(title, systemImage: symbol)
                .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                .foregroundStyle(.white.opacity(0.92))
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .contentShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(PULSESecondaryButtonStyle())
        .modifier(PULSEEntrance(delay: 0.28))
    }

    private func separatorLabel(_ title: String) -> some View {
        HStack(spacing: 12) {
            Rectangle().fill(Color.secondary.opacity(0.22)).frame(height: 1)
            Text(title)
                .font(.custom("PlusJakartaSans-SemiBold", size: 11))
                .tracking(2.2)
                .foregroundStyle(Color(red: 0.58, green: 0.70, blue: 0.88).opacity(0.78))
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
                .font(.custom("PlusJakartaSans-Medium", size: 15))
            HStack(spacing: 12) {
                Image(systemName: symbol)
                    .foregroundStyle(.secondary)
                    .frame(width: 20)
                TextField(placeholder, text: text)
            }
            .inputSurface()
                .animation(.easeInOut(duration: 0.22), value: text.wrappedValue)
        }
    }

    private func validationHint(_ text: String, color: Color = .secondary) -> some View {
        Text(text)
            .font(.custom("PlusJakartaSans-Regular", size: 12))
            .foregroundStyle(color)
            .transition(.opacity.combined(with: .move(edge: .top)))
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
            .padding(.horizontal, 15)
            .frame(minHeight: 54)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(0.045))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.17),
                                Color(red: 0.40, green: 0.63, blue: 0.98).opacity(0.12),
                                Color.white.opacity(0.055)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.8
                    )
            }
            .shadow(color: Color(red: 0.15, green: 0.38, blue: 0.85).opacity(0.06), radius: 16, y: 5)
    }
}


private struct PULSEBackdrop: View {
    @State private var drift = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.012, green: 0.018, blue: 0.045),
                        Color(red: 0.018, green: 0.027, blue: 0.064),
                        Color(red: 0.009, green: 0.014, blue: 0.034)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Circle()
                    .fill(Color(red: 0.10, green: 0.35, blue: 0.82).opacity(0.24))
                    .frame(width: geometry.size.width * 0.94)
                    .blur(radius: 78)
                    .offset(
                        x: -geometry.size.width * 0.36 + (drift ? 22 : -18),
                        y: -geometry.size.height * 0.30 + (drift ? -18 : 16)
                    )
                    .scaleEffect(drift ? 1.07 : 0.94)
                    .animation(.easeInOut(duration: 8.5).repeatForever(autoreverses: true), value: drift)

                Circle()
                    .fill(Color(red: 0.22, green: 0.53, blue: 0.98).opacity(0.15))
                    .frame(width: geometry.size.width * 0.76)
                    .blur(radius: 82)
                    .offset(
                        x: geometry.size.width * 0.42 + (drift ? -20 : 15),
                        y: geometry.size.height * 0.29 + (drift ? 22 : -15)
                    )
                    .scaleEffect(drift ? 0.94 : 1.06)
                    .animation(.easeInOut(duration: 10.5).repeatForever(autoreverses: true), value: drift)

                LinearGradient(
                    colors: [.clear, Color.black.opacity(0.14)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
        .onAppear { drift = true }
        .accessibilityHidden(true)
    }
}

private struct PULSEEntrance: ViewModifier {
    let delay: Double
    @State private var visible = false

    func body(content: Content) -> some View {
        content
            .opacity(visible ? 1 : 0)
            .offset(y: visible ? 0 : 12)
            .onAppear {
                withAnimation(.spring(response: 0.62, dampingFraction: 0.86).delay(delay)) {
                    visible = true
                }
            }
            .onDisappear { visible = false }
    }
}

private struct PULSEPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("PlusJakartaSans-SemiBold", size: 16))
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 17, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.15, green: 0.38, blue: 0.82),
                                Color(red: 0.20, green: 0.48, blue: 0.96)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: 17, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.38), Color.white.opacity(0.07)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.8
                    )
            }
            .shadow(
                color: Color(red: 0.16, green: 0.42, blue: 0.98).opacity(configuration.isPressed ? 0.12 : 0.25),
                radius: configuration.isPressed ? 7 : 18,
                y: configuration.isPressed ? 3 : 8
            )
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .opacity(isEnabled ? 1 : 0.42)
            .animation(.spring(response: 0.30, dampingFraction: 0.70), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.2), value: isEnabled)
    }
}

private struct PULSESecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(configuration.isPressed ? 0.085 : 0.04))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.white.opacity(configuration.isPressed ? 0.24 : 0.13), lineWidth: 0.8)
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.30, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
