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
 "OK":["es":"Aceptar","fr":"OK","pt":"OK","de":"OK","zh":"确定","ja":"OK","ko":"확인","ar":"حسنًا","hi":"ठीक है"],
 "Create your account": {"es": "Crea tu cuenta", "fr": "Créez votre compte", "pt": "Crie sua conta", "de": "Erstelle dein Konto", "zh": "创建你的账户", "ja": "アカウントを作成", "ko": "계정 만들기", "ar": "أنشئ حسابك", "hi": "अपना खाता बनाएँ"},
 "Already have an account?": {"es": "¿Ya tienes una cuenta?", "fr": "Vous avez déjà un compte ?", "pt": "Já tem uma conta?", "de": "Hast du bereits ein Konto?", "zh": "已有账户？", "ja": "すでにアカウントをお持ちですか？", "ko": "이미 계정이 있나요?", "ar": "هل لديك حساب بالفعل؟", "hi": "क्या आपके पास पहले से खाता है؟"},
 "By continuing, you agree to our": {"es": "Al continuar, aceptas nuestros", "fr": "En continuant, vous acceptez nos", "pt": "Ao continuar, você concorda com nossos", "de": "Wenn du fortfährst, stimmst du unseren", "zh": "继续即表示你同意我们的", "ja": "続行すると、以下に同意したものとみなされます：", "ko": "계속하면 다음에 동의하는 것입니다:", "ar": "بالمتابعة، فإنك توافق على", "hi": "जारी रखने पर आप हमारी"},
 "Terms of Service": {"es": "Términos del servicio", "fr": "Conditions d’utilisation", "pt": "Termos de serviço", "de": "Nutzungsbedingungen", "zh": "服务条款", "ja": "利用規約", "ko": "서비스 약관", "ar": "شروط الخدمة", "hi": "सेवा की शर्तें"},
 "Use 3–20 letters, numbers, or underscores.": {"es": "Usa entre 3 y 20 letras, números o guiones bajos.", "fr": "Utilisez 3 à 20 lettres, chiffres ou traits de soulignement.", "pt": "Use de 3 a 20 letras, números ou sublinhados.", "de": "Verwende 3–20 Buchstaben, Zahlen oder Unterstriche.", "zh": "使用 3–20 个字母、数字或下划线。", "ja": "3〜20文字の英字、数字、またはアンダースコアを使用してください。", "ko": "영문자, 숫자 또는 밑줄을 3~20자 사용하세요.", "ar": "استخدم من 3 إلى 20 حرفًا أو رقمًا أو شرطة سفلية.", "hi": "3–20 अक्षर, अंक या अंडरस्कोर इस्तेमाल करें।"},
 "Enter your password again": {"es": "Vuelve a introducir tu contraseña", "fr": "Saisissez à nouveau votre mot de passe", "pt": "Digite sua senha novamente", "de": "Gib dein Passwort erneut ein", "zh": "再次输入密码", "ja": "パスワードをもう一度入力", "ko": "비밀번호를 다시 입력하세요", "ar": "أدخل كلمة المرور مرة أخرى", "hi": "अपना पासवर्ड फिर से दर्ज करें"},
 "Your password": {"es": "Tu contraseña", "fr": "Votre mot de passe", "pt": "Sua senha", "de": "Dein Passwort", "zh": "你的密码", "ja": "パスワード", "ko": "비밀번호", "ar": "كلمة المرور", "hi": "आपका पासवर्ड"},
 "Effective October 9, 2026": {"es": "Vigente desde el 9 de octubre de 2026", "fr": "En vigueur le 9 octobre 2026", "pt": "Em vigor em 9 de outubro de 2026", "de": "Gültig ab 9. Oktober 2026", "zh": "生效日期：2026年10月9日", "ja": "2026年10月9日発効", "ko": "2026년 10월 9일 시행", "ar": "ساري اعتبارًا من 9 أكتوبر 2026", "hi": "9 अक्टूबर 2026 से प्रभावी"},
 "1. Eligibility": {"es": "1. Requisitos de edad", "fr": "1. Éligibilité", "pt": "1. Elegibilidade", "de": "1. Teilnahmeberechtigung", "zh": "1. 资格要求", "ja": "1. 利用資格", "ko": "1. 자격 요건", "ar": "1. الأهلية", "hi": "1. पात्रता"},
 "2. Accounts and security": {"es": "2. Cuentas y seguridad", "fr": "2. Comptes et sécurité", "pt": "2. Contas e segurança", "de": "2. Konten und Sicherheit", "zh": "2. 账户与安全", "ja": "2. アカウントとセキュリティ", "ko": "2. 계정 및 보안", "ar": "2. الحسابات والأمان", "hi": "2. खाते और सुरक्षा"},
 "3. Your content": {"es": "3. Tu contenido", "fr": "3. Votre contenu", "pt": "3. Seu conteúdo", "de": "3. Deine Inhalte", "zh": "3. 你的内容", "ja": "3. あなたのコンテンツ", "ko": "3. 콘텐츠", "ar": "3. محتواك", "hi": "3. आपकी सामग्री"},
 "4. Public content and interactions": {"es": "4. Contenido público e interacciones", "fr": "4. Contenu public et interactions", "pt": "4. Conteúdo público e interações", "de": "4. Öffentliche Inhalte und Interaktionen", "zh": "4. 公开内容与互动", "ja": "4. 公開コンテンツと交流", "ko": "4. 공개 콘텐츠 및 상호작용", "ar": "4. المحتوى العام والتفاعلات", "hi": "4. सार्वजनिक सामग्री और सहभागिता"},
 "5. Acceptable use": {"es": "5. Uso aceptable", "fr": "5. Utilisation acceptable", "pt": "5. Uso aceitável", "de": "5. Zulässige Nutzung", "zh": "5. 可接受的使用方式", "ja": "5. 許容される利用", "ko": "5. 허용되는 사용", "ar": "5. الاستخدام المقبول", "hi": "5. स्वीकार्य उपयोग"},
 "6. Safety and enforcement": {"es": "6. Seguridad y cumplimiento", "fr": "6. Sécurité et application", "pt": "6. Segurança e aplicação", "de": "6. Sicherheit und Durchsetzung", "zh": "6. 安全与执行", "ja": "6. 安全と規約の適用", "ko": "6. 안전 및 집행", "ar": "6. السلامة والتنفيذ", "hi": "6. सुरक्षा और प्रवर्तन"},
 "7. Privacy": {"es": "7. Privacidad", "fr": "7. Confidentialité", "pt": "7. Privacidade", "de": "7. Datenschutz", "zh": "7. 隐私", "ja": "7. プライバシー", "ko": "7. 개인정보", "ar": "7. الخصوصية", "hi": "7. गोपनीयता"},
 "8. Availability and changes": {"es": "8. Disponibilidad y cambios", "fr": "8. Disponibilité et modifications", "pt": "8. Disponibilidade e alterações", "de": "8. Verfügbarkeit und Änderungen", "zh": "8. 可用性与变更", "ja": "8. 提供状況と変更", "ko": "8. 이용 가능성 및 변경", "ar": "8. التوفر والتغييرات", "hi": "8. उपलब्धता और बदलाव"},
 "9. Suspension and termination": {"es": "9. Suspensión y cancelación", "fr": "9. Suspension et résiliation", "pt": "9. Suspensão e encerramento", "de": "9. Sperrung und Beendigung", "zh": "9. 暂停与终止", "ja": "9. 停止と終了", "ko": "9. 정지 및 종료", "ar": "9. التعليق والإنهاء", "hi": "9. निलंबन और समाप्ति"},
 "10. Disclaimers": {"es": "10. Exenciones de responsabilidad", "fr": "10. Exclusions de garantie", "pt": "10. Isenções de responsabilidade", "de": "10. Haftungsausschlüsse", "zh": "10. 免责声明", "ja": "10. 免責事項", "ko": "10. 면책 조항", "ar": "10. إخلاء المسؤولية", "hi": "10. अस्वीकरण"},
 "11. Limitation of liability": {"es": "11. Limitación de responsabilidad", "fr": "11. Limitation de responsabilité", "pt": "11. Limitação de responsabilidade", "de": "11. Haftungsbeschränkung", "zh": "11. 责任限制", "ja": "11. 責任の制限", "ko": "11. 책임 제한", "ar": "11. تحديد المسؤولية", "hi": "11. दायित्व की सीमा"},
 "12. Governing law and disputes": {"es": "12. Ley aplicable y disputas", "fr": "12. Droit applicable et litiges", "pt": "12. Lei aplicável e disputas", "de": "12. Anwendbares Recht und Streitigkeiten", "zh": "12. 适用法律与争议", "ja": "12. 準拠法と紛争", "ko": "12. 준거법 및 분쟁", "ar": "12. القانون الحاكم والنزاعات", "hi": "12. लागू कानून और विवाद"},
 "13. Contact": {"es": "13. Contacto", "fr": "13. Contact", "pt": "13. Contato", "de": "13. Kontakt", "zh": "13. 联系方式", "ja": "13. お問い合わせ", "ko": "13. 문의", "ar": "13. الاتصال", "hi": "13. संपर्क"},
 "1. Information you provide": {"es": "1. Información que proporcionas", "fr": "1. Informations fournies", "pt": "1. Informações fornecidas", "de": "1. Angaben, die du machst", "zh": "1. 你提供的信息", "ja": "1. 提供する情報", "ko": "1. 제공하는 정보", "ar": "1. المعلومات التي تقدمها", "hi": "1. आपके द्वारा दी गई जानकारी"},
 "2. Technical information": {"es": "2. Información técnica", "fr": "2. Informations techniques", "pt": "2. Informações técnicas", "de": "2. Technische Informationen", "zh": "2. 技术信息", "ja": "2. 技術情報", "ko": "2. 기술 정보", "ar": "2. المعلومات التقنية", "hi": "2. तकनीकी जानकारी"},
 "3. How we use information": {"es": "3. Cómo usamos la información", "fr": "3. Utilisation des informations", "pt": "3. Como usamos as informações", "de": "3. Verwendung von Informationen", "zh": "3. 我们如何使用信息", "ja": "3. 情報の利用方法", "ko": "3. 정보 사용 방법", "ar": "3. كيفية استخدام المعلومات", "hi": "3. जानकारी का उपयोग"},
 "4. Public content": {"es": "4. Contenido público", "fr": "4. Contenu public", "pt": "4. Conteúdo público", "de": "4. Öffentliche Inhalte", "zh": "4. 公开内容", "ja": "4. 公開コンテンツ", "ko": "4. 공개 콘텐츠", "ar": "4. المحتوى العام", "hi": "4. सार्वजनिक सामग्री"},
 "5. How information is shared": {"es": "5. Cómo compartimos la información", "fr": "5. Partage des informations", "pt": "5. Como as informações são compartilhadas", "de": "5. Weitergabe von Informationen", "zh": "5. 信息共享方式", "ja": "5. 情報の共有方法", "ko": "5. 정보 공유 방식", "ar": "5. كيفية مشاركة المعلومات", "hi": "5. जानकारी कैसे साझा की जाती है"},
 "6. Service providers": {"es": "6. Proveedores de servicios", "fr": "6. Prestataires de services", "pt": "6. Prestadores de serviços", "de": "6. Dienstleister", "zh": "6. 服务提供商", "ja": "6. サービス提供者", "ko": "6. 서비스 제공업체", "ar": "6. مزودو الخدمة", "hi": "6. सेवा प्रदाता"},
 "7. Security": {"es": "7. Seguridad", "fr": "7. Sécurité", "pt": "7. Segurança", "de": "7. Sicherheit", "zh": "7. 安全", "ja": "7. セキュリティ", "ko": "7. 보안", "ar": "7. الأمان", "hi": "7. सुरक्षा"},
 "8. Retention and deletion": {"es": "8. Conservación y eliminación", "fr": "8. Conservation et suppression", "pt": "8. Retenção e exclusão", "de": "8. Aufbewahrung und Löschung", "zh": "8. 保留与删除", "ja": "8. 保存と削除", "ko": "8. 보관 및 삭제", "ar": "8. الاحتفاظ والحذف", "hi": "8. प्रतिधारण और हटाना"},
 "9. Your choices and rights": {"es": "9. Tus opciones y derechos", "fr": "9. Vos choix et droits", "pt": "9. Suas escolhas e direitos", "de": "9. Deine Wahlmöglichkeiten und Rechte", "zh": "9. 你的选择与权利", "ja": "9. 選択肢と権利", "ko": "9. 선택 및 권리", "ar": "9. خياراتك وحقوقك", "hi": "9. आपके विकल्प और अधिकार"},
 "10. Children and teens": {"es": "10. Niños y adolescentes", "fr": "10. Enfants et adolescents", "pt": "10. Crianças e adolescentes", "de": "10. Kinder und Jugendliche", "zh": "10. 儿童与青少年", "ja": "10. 子どもと青少年", "ko": "10. 아동 및 청소년", "ar": "10. الأطفال والمراهقون", "hi": "10. बच्चे और किशोर"},
 "11. International processing": {"es": "11. Tratamiento internacional", "fr": "11. Traitement international", "pt": "11. Processamento internacional", "de": "11. Internationale Verarbeitung", "zh": "11. 国际处理", "ja": "11. 国際的な処理", "ko": "11. 국제 처리", "ar": "11. المعالجة الدولية", "hi": "11. अंतरराष्ट्रीय प्रसंस्करण"},
 "12. Third-party services": {"es": "12. Servicios de terceros", "fr": "12. Services tiers", "pt": "12. Serviços de terceiros", "de": "12. Drittanbieterdienste", "zh": "12. 第三方服务", "ja": "12. サードパーティサービス", "ko": "12. 타사 서비스", "ar": "12. خدمات الجهات الخارجية", "hi": "12. तृतीय-पक्ष सेवाएँ"},
 "13. Policy changes": {"es": "13. Cambios en la política", "fr": "13. Modifications de la politique", "pt": "13. Alterações na política", "de": "13. Änderungen der Richtlinie", "zh": "13. 政策变更", "ja": "13. ポリシーの変更", "ko": "13. 정책 변경", "ar": "13. تغييرات السياسة", "hi": "13. नीति में बदलाव"},
 "14. Contact": {"es": "14. Contacto", "fr": "14. Contact", "pt": "14. Contato", "de": "14. Kontakt", "zh": "14. 联系方式", "ja": "14. お問い合わせ", "ko": "14. 문의", "ar": "14. الاتصال", "hi": "14. संपर्क"},
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
                    Text(L("Create your account"))
                        .font(.custom("PlusJakartaSans-Bold", size: 34))
                        .tracking(-0.5)
                    Text(L("A few details and you're ready to get started."))
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
                    Text(L("By continuing, you agree to our"))
                        .foregroundStyle(.secondary)
                    Button(L("Terms of Service")) {
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
                    Text(L("Already have an account?"))
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
            Text(L("Welcome to PULSE. These Terms of Service govern your access to and use of PULSE. By using PULSE, you agree to these Terms. If you do not agree, do not use the service."))
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
            Text(L("PULSE respects your privacy. This Privacy Policy explains how personal information is collected, used, stored, and shared when you use PULSE."))
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
                    Text(L("Pick up where you left off."))
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
                            SecureField(L("Your password"), text: $signInPassword)
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
                    Text(L("New to PULSE?"))
                        .foregroundStyle(.secondary)
                    Button(L("Create an account")) {
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
