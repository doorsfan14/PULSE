import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showMessage = false
    @State private var message = ""

    private var passwordsMatch: Bool {
        !password.isEmpty && password == confirmPassword
    }

    private var canSubmit: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        email.contains("@") &&
        password.count >= 8 &&
        passwordsMatch
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("PULSE")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .tracking(3)
                            .foregroundStyle(.tint)

                        Text("Create your account")
                            .font(.largeTitle.bold())
                            .tracking(-0.5)

                        Text("Join the conversation and share what's on your mind.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 28)

                    VStack(spacing: 18) {
                        inputField("Full name", placeholder: "Your name", text: $name, symbol: "person")
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)

                        inputField("Username", placeholder: "Choose a username", text: $username, symbol: "at")
                            .textContentType(.username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()

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
                            .padding(.horizontal, 14)
                            .frame(minHeight: 50)
                            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
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
                            .padding(.horizontal, 14)
                            .frame(minHeight: 50)
                            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))

                            if !confirmPassword.isEmpty && !passwordsMatch {
                                Text("Passwords don't match.")
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                            if !password.isEmpty && password.count < 8 {
                                Text("Use at least 8 characters.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    Button {
                        message = "The account creation UI is ready, but account registration isn't connected to a backend yet."
                        showMessage = true
                    } label: {
                        Text("Create account")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!canSubmit)

                    HStack(spacing: 5) {
                        Text("Already have an account?")
                            .foregroundStyle(.secondary)
                        Button("Sign in") {
                            message = "Sign-in UI can be added next. Authentication isn't connected yet."
                            showMessage = true
                        }
                        .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: 520)
                .frame(maxWidth: .infinity)
            }
            .background(Color(uiColor: .systemBackground))
            .toolbar(.hidden, for: .navigationBar)
            .alert("PULSE", isPresented: $showMessage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(message)
            }
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
            .padding(.horizontal, 14)
            .frame(minHeight: 50)
            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    ContentView()
}
