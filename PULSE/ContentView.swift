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
        VStack(alignment: .leading, spacing: 0) {
            Spacer()

            Text("Connect in one place.")
                .font(.system(size: 39, weight: .bold, design: .rounded))
                .tracking(-1.6)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            VStack(spacing: 12) {
                Button {
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.76)) {
                        screen = .createAccount
                    }
                } label: {
                    Text("Create account")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .contentShape(Capsule())
                        .background {
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.025, green: 0.065, blue: 0.17),
                                            Color(red: 0.015, green: 0.035, blue: 0.105)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .overlay {
                            Capsule()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.22, green: 0.32, blue: 0.52).opacity(0.78),
                                            Color(red: 0.10, green: 0.17, blue: 0.32).opacity(0.92)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        }
                }
                .buttonStyle(.plain)

                Button {
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.76)) {
                        screen = .signIn
                    }
                } label: {
                    Text("Log in")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .contentShape(Capsule())
                        .background {
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.035, green: 0.075, blue: 0.19),
                                            Color(red: 0.012, green: 0.028, blue: 0.085)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .overlay {
                            Capsule()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.16, green: 0.25, blue: 0.43).opacity(0.72),
                                            Color(red: 0.075, green: 0.13, blue: 0.26).opacity(0.90)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        }
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: 320)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 22)

            Spacer()
                .frame(maxHeight: 18)
        }
        .padding(.horizontal, 28)
        .frame(maxWidth: 480)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
