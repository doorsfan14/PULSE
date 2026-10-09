import SwiftUI

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
            .background(Color(uiColor: .systemBackground))
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
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()

            GeometryReader { geometry in
                Circle()
                    .fill(Color.accentColor.opacity(0.12))
                    .frame(width: 260, height: 260)
                    .blur(radius: 70)
                    .offset(x: geometry.size.width * 0.38, y: -90)

                Circle()
                    .fill(Color.purple.opacity(0.09))
                    .frame(width: 220, height: 220)
                    .blur(radius: 70)
                    .offset(x: -110, y: geometry.size.height * 0.38)
            }
            .ignoresSafeArea()
            .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 11) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color.accentColor, Color.accentColor.opacity(0.72)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 42, height: 42)
                        Image(systemName: "waveform")
                            .font(.system(size: 21, weight: .bold))
                            .foregroundStyle(.white)
                    }

                    Text("PULSE")
                        .font(.system(size: 19, weight: .heavy, design: .rounded))
                        .tracking(2.4)

                    Spacer()

                    Text("SOCIAL")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.5)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 11)
                        .padding(.vertical, 7)
                        .background(Color.secondary.opacity(0.09), in: Capsule())
                }
                .padding(.top, 12)

                Spacer(minLength: 32)

                ZStack {
                    RoundedRectangle(cornerRadius: 34, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.accentColor.opacity(0.17),
                                    Color.purple.opacity(0.10),
                                    Color.accentColor.opacity(0.04)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    Circle()
                        .stroke(Color.accentColor.opacity(0.16), lineWidth: 1)
                        .frame(width: 190, height: 190)

                    Circle()
                        .stroke(Color.accentColor.opacity(0.12), lineWidth: 1)
                        .frame(width: 138, height: 138)

                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.accentColor, Color.accentColor.opacity(0.72)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 92, height: 92)
                        .shadow(color: Color.accentColor.opacity(0.25), radius: 22, y: 10)

                    Image(systemName: "waveform")
                        .font(.system(size: 43, weight: .semibold))
                        .foregroundStyle(.white)

                    Circle()
                        .fill(Color(uiColor: .systemBackground))
                        .frame(width: 15, height: 15)
                        .overlay(Circle().stroke(Color.accentColor.opacity(0.45), lineWidth: 4))
                        .offset(x: 79, y: -63)

                    Circle()
                        .fill(Color.accentColor.opacity(0.8))
                        .frame(width: 8, height: 8)
                        .offset(x: -88, y: 49)
                }
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
                .padding(.bottom, 34)
                .accessibilityHidden(true)

                Text("Connect in\none place.")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .tracking(-1.7)
                    .lineSpacing(-2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 15)

                Text("Your conversations, your interests, your people — all together on PULSE.")
                    .font(.system(size: 17))
                    .foregroundStyle(.secondary)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 28)

                Button {
                    screen = .createAccount
                } label: {
                    HStack(spacing: 10) {
                        Text("Get started")
                        Image(systemName: "arrow.right")
                            .font(.subheadline.weight(.semibold))
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)

                Button {
                    screen = .signIn
                } label: {
                    HStack(spacing: 5) {
                        Text("Already on PULSE?")
                            .foregroundStyle(.secondary)
                        Text("Sign in")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.top, 5)
                .padding(.bottom, 10)
            }
            .padding(.horizontal, 25)
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
