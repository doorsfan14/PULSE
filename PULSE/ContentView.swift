private enum PULSELocalization {
 static var lang: String { let c = Locale.preferredLanguages.first.map { String($0.prefix(2)) } ?? "en"; return ["es","fr","pt","de","zh","ja","ko","ar","hi"].contains(c) ? c : "en" }
 static let map: [String:[String:String]] = [
 "Terms Of Service":["es":"Términos del servicio","fr":"Conditions d’utilisation","pt":"Termos de serviço","de":"Nutzungsbedingungen","zh":"服务条款","ja":"利用規約","ko":"서비스 약관","ar":"شروط الخدمة","hi":"सेवा की शर्तें"],
 "Privacy Policy":["es":"Política de privacidad","fr":"Politique de confidentialité","pt":"Política de privacidade","de":"Datenschutzerklärung","zh":"隐私政策","ja":"プライバシーポリシー","ko":"개인정보 처리방침","ar":"سياسة الخصوصية","hi":"गोपनीयता नीति"],
 "Create account":["es":"Crear cuenta","fr":"Créer un compte","pt":"Criar conta","de":"Konto erstellen","zh":"创建账户","ja":"アカウントを作成","ko":"계정 만들기","ar":"إنشاء حساب","hi":"खाता बनाएँ"],
 "Log in":["es":"Iniciar sesión","fr":"Se connecter","pt":"Entrar","de":"Anmelden","zh":"登录","ja":"ログイン","ko":"로그인","ar":"تسجيل الدخول","hi":"लॉग इन करें"],
 "Full name":["es":"Nombre completo","fr":"Nom complet","pt":"Nome completo","de":"Vollständiger Name","zh":"姓名","ja":"氏名","ko":"이름","ar":"الاسم الكامل","hi":"पूरा नाम"],
 "Username":["es":"Nombre de usuario","fr":"Nom d’utilisateur","pt":"Nome de usuário","de":"Benutzername","zh":"用户名","ja":"ユーザー名","ko":"사용자 이름","ar":"اسم المستخدم","hi":"उपयोगकर्ता नाम"],
 "Email address":["es":"Correo electrónico","fr":"Adresse e-mail","pt":"E-mail","de":"E-Mail-Adresse","zh":"电子邮件地址","ja":"メールアドレス","ko":"이메일 주소","ar":"البريد الإلكتروني","hi":"ईमेल पता"],
 "Password":["es":"Contraseña","fr":"Mot de passe","pt":"Senha","de":"Passwort","zh":"密码","ja":"パスワード","ko":"비밀번호","ar":"كلمة المرور","hi":"पासवर्ड"],
 "Confirm password":["es":"Confirmar contraseña","fr":"Confirmer le mot de passe","pt":"Confirmar senha","de":"Passwort bestätigen","zh":"确认密码","ja":"パスワードを確認","ko":"비밀번호 확인","ar":"تأكيد كلمة المرور","hi":"पासवर्ड की पुष्टि करें"],
 "Welcome back":["es":"Bienvenido de nuevo","fr":"Heureux de vous revoir","pt":"Boas-vindas de volta","de":"Willkommen zurück","zh":"欢迎回来","ja":"おかえりなさい","ko":"다시 오신 것을 환영합니다","ar":"مرحبًا بعودتك","hi":"वापसी पर स्वागत है"],
 "Sign in":["es":"Iniciar sesión","fr":"Se connecter","pt":"Entrar","de":"Anmelden","zh":"登录","ja":"サインイン","ko":"로그인","ar":"تسجيل الدخول","hi":"साइन इन करें"],
 "Create an account":["es":"Crear una cuenta","fr":"Créer un compte","pt":"Criar uma conta","de":"Konto erstellen","zh":"创建账户","ja":"アカウントを作成","ko":"계정 만들기","ar":"إنشاء حساب","hi":"खाता बनाएँ"],
 "Back":["es":"Atrás","fr":"Retour","pt":"Voltar","de":"Zurück","zh":"返回","ja":"戻る","ko":"뒤로","ar":"رجوع","hi":"वापस"],
 "Done":["es":"Listo","fr":"Terminé","pt":"Concluído","de":"Fertig","zh":"完成","ja":"完了","ko":"완료","ar":"تم","hi":"हो गया"],
 "OK":["es":"Aceptar","fr":"OK","pt":"OK","de":"OK","zh":"确定","ja":"OK","ko":"확인","ar":"حسنًا","hi":"ठीक है"]
 ];
 static func t(_ key:String)->String { map[key]?[lang] ?? key }
}
private func L(_ key:String)->String { PULSELocalization.t(key) }

import SwiftUI
import CoreMotion
import UIKit

private enum AuthScreen {
    case welcome
    case createAccount
    case signIn
}

private enum LegalDocument: String, Identifiable {
    case terms
    case privacyPolicy

    var id: String { rawValue }
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
    @State private var activeLegalDocument: LegalDocument?
    @State private var usernameAvailabilityMessage = ""
    @State private var usernameAvailabilityIsError = false
    @State private var message = ""
    @State private var typedTitle = ""
    @State private var ambientMotion = false
    @State private var titleTask: Task<Void, Never>?
    @StateObject private var motion = WelcomeMotionManager()

    private let welcomeTitle = L("Welcome to PULSE")

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
                Button(L("OK"), role: .cancel) { }
            } message: {
                Text(message)
            }
            .sheet(item: $activeLegalDocument) { document in
                Group {
                    switch document {
                    case .terms:
                        termsSheet
                    case .privacyPolicy:
                        privacyPolicySheet
                    }
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
        .preferredColorScheme(.dark)
    }

    private var welcomeScreen: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.012, green: 0.018, blue: 0.045)
                    .ignoresSafeArea()

                Canvas { context, size in
                    var grid = Path()
                    let step: CGFloat = 34
                    stride(from: CGFloat(0), through: size.width, by: step).forEach { x in
                        grid.move(to: CGPoint(x: x, y: 0))
                        grid.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    stride(from: CGFloat(0), through: size.height, by: step).forEach { y in
                        grid.move(to: CGPoint(x: 0, y: y))
                        grid.addLine(to: CGPoint(x: size.width, y: y))
                    }
                    context.stroke(grid, with: .color(.white.opacity(0.022)), lineWidth: 0.5)
                    for index in 0..<34 {
                        let x = CGFloat((index * 83 + 31) % 997) / 997 * size.width
                        let y = CGFloat((index * 137 + 59) % 991) / 991 * size.height
                        let diameter: CGFloat = index % 5 == 0 ? 2.4 : 1.2
                        let dot = Path(ellipseIn: CGRect(x: x, y: y, width: diameter, height: diameter))
                        context.fill(dot, with: .color(Color(red: 0.45, green: 0.68, blue: 1).opacity(index % 5 == 0 ? 0.30 : 0.12)))
                    }
                }
                .ignoresSafeArea()
                .accessibilityHidden(true)

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

                    HStack(spacing: 9) {
                        Button {
                            activeLegalDocument = .terms
                        } label: {
                            Text(L("Terms Of Service"))
                                .font(.custom("PlusJakartaSans-Medium", size: 12))
                                .foregroundStyle(.white.opacity(0.76))
                        }
                        .buttonStyle(.plain)

                        Text("•")
                            .font(.custom("PlusJakartaSans-Regular", size: 12))
                            .foregroundStyle(.white.opacity(0.38))

                        Button {
                            activeLegalDocument = .privacyPolicy
                        } label: {
                            Text(L("Privacy Policy"))
                                .font(.custom("PlusJakartaSans-Medium", size: 12))
                                .foregroundStyle(.white.opacity(0.76))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.bottom, 18)
                    .modifier(PULSEEntrance(delay: 0.16))

                    VStack(spacing: 12) {
                        welcomeButton(title: L("Create account"), brighter: true) {
                            withAnimation(.spring(response: 0.78, dampingFraction: 0.90)) {
                                screen = .createAccount
                            }
                        }

                        welcomeButton(title: L("Log in"), brighter: false) {
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
                    inputField(L("Full name"), placeholder: L("Your name"), text: $name, symbol: "person")
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)

                    inputField(L("Username"), placeholder: L("Choose a username"), text: $username, symbol: "at")
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onChange(of: username) { _, newValue in
                            updateUsernameAvailabilityMessage(newValue)
                        }

                    if !username.isEmpty && !isValidUsername(username) {
                        validationHint("Use 3–20 letters, numbers, or underscores.")
                    } else if !username.isEmpty && !usernameAvailabilityMessage.isEmpty {
                        HStack(spacing: 6) {
                            Image(systemName: usernameAvailabilityIsError ? "info.circle" : "checkmark.circle")
                            Text(usernameAvailabilityMessage)
                        }
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(usernameAvailabilityIsError ? Color.orange : Color(red: 0.52, green: 0.78, blue: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 2)
                    }

                    inputField(L("Email address"), placeholder: "you@example.com", text: $email, symbol: "envelope")
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(L("Password"))
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
                        Text(L("Confirm password"))
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
                    Text(L("Create account"))
                        .font(.custom("PlusJakartaSans-SemiBold", size: 17))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                }
                .buttonStyle(PULSEPrimaryButtonStyle())
                .disabled(!canCreateAccount)
                .modifier(PULSEEntrance(delay: 0.20))

                HStack(spacing: 4) {
                    Text("By continuing, you agree to our")
                        .foregroundStyle(.secondary)
                    Button("Terms of Service") {
                        activeLegalDocument = .terms
                    }
                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                    .foregroundStyle(Color(red: 0.48, green: 0.68, blue: 1))
                    .buttonStyle(.plain)
                }
                .font(.custom("PlusJakartaSans-Regular", size: 12))
                .frame(maxWidth: .infinity)
                .modifier(PULSEEntrance(delay: 0.22))

                separatorLabel("OR")
                    .modifier(PULSEEntrance(delay: 0.24))

                passkeyButton(title: "Create account with a passkey", symbol: "person.badge.key.fill")

                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .foregroundStyle(.secondary)
                    Button(L("Sign in")) {
                        withAnimation(.spring(response: 0.78, dampingFraction: 0.90)) {
                            screen = .signIn
                        }
                    }
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                }
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
                .modifier(PULSEEntrance(delay: 0.34))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)
            }
            .scrollIndicators(.hidden)
        }
    }


    private func termsSection(_ heading: String, _ body: String) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(heading)
                .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)

            Text(body)
                .termsParagraph()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var termsSheet: some View {
        legalDocumentSheet(title: "Terms of Service", subtitle: "Effective October 9, 2026") {
            Text("Welcome to PULSE. These Terms of Service govern your access to and use of PULSE. By using PULSE, you agree to these Terms. If you do not agree, do not use the service.")
                .termsParagraph()
            termsSection("1. Eligibility", "You must be at least 13 years old, or the higher minimum age required where you live. If you are under the age of legal majority, you must have any parent or guardian permission required by applicable law. You are responsible for using PULSE in compliance with the laws that apply to you.")
            termsSection("2. Accounts and security", "Provide accurate information, keep your account credentials secure, and promptly notify us of suspected unauthorized access. Do not impersonate another person, use a username you have no right to use, or create accounts to evade a restriction. You are responsible for activity conducted through your account, except where applicable law provides otherwise.")
            termsSection("3. Your content", "You retain ownership of content you create and submit, to the extent permitted by law. You grant PULSE a non-exclusive, worldwide, royalty-free license to host, store, reproduce, adapt for technical compatibility, and display that content only as reasonably necessary to operate, maintain, secure, and provide PULSE. This license ends when your content is deleted from active systems, except for limited retention in backups, security records, dispute resolution, or where law requires or permits retention. You represent that you have the rights needed to share your content.")
            termsSection("4. Public content and interactions", "You are responsible for choosing what to share and for understanding the audience indicated by the relevant feature and settings. Content shared publicly may be viewed, copied, or redistributed by others. Removing content from PULSE cannot guarantee removal of copies already saved or shared by other users.")
            termsSection("5. Acceptable use", "You may not use PULSE to harass, threaten, stalk, exploit or endanger minors, unlawfully disclose private information, infringe intellectual-property or other rights, distribute scams or spam, impersonate others, publish unlawful threats, attack or disrupt the service, access information without authorization, manipulate engagement deceptively, or use automation in ways that abuse or interfere with PULSE.")
            termsSection("6. Safety and enforcement", "We may review reports and take proportionate action when content or conduct violates these Terms, threatens user safety, compromises security, or creates legal risk. Actions may include content removal, feature restrictions, account suspension, or termination. Where appropriate and required by law, we may provide notice and a way to appeal. We cannot guarantee that every item of content will be reviewed or that all harmful activity will be detected.")
            termsSection("7. Privacy", "Our collection and use of personal information are described in the PULSE Privacy Policy, which explains how information is handled, shared, retained, and how you can exercise applicable privacy rights. PULSE does not sell users' personal information.")
            termsSection("8. Availability and changes", "We may update, modify, suspend, or discontinue parts of PULSE for operational, security, legal, or product reasons. We aim to keep the service reliable but do not guarantee uninterrupted or error-free operation. We will provide notice or obtain consent for material changes where required by law.")
            termsSection("9. Suspension and termination", "You may stop using PULSE at any time. We may restrict or terminate access for violations of these Terms, security concerns, safety risks, legal requirements, or conduct that threatens users or the service. Where account deletion is available, the applicable process and data-retention rules are described in the Privacy Policy. Provisions that by their nature should survive termination will continue to apply.")
            termsSection("10. Disclaimers", "To the extent permitted by law, PULSE is provided on an 'as available' basis. We do not promise that the service will always meet every need, remain uninterrupted, or be free of errors. Nothing in these Terms excludes warranties, rights, or remedies that cannot legally be excluded.")
            termsSection("11. Limitation of liability", "To the extent permitted by applicable law, PULSE and its operator will not be liable for indirect, incidental, special, consequential, or punitive losses arising from use of the service. Nothing in these Terms limits liability where doing so would be unlawful, including liability that cannot legally be limited.")
            termsSection("12. Governing law and disputes", "The governing law and dispute-resolution process will be identified by the operator in the version applicable to your location, subject to mandatory consumer protections and other non-waivable rights under applicable law.")
            termsSection("13. Contact", "For questions about these Terms, contact the PULSE team using the official contact details published by PULSE.")
        }
    }

    private var privacyPolicySheet: some View {
        legalDocumentSheet(title: "Privacy Policy", subtitle: "Effective October 9, 2026") {
            Text("PULSE respects your privacy. This Privacy Policy explains how personal information is collected, used, stored, and shared when you use PULSE.")
                .termsParagraph()
            termsSection("1. Information you provide", "Depending on the features you use, information may include your name, username, email address, profile details, posts, comments, media, support requests, reports, and preferences. Avoid including sensitive personal information in public posts or profile fields.")
            termsSection("2. Technical information", "When you access PULSE, we may process technical information needed to operate and secure the service, such as app and operating-system versions, device information, connection data, diagnostic events, and security logs. The information actually collected depends on the systems used to operate PULSE.")
            termsSection("3. How we use information", "We use information to provide requested features, maintain accounts, display content to intended audiences, protect accounts and the platform, prevent spam and fraud, investigate reports, respond to support requests, troubleshoot problems, improve reliability, enforce our Terms, and comply with applicable law.")
            termsSection("4. Public content", "Your username, profile details, posts, comments, and other interactions may be visible to the audiences permitted by the relevant features and settings. Other users may copy or share content they can access. Deleting a post cannot remove copies already made by other users.")
            termsSection("5. How information is shared", "PULSE does not sell users' personal information. Information may be shared with service providers that help operate the service, with people you choose to share content with, when reasonably necessary to protect users or security, when required by valid legal process, or in connection with a business transfer subject to appropriate safeguards and applicable law.")
            termsSection("6. Service providers", "Providers supporting hosting, storage, authentication, security, diagnostics, and support may process information on PULSE's behalf. Their access should be limited to what is necessary for their work and governed by appropriate agreements and safeguards.")
            termsSection("7. Security", "We use reasonable administrative, technical, and organizational measures designed to protect personal information against unauthorized access, loss, alteration, and disclosure. No internet-based service can guarantee absolute security.")
            termsSection("8. Retention and deletion", "We retain information for as long as reasonably necessary for the purposes described in this Policy, including security, dispute resolution, and legal compliance. When information is no longer needed, we delete it, anonymize it, or securely dispose of it as appropriate. Backup copies may remain until they are overwritten or removed.")
            termsSection("9. Your choices and rights", "Depending on your location, you may have rights to request access to, correction of, or deletion of your information, withdraw consent, object to certain processing, request a portable copy, or complain to a data protection authority. Contact PULSE through its published privacy contact to submit a request. We may need to verify your identity and may apply lawful exceptions.")
            termsSection("10. Children and teens", "PULSE is intended for people who meet the minimum age requirements in the Terms of Service and applicable law. We do not knowingly process children's personal information in circumstances where doing so is prohibited or required consent has not been obtained. Where applicable law provides additional protections for minors, those protections apply.")
            termsSection("11. International processing", "Information may be processed or stored in countries other than where you live. Where required by law, appropriate safeguards will be used for international transfers.")
            termsSection("12. Third-party services", "PULSE may link to or integrate with third-party services. Those services have their own privacy practices and policies, which we encourage you to review before sharing information with them.")
            termsSection("13. Policy changes", "We may update this Policy as our service or legal obligations change. We will update the effective date and provide additional notice or obtain consent where required by law.")
            termsSection("14. Contact", "For privacy questions or requests, use the official PULSE privacy contact published by the service.")
        }
    }

    private func legalDocumentSheet<Content: View>(
        title: String,
        subtitle: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("PULSE")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                            .tracking(2.5)
                            .foregroundStyle(Color(red: 0.48, green: 0.68, blue: 1))
                        Text(title)
                            .font(.custom("PlusJakartaSans-Bold", size: 30))
                            .tracking(-0.7)
                        Text(subtitle)
                            .font(.custom("PlusJakartaSans-Regular", size: 12))
                            .foregroundStyle(.secondary)
                    }
                    content()
                }
                .padding(24)
                .frame(maxWidth: 620, alignment: .leading)
                .frame(maxWidth: .infinity)
            }
            .scrollIndicators(.hidden)
            .background(PULSEBackdrop())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(L("Done")) { activeLegalDocument = nil }
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private var signInScreen: some View {
        ZStack {
            PULSEBackdrop()

            ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                backButton
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text(L("Welcome back"))
                        .font(.custom("PlusJakartaSans-Bold", size: 34))
                        .tracking(-0.5)
                    Text("Pick up where you left off.")
                        .foregroundStyle(.secondary)
                }
                .modifier(PULSEEntrance(delay: 0.06))

                VStack(spacing: 17) {
                    inputField(L("Email address"), placeholder: "you@example.com", text: $signInEmail, symbol: "envelope")
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(L("Password"))
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
                        .font(.custom("PlusJakartaSans-SemiBold", size: 17))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                }
                .buttonStyle(PULSEPrimaryButtonStyle())
                .disabled(!isValidEmail(signInEmail) || signInPassword.isEmpty)
                .modifier(PULSEEntrance(delay: 0.18))

                separatorLabel("OR")
                    .modifier(PULSEEntrance(delay: 0.24))

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
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                .modifier(PULSEEntrance(delay: 0.34))
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
            Label(L("Back"), systemImage: "chevron.left")
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

    private func updateUsernameAvailabilityMessage(_ value: String) {
        guard !value.isEmpty else {
            usernameAvailabilityMessage = ""
            usernameAvailabilityIsError = false
            return
        }
        guard isValidUsername(value) else {
            usernameAvailabilityMessage = ""
            usernameAvailabilityIsError = true
            return
        }
        usernameAvailabilityMessage = "Format looks good. Unique availability must be confirmed by the account service."
        usernameAvailabilityIsError = true
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



private extension Text {
    func termsParagraph() -> some View {
        self
            .font(.custom("PlusJakartaSans-Regular", size: 14))
            .foregroundStyle(.white.opacity(0.78))
            .lineSpacing(4)
            .fixedSize(horizontal: false, vertical: true)
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

                Canvas { context, size in
                    var grid = Path()
                    let step: CGFloat = 38
                    stride(from: CGFloat(0), through: size.width, by: step).forEach { x in
                        grid.move(to: CGPoint(x: x, y: 0))
                        grid.addLine(to: CGPoint(x: x, y: size.height))
                    }
                    stride(from: CGFloat(0), through: size.height, by: step).forEach { y in
                        grid.move(to: CGPoint(x: 0, y: y))
                        grid.addLine(to: CGPoint(x: size.width, y: y))
                    }
                    context.stroke(grid, with: .color(.white.opacity(0.018)), lineWidth: 0.5)
                    for index in 0..<26 {
                        let x = CGFloat((index * 113 + 17) % 991) / 991 * size.width
                        let y = CGFloat((index * 167 + 43) % 983) / 983 * size.height
                        let sizeDot: CGFloat = index % 4 == 0 ? 2.2 : 1.1
                        context.fill(
                            Path(ellipseIn: CGRect(x: x, y: y, width: sizeDot, height: sizeDot)),
                            with: .color(Color(red: 0.48, green: 0.70, blue: 1).opacity(index % 4 == 0 ? 0.22 : 0.09))
                        )
                    }
                }

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
