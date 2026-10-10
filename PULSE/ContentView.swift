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
 "Create your account":["es":"Crea tu cuenta","fr":"Créez votre compte","pt":"Crie sua conta","de":"Erstelle dein Konto","zh":"创建你的账户","ja":"アカウントを作成","ko":"계정 만들기","ar":"أنشئ حسابك","hi":"अपना खाता बनाएँ"],
 "Already have an account?":["es":"¿Ya tienes una cuenta?","fr":"Vous avez déjà un compte ?","pt":"Já tem uma conta?","de":"Hast du bereits ein Konto?","zh":"已有账户？","ja":"すでにアカウントをお持ちですか？","ko":"이미 계정이 있나요?","ar":"هل لديك حساب بالفعل؟","hi":"क्या आपके पास पहले से खाता है؟"],
 "By continuing, you agree to our":["es":"Al continuar, aceptas nuestros","fr":"En continuant, vous acceptez nos","pt":"Ao continuar, você concorda com nossos","de":"Wenn du fortfährst, stimmst du unseren","zh":"继续即表示你同意我们的","ja":"続行すると、以下に同意したものとみなされます：","ko":"계속하면 다음에 동의하는 것입니다:","ar":"بالمتابعة، فإنك توافق على","hi":"जारी रखने पर आप हमारी"],
 "Terms of Service":["es":"Términos del servicio","fr":"Conditions d’utilisation","pt":"Termos de serviço","de":"Nutzungsbedingungen","zh":"服务条款","ja":"利用規約","ko":"서비스 약관","ar":"شروط الخدمة","hi":"सेवा की शर्तें"],
 "Use 3–20 letters, numbers, or underscores.":["es":"Usa entre 3 y 20 letras, números o guiones bajos.","fr":"Utilisez 3 à 20 lettres, chiffres ou traits de soulignement.","pt":"Use de 3 a 20 letras, números ou sublinhados.","de":"Verwende 3–20 Buchstaben, Zahlen oder Unterstriche.","zh":"使用 3–20 个字母、数字或下划线。","ja":"3〜20文字の英字、数字、またはアンダースコアを使用してください。","ko":"영문자, 숫자 또는 밑줄을 3~20자 사용하세요.","ar":"استخدم من 3 إلى 20 حرفًا أو رقمًا أو شرطة سفلية.","hi":"3–20 अक्षर, अंक या अंडरस्कोर इस्तेमाल करें。"],
 "Enter your password again":["es":"Vuelve a introducir tu contraseña","fr":"Saisissez à nouveau votre mot de passe","pt":"Digite sua senha novamente","de":"Gib dein Passwort erneut ein","zh":"再次输入密码","ja":"パスワードをもう一度入力","ko":"비밀번호를 다시 입력하세요","ar":"أدخل كلمة المرور مرة أخرى","hi":"अपना पासवर्ड फिर से दर्ज करें"],
 "Your password":["es":"Tu contraseña","fr":"Votre mot de passe","pt":"Sua senha","de":"Dein Passwort","zh":"你的密码","ja":"パスワード","ko":"비밀번호","ar":"كلمة المرور","hi":"आपका पासवर्ड"],
 "Effective October 9, 2026":["es":"Vigente desde el 9 de octubre de 2026","fr":"En vigueur le 9 octobre 2026","pt":"Em vigor em 9 de outubro de 2026","de":"Gültig ab 9. Oktober 2026","zh":"生效日期：2026年10月9日","ja":"2026年10月9日発効","ko":"2026년 10월 9일 시행","ar":"ساري اعتبارًا من 9 أكتوبر 2026","hi":"9 अक्टूबर 2026 से प्रभावी"],
 "1. Eligibility":["es":"1. Elegibilidad","fr":"1. Admissibilité","pt":"1. Elegibilidade","de":"1. Berechtigung","zh":"1. 资格要求","ja":"1. 利用資格","ko":"1. 자격 요건","ar":"1. الأهلية","hi":"1. पात्रता"],
 "2. Accounts and security":["es":"2. Cuentas y seguridad","fr":"2. Comptes et sécurité","pt":"2. Contas e segurança","de":"2. Konten und Sicherheit","zh":"2. 账户与安全","ja":"2. アカウントとセキュリティ","ko":"2. 계정 및 보안","ar":"2. الحسابات والأمان","hi":"2. खाते और सुरक्षा"],
 "3. Your content":["es":"3. Tu contenido","fr":"3. Votre contenu","pt":"3. Seu conteúdo","de":"3. Deine Inhalte","zh":"3. 你的内容","ja":"3. あなたのコンテンツ","ko":"3. 콘텐츠","ar":"3. المحتوى الخاص بك","hi":"3. आपका कंटेंट"],
 "4. Public content and interactions":["es":"4. Contenido público e interacciones","fr":"4. Contenu public et interactions","pt":"4. Conteúdo público e interações","de":"4. Öffentliche Inhalte und Interaktionen","zh":"4. 公开内容与互动","ja":"4. 公開コンテンツと交流","ko":"4. 공개 콘텐츠 및 상호작용","ar":"4. المحتوى العام والتفاعلات","hi":"4. सार्वजनिक कंटेंट और सहभागिता"],
 "5. Acceptable use":["es":"5. Uso aceptable","fr":"5. Utilisation acceptable","pt":"5. Uso aceitável","de":"5. Zulässige Nutzung","zh":"5. 可接受的使用方式","ja":"5. 許容される利用","ko":"5. 허용되는 사용","ar":"5. الاستخدام المقبول","hi":"5. स्वीकार्य उपयोग"],
 "6. Safety and enforcement":["es":"6. Seguridad y cumplimiento","fr":"6. Sécurité et application","pt":"6. Segurança e aplicação","de":"6. Sicherheit und Durchsetzung","zh":"6. 安全与执行","ja":"6. 安全と規約の執行","ko":"6. 안전 및 집행","ar":"6. السلامة وإنفاذ الشروط","hi":"6. सुरक्षा और प्रवर्तन"],
 "7. Privacy":["es":"7. Privacidad","fr":"7. Confidentialité","pt":"7. Privacidade","de":"7. Datenschutz","zh":"7. 隐私","ja":"7. プライバシー","ko":"7. 개인정보 보호","ar":"7. الخصوصية","hi":"7. गोपनीयता"],
 "8. Availability and changes":["es":"8. Disponibilidad y cambios","fr":"8. Disponibilité et modifications","pt":"8. Disponibilidade e alterações","de":"8. Verfügbarkeit und Änderungen","zh":"8. 可用性与变更","ja":"8. 提供状況と変更","ko":"8. 이용 가능성 및 변경","ar":"8. التوفر والتغييرات","hi":"8. उपलब्धता और बदलाव"],
 "9. Suspension and termination":["es":"9. Suspensión y terminación","fr":"9. Suspension et résiliation","pt":"9. Suspensão e encerramento","de":"9. Sperrung und Beendigung","zh":"9. 暂停与终止","ja":"9. 停止と終了","ko":"9. 정지 및 종료","ar":"9. التعليق والإنهاء","hi":"9. निलंबन और समाप्ति"],
 "10. Disclaimers":["es":"10. Exenciones de responsabilidad","fr":"10. Exclusions de responsabilité","pt":"10. Isenções de responsabilidade","de":"10. Haftungsausschlüsse","zh":"10. 免责声明","ja":"10. 免責事項","ko":"10. 면책 조항","ar":"10. إخلاء المسؤولية","hi":"10. अस्वीकरण"],
 "11. Limitation of liability":["es":"11. Limitación de responsabilidad","fr":"11. Limitation de responsabilité","pt":"11. Limitação de responsabilidade","de":"11. Haftungsbeschränkung","zh":"11. 责任限制","ja":"11. 責任制限","ko":"11. 책임 제한","ar":"11. حدود المسؤولية","hi":"11. दायित्व की सीमा"],
 "12. Governing law and disputes":["es":"12. Ley aplicable y disputas","fr":"12. Droit applicable et litiges","pt":"12. Lei aplicável e disputas","de":"12. Anwendbares Recht und Streitigkeiten","zh":"12. 适用法律与争议","ja":"12. 準拠法と紛争","ko":"12. 준거법 및 분쟁","ar":"12. القانون الحاكم والنزاعات","hi":"12. लागू कानून और विवाद"],
 "13. Contact":["es":"13. Contacto","fr":"13. Contact","pt":"13. Contato","de":"13. Kontakt","zh":"13. 联系方式","ja":"13. お問い合わせ","ko":"13. 문의","ar":"13. التواصل","hi":"13. संपर्क"],
 "1. Information you provide":["es":"1. Información que proporcionas","fr":"1. Informations que vous fournissez","pt":"1. Informações fornecidas por você","de":"1. Von dir bereitgestellte Informationen","zh":"1. 你提供的信息","ja":"1. 提供する情報","ko":"1. 제공하는 정보","ar":"1. المعلومات التي تقدمها","hi":"1. आपके द्वारा दी गई जानकारी"],
 "2. Technical information":["es":"2. Información técnica","fr":"2. Informations techniques","pt":"2. Informações técnicas","de":"2. Technische Informationen","zh":"2. 技术信息","ja":"2. 技術情報","ko":"2. 기술 정보","ar":"2. المعلومات التقنية","hi":"2. तकनीकी जानकारी"],
 "3. How we use information":["es":"3. Cómo usamos la información","fr":"3. Utilisation des informations","pt":"3. Como usamos as informações","de":"3. Verwendung von Informationen","zh":"3. 我们如何使用信息","ja":"3. 情報の利用方法","ko":"3. 정보 이용 방법","ar":"3. كيفية استخدام المعلومات","hi":"3. हम जानकारी का उपयोग कैसे करते हैं"],
 "4. Public content":["es":"4. Contenido público","fr":"4. Contenu public","pt":"4. Conteúdo público","de":"4. Öffentliche Inhalte","zh":"4. 公开内容","ja":"4. 公開コンテンツ","ko":"4. 공개 콘텐츠","ar":"4. المحتوى العام","hi":"4. सार्वजनिक कंटेंट"],
 "5. How information is shared":["es":"5. Cómo se comparte la información","fr":"5. Partage des informations","pt":"5. Como as informações são compartilhadas","de":"5. Weitergabe von Informationen","zh":"5. 信息共享方式","ja":"5. 情報の共有方法","ko":"5. 정보 공유 방식","ar":"5. كيفية مشاركة المعلومات","hi":"5. जानकारी कैसे साझा की जाती है"],
 "6. Service providers":["es":"6. Proveedores de servicios","fr":"6. Prestataires de services","pt":"6. Prestadores de serviços","de":"6. Dienstleister","zh":"6. 服务提供商","ja":"6. サービス提供者","ko":"6. 서비스 제공업체","ar":"6. مزودو الخدمات","hi":"6. सेवा प्रदाता"],
 "7. Security":["es":"7. Seguridad","fr":"7. Sécurité","pt":"7. Segurança","de":"7. Sicherheit","zh":"7. 安全","ja":"7. セキュリティ","ko":"7. 보안","ar":"7. الأمان","hi":"7. सुरक्षा"],
 "8. Retention and deletion":["es":"8. Conservación y eliminación","fr":"8. Conservation et suppression","pt":"8. Retenção e exclusão","de":"8. Aufbewahrung und Löschung","zh":"8. 保留与删除","ja":"8. 保存と削除","ko":"8. 보관 및 삭제","ar":"8. الاحتفاظ والحذف","hi":"8. रखरखाव और हटाना"],
 "9. Your choices and rights":["es":"9. Tus opciones y derechos","fr":"9. Vos choix et vos droits","pt":"9. Suas escolhas e direitos","de":"9. Deine Wahlmöglichkeiten und Rechte","zh":"9. 你的选择与权利","ja":"9. 選択肢と権利","ko":"9. 선택 및 권리","ar":"9. خياراتك وحقوقك","hi":"9. आपके विकल्प और अधिकार"],
 "10. Children and teens":["es":"10. Niños y adolescentes","fr":"10. Enfants et adolescents","pt":"10. Crianças e adolescentes","de":"10. Kinder und Jugendliche","zh":"10. 儿童与青少年","ja":"10. 子どもと青少年","ko":"10. 아동 및 청소년","ar":"10. الأطفال والمراهقون","hi":"10. बच्चे और किशोर"],
 "11. International processing":["es":"11. Tratamiento internacional","fr":"11. Traitement international","pt":"11. Tratamento internacional","de":"11. Internationale Verarbeitung","zh":"11. 国际处理","ja":"11. 国際的な処理","ko":"11. 국제 처리","ar":"11. المعالجة الدولية","hi":"11. अंतरराष्ट्रीय प्रसंस्करण"],
 "12. Third-party services":["es":"12. Servicios de terceros","fr":"12. Services tiers","pt":"12. Serviços de terceiros","de":"12. Drittanbieterdienste","zh":"12. 第三方服务","ja":"12. サードパーティサービス","ko":"12. 타사 서비스","ar":"12. خدمات الجهات الخارجية","hi":"12. तृतीय-पक्ष सेवाएँ"],
 "13. Policy changes":["es":"13. Cambios en la política","fr":"13. Modifications de la politique","pt":"13. Alterações da política","de":"13. Änderungen der Richtlinie","zh":"13. 政策变更","ja":"13. ポリシーの変更","ko":"13. 방침 변경","ar":"13. تغييرات السياسة","hi":"13. नीति में बदलाव"],
 "14. Contact":["es":"14. Contacto","fr":"14. Contact","pt":"14. Contato","de":"14. Kontakt","zh":"14. 联系方式","ja":"14. お問い合わせ","ko":"14. 문의","ar":"14. التواصل","hi":"14. संपर्क"],
 "Welcome to PULSE": ["es":"Bienvenido a PULSE","fr":"Bienvenue sur PULSE","pt":"Boas-vindas ao PULSE","de":"Willkommen bei PULSE","zh":"欢迎使用 PULSE","ja":"PULSE へようこそ","ko":"PULSE에 오신 것을 환영합니다","ar":"مرحبًا بك في PULSE","hi":"PULSE में आपका स्वागत है"],
 "A few details and you're ready to get started.": ["es":"Completa unos datos y estarás listo para comenzar.","fr":"Quelques informations et vous pourrez commencer.","pt":"Preencha alguns dados e você poderá começar.","de":"Nur ein paar Angaben, dann kannst du loslegen.","zh":"填写少量信息即可开始使用。","ja":"いくつかの情報を入力すれば、すぐに始められます。","ko":"몇 가지 정보만 입력하면 시작할 수 있습니다.","ar":"أدخل بعض التفاصيل لتكون جاهزًا للبدء.","hi":"कुछ जानकारी भरें और आप शुरू करने के लिए तैयार हैं।"],
 "you@example.com": ["es":"tu@ejemplo.com","fr":"vous@exemple.com","pt":"voce@exemplo.com","de":"du@beispiel.de","zh":"you@example.com","ja":"you@example.com","ko":"you@example.com","ar":"you@example.com","hi":"you@example.com"],
 "At least 8 characters": ["es":"Al menos 8 caracteres","fr":"8 caractères minimum","pt":"Pelo menos 8 caracteres","de":"Mindestens 8 Zeichen","zh":"至少 8 个字符","ja":"8文字以上","ko":"8자 이상","ar":"8 أحرف على الأقل","hi":"कम से कम 8 अक्षर"],
 "Hide password": ["es":"Ocultar contraseña","fr":"Masquer le mot de passe","pt":"Ocultar senha","de":"Passwort ausblenden","zh":"隐藏密码","ja":"パスワードを隠す","ko":"비밀번호 숨기기","ar":"إخفاء كلمة المرور","hi":"पासवर्ड छिपाएँ"],
 "Show password": ["es":"Mostrar contraseña","fr":"Afficher le mot de passe","pt":"Mostrar senha","de":"Passwort anzeigen","zh":"显示密码","ja":"パスワードを表示","ko":"비밀번호 표시","ar":"إظهار كلمة المرور","hi":"पासवर्ड दिखाएँ"],
 "Use at least 8 characters.": ["es":"Usa al menos 8 caracteres.","fr":"Utilisez au moins 8 caractères.","pt":"Use pelo menos 8 caracteres.","de":"Verwende mindestens 8 Zeichen.","zh":"请至少使用 8 个字符。","ja":"8文字以上で入力してください。","ko":"8자 이상 입력하세요.","ar":"استخدم 8 أحرف على الأقل.","hi":"कम से कम 8 अक्षरों का उपयोग करें।"],
 "Passwords don't match.": ["es":"Las contraseñas no coinciden.","fr":"Les mots de passe ne correspondent pas.","pt":"As senhas não coincidem.","de":"Die Passwörter stimmen nicht überein.","zh":"两次输入的密码不一致。","ja":"パスワードが一致しません。","ko":"비밀번호가 일치하지 않습니다.","ar":"كلمتا المرور غير متطابقتين.","hi":"पासवर्ड मेल नहीं खाते।"],
 "OR": ["es":"O","fr":"OU","pt":"OU","de":"ODER","zh":"或","ja":"または","ko":"또는","ar":"أو","hi":"या"],
 "New to PULSE?": ["es":"¿Nuevo en PULSE?","fr":"Nouveau sur PULSE ?","pt":"Novo no PULSE?","de":"Neu bei PULSE?","zh":"刚开始使用 PULSE？","ja":"PULSE は初めてですか？","ko":"PULSE를 처음 사용하시나요?","ar":"هل أنت جديد في PULSE؟","hi":"PULSE पर नए हैं?"],
 "Format looks good. Unique availability must be confirmed by the account service.": ["es":"El formato es correcto. El servicio de cuentas debe confirmar si el nombre está disponible.","fr":"Le format est valide. Le service de comptes doit confirmer la disponibilité du nom.","pt":"O formato está correto. O serviço de contas precisa confirmar se o nome está disponível.","de":"Das Format ist gültig. Der Kontodienst muss die Verfügbarkeit des Namens bestätigen.","zh":"格式正确。用户名是否可用仍需由账户服务确认。","ja":"形式は正しいです。ユーザー名が利用可能かどうかはアカウントサービスで確認する必要があります。","ko":"형식이 올바릅니다. 사용자 이름 사용 가능 여부는 계정 서비스에서 확인해야 합니다.","ar":"التنسيق صحيح. يجب أن تؤكد خدمة الحسابات مدى توفر اسم المستخدم.","hi":"फ़ॉर्मैट सही है। उपयोगकर्ता नाम उपलब्ध है या नहीं, इसकी पुष्टि खाता सेवा को करनी होगी।"],
 "Account registration": ["es":"Registro de cuenta","fr":"Création de compte","pt":"Cadastro de conta","de":"Kontoerstellung","zh":"账户注册","ja":"アカウント登録","ko":"계정 등록","ar":"إنشاء الحساب","hi":"खाता पंजीकरण"],
 "Passkeys": ["es":"Llaves de acceso","fr":"Clés d’accès","pt":"Chaves de acesso","de":"Passkeys","zh":"通行密钥","ja":"パスキー","ko":"패스키","ar":"مفاتيح المرور","hi":"पासकी"],
 " is designed in the interface, but it won't work until PULSE is connected to an authentication backend. Passkeys also need server-generated challenges and a registered relying-party domain.": ["es":" está diseñado en la interfaz, pero no funcionará hasta que PULSE se conecte a un servicio de autenticación. Las llaves de acceso también necesitan desafíos generados por el servidor y un dominio de confianza registrado.","fr":" est prévu dans l’interface, mais ne fonctionnera pas tant que PULSE ne sera pas connecté à un service d’authentification. Les clés d’accès nécessitent également des défis générés par le serveur et un domaine de confiance enregistré.","pt":" está previsto na interface, mas não funcionará até que o PULSE seja conectado a um serviço de autenticação. As chaves de acesso também precisam de desafios gerados pelo servidor e de um domínio confiável registrado.","de":" ist in der Oberfläche vorgesehen, funktioniert aber erst, wenn PULSE mit einem Authentifizierungsdienst verbunden ist. Passkeys benötigen außerdem serverseitig erzeugte Challenges und eine registrierte vertrauende Partei-Domain.","zh":"已在界面中设计，但只有在 PULSE 接入身份验证后端后才能使用。通行密钥还需要由服务器生成的挑战以及已注册的信赖方域名。","ja":"は画面上に用意されていますが、PULSE が認証バックエンドに接続されるまで動作しません。パスキーにはサーバー生成のチャレンジと登録済みの信頼当事者ドメインも必要です。","ko":"은 인터페이스에 구현되어 있지만 PULSE가 인증 백엔드에 연결되기 전에는 작동하지 않습니다. 패스키에는 서버에서 생성한 챌린지와 등록된 신뢰 당사자 도메인도 필요합니다.","ar":"مصمم في الواجهة، لكنه لن يعمل حتى يتم ربط PULSE بخادم للمصادقة. كما تحتاج مفاتيح المرور إلى تحديات ينشئها الخادم ونطاق موثوق مسجل.","hi":"इंटरफ़ेस में उपलब्ध है, लेकिन PULSE को प्रमाणीकरण बैकएंड से जोड़ने तक काम नहीं करेगा। पासकी के लिए सर्वर द्वारा बनाए गए चैलेंज और पंजीकृत भरोसेमंद-पक्ष डोमेन की भी आवश्यकता होती है।"],
 "Pick up where you left off.": ["es":"Continúa donde lo dejaste.","fr":"Reprenez là où vous en étiez.","pt":"Continue de onde você parou.","de":"Mach dort weiter, wo du aufgehört hast.","zh":"继续上次的进度。","ja":"前回の続きから始めましょう。","ko":"이어서 계속하세요.","ar":"تابع من حيث توقفت.","hi":"जहाँ छोड़ा था, वहीं से आगे बढ़ें।"],
 "Use 3–20 letters, numbers, or underscores.": ["es":"Usa entre 3 y 20 letras, números o guiones bajos.","fr":"Utilisez 3 à 20 lettres, chiffres ou traits de soulignement.","pt":"Use de 3 a 20 letras, números ou sublinhados.","de":"Verwende 3–20 Buchstaben, Zahlen oder Unterstriche.","zh":"请使用 3–20 个字母、数字或下划线。","ja":"英字・数字・アンダースコアを3〜20文字で使用してください。","ko":"영문자, 숫자 또는 밑줄을 3~20자 사용하세요.","ar":"استخدم من 3 إلى 20 حرفًا أو رقمًا أو شرطة سفلية.","hi":"3–20 अक्षर, अंक या अंडरस्कोर इस्तेमाल करें。"],
 ];
 
 static let legalMap: [String:[String:String]] = [
 "You must be at least 13 years old, or the higher minimum age required where you live. If you are under the age of legal majority, you must have any parent or guardian permission required by applicable law. You are responsible for using PULSE in compliance with the laws that apply to you.":["es":"Debes tener al menos 13 años, o la edad mínima superior exigida donde vives. Si no has alcanzado la mayoría de edad legal, debes contar con el permiso de tu madre, padre o tutor cuando la ley lo requiera. Eres responsable de usar PULSE de acuerdo con las leyes aplicables.","fr":"Vous devez avoir au moins 13 ans, ou l’âge minimum supérieur exigé là où vous vivez. Si vous n’avez pas atteint la majorité légale, vous devez obtenir l’autorisation parentale ou du tuteur exigée par la loi. Vous êtes responsable de l’utilisation de PULSE conformément aux lois applicables.","pt":"Você deve ter pelo menos 13 anos, ou a idade mínima superior exigida onde mora. Se não tiver atingido a maioridade legal, deverá obter a autorização dos pais ou responsáveis exigida pela lei. Você é responsável por usar o PULSE em conformidade com as leis aplicáveis.","de":"Du musst mindestens 13 Jahre alt sein oder das höhere Mindestalter erfüllen, das an deinem Wohnort gilt. Bist du noch nicht volljährig, benötigst du die gesetzlich vorgeschriebene Zustimmung deiner Eltern oder Erziehungsberechtigten. Du bist dafür verantwortlich, PULSE im Einklang mit geltendem Recht zu nutzen.","zh":"你必须年满 13 岁，或达到你居住地规定的更高最低年龄。如果你尚未达到法定成年年龄，必须取得适用法律要求的父母或监护人许可。你有责任遵守适用法律使用 PULSE。","ja":"13歳以上であること、または居住地で定められたそれ以上の最低年齢を満たす必要があります。法定成年年齢に達していない場合、適用法で求められる親または保護者の許可が必要です。適用される法律に従って PULSE を利用する責任はあなたにあります。","ko":"만 13세 이상이거나 거주 지역에서 요구하는 더 높은 최소 연령을 충족해야 합니다. 법적 성년이 아니라면 관련 법률에서 요구하는 부모 또는 보호자의 허락을 받아야 합니다. 관련 법률에 따라 PULSE를 사용하는 것은 이용자의 책임입니다.","ar":"يجب ألا يقل عمرك عن 13 عامًا، أو عن الحد الأدنى الأعلى للعمر المعمول به في مكان إقامتك. إذا لم تبلغ سن الرشد القانوني، فيجب الحصول على موافقة الوالدين أو الوصي التي يفرضها القانون. أنت مسؤول عن استخدام PULSE وفقًا للقوانين المعمول بها.","hi":"आपकी आयु कम-से-कम 13 वर्ष होनी चाहिए, या आपके स्थान पर लागू अधिक न्यूनतम आयु पूरी करनी चाहिए। यदि आप कानूनी वयस्क नहीं हैं, तो लागू कानून के अनुसार माता-पिता या अभिभावक की अनुमति आवश्यक है। लागू कानूनों के अनुसार PULSE का उपयोग करना आपकी ज़िम्मेदारी है।"],
 "Provide accurate information, keep your account credentials secure, and promptly notify us of suspected unauthorized access. Do not impersonate another person, use a username you have no right to use, or create accounts to evade a restriction. You are responsible for activity conducted through your account, except where applicable law provides otherwise.":["es":"Proporciona información precisa, protege las credenciales de tu cuenta y avísanos cuanto antes si sospechas que alguien ha accedido sin autorización. No suplantes a otra persona, no uses un nombre de usuario que no tengas derecho a utilizar ni crees cuentas para eludir restricciones. Eres responsable de la actividad realizada desde tu cuenta, salvo que la ley aplicable disponga lo contrario.","fr":"Fournissez des informations exactes, protégez vos identifiants et informez-nous rapidement de tout accès non autorisé suspecté. N’usurpez pas l’identité d’autrui, n’utilisez pas un nom d’utilisateur auquel vous n’avez pas droit et ne créez pas de comptes pour contourner une restriction. Vous êtes responsable de l’activité effectuée par votre compte, sauf disposition contraire de la loi.","pt":"Forneça informações corretas, mantenha suas credenciais seguras e avise-nos prontamente se suspeitar de acesso não autorizado. Não se passe por outra pessoa, não use um nome de usuário que não tenha direito de usar nem crie contas para contornar restrições. Você é responsável pela atividade realizada em sua conta, salvo disposição legal em contrário.","de":"Gib korrekte Angaben an, schütze deine Zugangsdaten und informiere uns umgehend über vermuteten unbefugten Zugriff. Gib dich nicht als andere Person aus, nutze keinen unberechtigten Benutzernamen und erstelle keine Konten, um Einschränkungen zu umgehen. Du bist für Aktivitäten über dein Konto verantwortlich, sofern geltendes Recht nichts anderes bestimmt.","zh":"请提供准确的信息，妥善保护账户凭据，并在怀疑发生未经授权的访问时及时通知我们。不得冒充他人、使用无权使用的用户名，或创建账户来规避限制。除适用法律另有规定外，你须对通过账户进行的活动负责。","ja":"正確な情報を提供し、アカウント認証情報を安全に保管し、不正アクセスが疑われる場合は速やかに当社へ通知してください。他人になりすましたり、使用する権利のないユーザー名を使ったり、制限を回避するためにアカウントを作成したりしてはいけません。適用法で別段の定めがある場合を除き、アカウント上の活動はあなたの責任です。","ko":"정확한 정보를 제공하고 계정 자격 증명을 안전하게 보관하며 무단 접근이 의심되면 즉시 알려 주세요. 다른 사람을 사칭하거나 사용할 권리가 없는 사용자 이름을 사용하거나 제한을 피하려고 계정을 만들면 안 됩니다. 관련 법률에 달리 정해진 경우를 제외하고 계정을 통한 활동은 이용자의 책임입니다.","ar":"قدّم معلومات دقيقة، واحفظ بيانات اعتماد حسابك بأمان، وأبلغنا سريعًا عند الاشتباه في وصول غير مصرّح به. لا تنتحل شخصية شخص آخر، ولا تستخدم اسم مستخدم لا يحق لك استخدامه، ولا تنشئ حسابات لتجاوز القيود. أنت مسؤول عن النشاط الذي يتم عبر حسابك، ما لم ينص القانون المعمول به على خلاف ذلك.","hi":"सही जानकारी दें, अपने खाते के लॉगिन विवरण सुरक्षित रखें और अनधिकृत पहुँच का संदेह होने पर हमें तुरंत सूचित करें। किसी और का रूप न धारण करें, ऐसा उपयोगकर्ता नाम न इस्तेमाल करें जिसका अधिकार आपके पास नहीं है, और प्रतिबंध से बचने के लिए खाते न बनाएँ। लागू कानून में अन्यथा कहे जाने के अलावा, खाते से की गई गतिविधि के लिए आप ज़िम्मेदार हैं।"],
 "You retain ownership of content you create and submit, to the extent permitted by law. You grant PULSE a non-exclusive, worldwide, royalty-free license to host, store, reproduce, adapt for technical compatibility, and display that content only as reasonably necessary to operate, maintain, secure, and provide PULSE. This license ends when your content is deleted from active systems, except for limited retention in backups, security records, dispute resolution, or where law requires or permits retention. You represent that you have the rights needed to share your content.":["es":"Conservas la propiedad del contenido que creas y publicas, en la medida permitida por la ley. Concedes a PULSE una licencia no exclusiva, mundial y gratuita para alojar, almacenar, reproducir, adaptar por compatibilidad técnica y mostrar ese contenido únicamente en la medida razonablemente necesaria para operar, mantener, proteger y ofrecer PULSE. Esta licencia termina cuando el contenido se elimina de los sistemas activos, salvo la conservación limitada en copias de seguridad, registros de seguridad, resolución de disputas o cuando la ley exija o permita conservarlo. Declaras que tienes los derechos necesarios para compartir tu contenido.","fr":"Vous conservez la propriété du contenu que vous créez et publiez, dans la mesure permise par la loi. Vous accordez à PULSE une licence non exclusive, mondiale et gratuite pour héberger, stocker, reproduire, adapter pour assurer la compatibilité technique et afficher ce contenu uniquement dans la mesure raisonnablement nécessaire au fonctionnement, à la maintenance, à la sécurité et à la fourniture de PULSE. Cette licence prend fin lorsque le contenu est supprimé des systèmes actifs, sauf conservation limitée dans les sauvegardes, les journaux de sécurité, pour régler des litiges ou lorsque la loi l’exige ou l’autorise. Vous déclarez disposer des droits nécessaires pour partager votre contenu.","pt":"Você mantém a propriedade do conteúdo que cria e envia, na medida permitida por lei. Você concede ao PULSE uma licença não exclusiva, mundial e gratuita para hospedar, armazenar, reproduzir, adaptar para compatibilidade técnica e exibir esse conteúdo apenas quando razoavelmente necessário para operar, manter, proteger e fornecer o PULSE. A licença termina quando o conteúdo é excluído dos sistemas ativos, exceto pela retenção limitada em backups, registros de segurança, resolução de disputas ou quando a lei exigir ou permitir. Você declara ter os direitos necessários para compartilhar seu conteúdo.","de":"Du behältst, soweit gesetzlich zulässig, das Eigentum an den von dir erstellten und eingereichten Inhalten. Du gewährst PULSE eine nicht ausschließliche, weltweite, gebührenfreie Lizenz, diese Inhalte zu hosten, zu speichern, zu vervielfältigen, für technische Kompatibilität anzupassen und anzuzeigen, soweit dies für Betrieb, Wartung, Sicherheit und Bereitstellung von PULSE angemessen erforderlich ist. Die Lizenz endet, wenn Inhalte aus aktiven Systemen gelöscht werden, außer bei begrenzter Aufbewahrung in Backups, Sicherheitsprotokollen, zur Streitbeilegung oder soweit gesetzlich vorgeschrieben oder erlaubt. Du bestätigst, dass du die erforderlichen Rechte zum Teilen deiner Inhalte besitzt.","zh":"在法律允许的范围内，你仍拥有自己创建并提交的内容。你授予 PULSE 一项非独占、全球范围、免版税的许可，仅在合理必要的范围内托管、存储、复制、为技术兼容性进行调整并展示这些内容，以运营、维护、保障和提供 PULSE。当内容从活动系统中删除时，该许可即终止，但备份、安全记录、争议解决所需的有限保留，或法律要求或允许的保留除外。你声明自己拥有分享内容所需的权利。","ja":"法律で認められる範囲で、作成・送信したコンテンツの所有権はあなたにあります。PULSE の運営、保守、安全確保、提供に合理的に必要な範囲に限り、コンテンツをホスト、保存、複製、技術的互換性のために調整、表示する、非独占的・全世界的・無償のライセンスを PULSE に付与します。コンテンツが稼働中のシステムから削除されるとこのライセンスは終了します。ただし、バックアップ、セキュリティ記録、紛争解決、または法律上必要・許容される場合の限定的な保持を除きます。コンテンツ共有に必要な権利を有していることを表明します。","ko":"법률이 허용하는 범위에서 이용자가 만들고 제출한 콘텐츠의 소유권은 이용자에게 있습니다. PULSE의 운영, 유지, 보안 및 제공에 합리적으로 필요한 경우에 한해 콘텐츠를 호스팅, 저장, 복제, 기술적 호환성을 위해 조정하고 표시할 수 있는 비독점적·전 세계적·무상 라이선스를 PULSE에 부여합니다. 콘텐츠가 활성 시스템에서 삭제되면 이 라이선스는 종료되지만 백업, 보안 기록, 분쟁 해결 또는 법률상 요구되거나 허용되는 제한적 보관은 예외입니다. 콘텐츠를 공유하는 데 필요한 권리를 보유하고 있음을 진술합니다.","ar":"تحتفظ بملكية المحتوى الذي تنشئه وترسله، بالقدر الذي يسمح به القانون. وتمنح PULSE ترخيصًا غير حصري وعالميًا ومجانيًا لاستضافة ذلك المحتوى وتخزينه ونسخه وتكييفه للتوافق التقني وعرضه، فقط بالقدر المعقول اللازم لتشغيل PULSE وصيانته وتأمينه وتقديمه. ينتهي الترخيص عند حذف المحتوى من الأنظمة النشطة، باستثناء الاحتفاظ المحدود في النسخ الاحتياطية أو سجلات الأمان أو لحل النزاعات أو عندما يفرض القانون الاحتفاظ أو يسمح به. وتقر بأن لديك الحقوق اللازمة لمشاركة المحتوى.","hi":"कानून द्वारा अनुमत सीमा तक, आपके बनाए और जमा किए गए कंटेंट का स्वामित्व आपके पास रहता है। आप PULSE को केवल सेवा चलाने, बनाए रखने, सुरक्षित रखने और उपलब्ध कराने के लिए उचित रूप से आवश्यक सीमा तक उस कंटेंट को होस्ट, संग्रहीत, पुनरुत्पादित, तकनीकी अनुकूलता हेतु संशोधित और प्रदर्शित करने का गैर-अनन्य, विश्वव्यापी, रॉयल्टी-मुक्त लाइसेंस देते हैं। सक्रिय प्रणालियों से कंटेंट हटने पर यह लाइसेंस समाप्त हो जाता है, सिवाय बैकअप, सुरक्षा रिकॉर्ड, विवाद समाधान या कानून द्वारा आवश्यक/अनुमत सीमित संरक्षण के। आप पुष्टि करते हैं कि कंटेंट साझा करने के आवश्यक अधिकार आपके पास हैं।"],
 "You are responsible for choosing what to share and for understanding the audience indicated by the relevant feature and settings. Content shared publicly may be viewed, copied, or redistributed by others. Removing content from PULSE cannot guarantee removal of copies already saved or shared by other users.":["es":"Eres responsable de elegir qué compartes y de comprender quién puede verlo según la función y la configuración correspondiente. Otras personas pueden ver, copiar o redistribuir el contenido público. Eliminar contenido de PULSE no garantiza que desaparezcan las copias que otros usuarios ya hayan guardado o compartido.","fr":"Vous êtes responsable de ce que vous choisissez de partager et de comprendre le public indiqué par la fonctionnalité et les paramètres concernés. Le contenu public peut être consulté, copié ou redistribué par d’autres personnes. Supprimer un contenu de PULSE ne garantit pas la suppression des copies déjà enregistrées ou partagées par d’autres utilisateurs.","pt":"Você é responsável por escolher o que compartilhar e entender o público indicado pelos recursos e configurações relevantes. Conteúdo público pode ser visto, copiado ou redistribuído por outras pessoas. Remover conteúdo do PULSE não garante a remoção de cópias já salvas ou compartilhadas por outros usuários.","de":"Du bist dafür verantwortlich, was du teilst und welche Zielgruppe durch die jeweilige Funktion und Einstellung angezeigt wird. Öffentlich geteilte Inhalte können von anderen angesehen, kopiert oder weiterverbreitet werden. Das Entfernen von PULSE garantiert nicht, dass bereits von anderen gespeicherte oder geteilte Kopien gelöscht werden.","zh":"你有责任选择分享的内容，并了解相关功能和设置所指示的受众。公开分享的内容可能被他人查看、复制或转发。从 PULSE 删除内容并不能保证已被其他用户保存或分享的副本也会被删除。","ja":"共有する内容を選び、機能や設定で示される閲覧対象を理解する責任はあなたにあります。公開コンテンツは他者に閲覧、コピー、再配布される場合があります。PULSE から削除しても、他のユーザーが既に保存・共有したコピーが削除されるとは限りません。","ko":"무엇을 공유할지 선택하고 관련 기능 및 설정에 표시된 대상이 누구인지 이해하는 것은 이용자의 책임입니다. 공개 콘텐츠는 다른 사람이 보거나 복사하거나 재배포할 수 있습니다. PULSE에서 콘텐츠를 삭제해도 다른 사용자가 이미 저장하거나 공유한 사본까지 삭제된다고 보장할 수 없습니다.","ar":"أنت مسؤول عن اختيار ما تشاركه وفهم الجمهور المحدد بواسطة الميزة والإعدادات ذات الصلة. قد يطّلع الآخرون على المحتوى المنشور علنًا أو ينسخونه أو يعيدون توزيعه. لا يضمن حذف المحتوى من PULSE إزالة النسخ التي حفظها أو شاركها مستخدمون آخرون بالفعل.","hi":"क्या साझा करना है और संबंधित सुविधा व सेटिंग में दर्शाए गए दर्शकों को समझना आपकी ज़िम्मेदारी है। सार्वजनिक रूप से साझा कंटेंट को अन्य लोग देख, कॉपी या दोबारा वितरित कर सकते हैं। PULSE से कंटेंट हटाने से अन्य उपयोगकर्ताओं द्वारा पहले से सहेजी या साझा की गई प्रतियाँ हटने की गारंटी नहीं मिलती।"],
 "You may not use PULSE to harass, threaten, stalk, exploit or endanger minors, unlawfully disclose private information, infringe intellectual-property or other rights, distribute scams or spam, impersonate others, publish unlawful threats, attack or disrupt the service, access information without authorization, manipulate engagement deceptively, or use automation in ways that abuse or interfere with PULSE.":["es":"No puedes usar PULSE para acosar, amenazar, perseguir, explotar o poner en peligro a menores; divulgar ilegalmente información privada; infringir la propiedad intelectual u otros derechos; distribuir estafas o spam; suplantar a otras personas; publicar amenazas ilegales; atacar o interrumpir el servicio; acceder a información sin autorización; manipular engañosamente la interacción; ni usar automatización para abusar de PULSE o interferir con su funcionamiento.","fr":"Vous ne pouvez pas utiliser PULSE pour harceler, menacer, suivre, exploiter ou mettre en danger des mineurs, divulguer illégalement des informations privées, porter atteinte à la propriété intellectuelle ou à d’autres droits, diffuser des escroqueries ou du spam, usurper l’identité d’autrui, publier des menaces illégales, attaquer ou perturber le service, accéder sans autorisation à des informations, manipuler les interactions de manière trompeuse ou utiliser l’automatisation pour abuser de PULSE ou perturber son fonctionnement.","pt":"Você não pode usar o PULSE para assediar, ameaçar, perseguir, explorar ou colocar menores em perigo; divulgar ilegalmente informações privadas; violar propriedade intelectual ou outros direitos; distribuir golpes ou spam; se passar por outras pessoas; publicar ameaças ilegais; atacar ou interromper o serviço; acessar informações sem autorização; manipular interações de forma enganosa; ou usar automação para abusar ou interferir no PULSE.","de":"Du darfst PULSE nicht verwenden, um zu belästigen, zu bedrohen, nachzustellen, Minderjährige auszubeuten oder zu gefährden, private Informationen rechtswidrig offenzulegen, geistiges Eigentum oder andere Rechte zu verletzen, Betrug oder Spam zu verbreiten, andere zu imitieren, rechtswidrige Drohungen zu veröffentlichen, den Dienst anzugreifen oder zu stören, unbefugt auf Informationen zuzugreifen, Interaktionen irreführend zu manipulieren oder Automatisierung missbräuchlich einzusetzen.","zh":"不得利用 PULSE 骚扰、威胁、跟踪、剥削或危害未成年人；非法披露私人信息；侵犯知识产权或其他权利；传播诈骗或垃圾信息；冒充他人；发布非法威胁；攻击或干扰服务；未经授权访问信息；以欺骗方式操纵互动；或使用自动化手段滥用或干扰 PULSE。","ja":"PULSE を使って、嫌がらせ、脅迫、つきまとい、未成年者の搾取や危害、個人情報の違法な開示、知的財産権その他の権利の侵害、詐欺やスパムの配布、なりすまし、違法な脅迫の投稿、サービスへの攻撃や妨害、無許可の情報アクセス、反応の不正操作、または PULSE を悪用・妨害する自動化を行ってはいけません。","ko":"PULSE를 이용해 괴롭힘, 협박, 스토킹, 미성년자 착취 또는 위험 초래, 사적 정보의 불법 공개, 지식재산권이나 기타 권리 침해, 사기 또는 스팸 유포, 사칭, 불법 협박 게시, 서비스 공격 또는 방해, 무단 정보 접근, 참여 지표의 기만적 조작, 또는 PULSE를 악용하거나 방해하는 자동화 행위를 해서는 안 됩니다.","ar":"لا يجوز استخدام PULSE لمضايقة الآخرين أو تهديدهم أو ملاحقتهم، أو استغلال القاصرين أو تعريضهم للخطر، أو الكشف غير القانوني عن المعلومات الخاصة، أو انتهاك الملكية الفكرية أو الحقوق الأخرى، أو نشر الاحتيال أو الرسائل المزعجة، أو انتحال شخصية الآخرين، أو نشر تهديدات غير قانونية، أو مهاجمة الخدمة أو تعطيلها، أو الوصول إلى المعلومات دون إذن، أو التلاعب بالتفاعل بشكل مضلل، أو استخدام الأتمتة لإساءة استخدام PULSE أو التدخل فيه.","hi":"PULSE का उपयोग उत्पीड़न, धमकी, पीछा करने, नाबालिगों का शोषण या उन्हें खतरे में डालने, निजी जानकारी का गैरकानूनी खुलासा, बौद्धिक संपदा या अन्य अधिकारों का उल्लंघन, धोखाधड़ी या स्पैम फैलाने, दूसरों का रूप धारण करने, गैरकानूनी धमकियाँ प्रकाशित करने, सेवा पर हमला या बाधा डालने, बिना अनुमति जानकारी तक पहुँचने, सहभागिता में भ्रामक हेरफेर करने, या PULSE का दुरुपयोग/हस्तक्षेप करने वाले स्वचालन के लिए नहीं किया जा सकता।"],
 "We may review reports and take proportionate action when content or conduct violates these Terms, threatens user safety, compromises security, or creates legal risk. Actions may include content removal, feature restrictions, account suspension, or termination. Where appropriate and required by law, we may provide notice and a way to appeal. We cannot guarantee that every item of content will be reviewed or that all harmful activity will be detected.":["es":"Podemos revisar denuncias y tomar medidas proporcionales cuando el contenido o la conducta infrinja estos Términos, amenace la seguridad de los usuarios, comprometa la seguridad técnica o genere riesgos legales. Las medidas pueden incluir retirar contenido, restringir funciones, suspender una cuenta o cancelarla. Cuando corresponda y la ley lo exija, podremos avisarte y ofrecer una vía de apelación. No podemos garantizar que se revise todo el contenido ni que se detecte toda actividad dañina.","fr":"Nous pouvons examiner les signalements et prendre des mesures proportionnées lorsque le contenu ou le comportement enfreint ces Conditions, menace la sécurité des utilisateurs, compromet la sécurité technique ou crée un risque juridique. Les mesures peuvent inclure la suppression de contenu, la restriction de fonctionnalités, la suspension ou la fermeture d’un compte. Lorsque cela est approprié et exigé par la loi, nous pouvons fournir un avis et une possibilité de recours. Nous ne pouvons garantir que chaque contenu sera examiné ni que toute activité nuisible sera détectée.","pt":"Podemos analisar denúncias e tomar medidas proporcionais quando o conteúdo ou a conduta violar estes Termos, ameaçar a segurança dos usuários, comprometer a segurança ou criar risco jurídico. As medidas podem incluir remoção de conteúdo, restrição de recursos, suspensão ou encerramento da conta. Quando apropriado e exigido por lei, poderemos enviar aviso e oferecer uma forma de recurso. Não garantimos que todo conteúdo será analisado nem que toda atividade prejudicial será detectada.","de":"Wir können Meldungen prüfen und angemessene Maßnahmen ergreifen, wenn Inhalte oder Verhalten gegen diese Bedingungen verstoßen, die Sicherheit von Nutzern gefährden, die Sicherheit beeinträchtigen oder rechtliche Risiken schaffen. Dazu gehören die Entfernung von Inhalten, Funktionseinschränkungen sowie die Sperrung oder Kündigung von Konten. Soweit angemessen und gesetzlich vorgeschrieben, können wir eine Mitteilung und eine Einspruchsmöglichkeit anbieten. Wir können nicht garantieren, dass alle Inhalte geprüft oder alle schädlichen Aktivitäten erkannt werden.","zh":"如果内容或行为违反本条款、威胁用户安全、损害安全性或带来法律风险，我们可能审查举报并采取相称措施，包括删除内容、限制功能、暂停或终止账户。在适当且法律要求的情况下，我们可能发出通知并提供申诉途径。我们无法保证每项内容都会被审查，也无法保证发现所有有害活动。","ja":"コンテンツや行為が本規約に違反する、ユーザーの安全を脅かす、セキュリティを損なう、または法的リスクを生む場合、報告を確認し、相応の措置を講じることがあります。措置には、コンテンツの削除、機能制限、アカウントの一時停止または終了が含まれます。適切で法律上必要な場合、通知と異議申し立ての方法を提供することがあります。すべてのコンテンツを審査したり、すべての有害行為を検出したりする保証はありません。","ko":"콘텐츠나 행위가 본 약관을 위반하거나 사용자 안전을 위협하거나 보안을 훼손하거나 법적 위험을 초래하면 신고를 검토하고 비례적인 조치를 취할 수 있습니다. 조치에는 콘텐츠 삭제, 기능 제한, 계정 정지 또는 종료가 포함될 수 있습니다. 적절하고 법률상 필요한 경우 통지와 이의 제기 방법을 제공할 수 있습니다. 모든 콘텐츠를 검토하거나 모든 유해 활동을 탐지한다고 보장하지 않습니다.","ar":"قد نراجع البلاغات ونتخذ إجراءات متناسبة عندما يخالف المحتوى أو السلوك هذه الشروط، أو يهدد سلامة المستخدمين، أو يضر بالأمن، أو ينشئ مخاطر قانونية. قد تشمل الإجراءات إزالة المحتوى أو تقييد الميزات أو تعليق الحساب أو إنهاءه. وعند الاقتضاء وبموجب القانون، قد نقدم إشعارًا وطريقة للاستئناف. لا نضمن مراجعة كل محتوى أو اكتشاف جميع الأنشطة الضارة.","hi":"यदि कंटेंट या व्यवहार इन शर्तों का उल्लंघन करता है, उपयोगकर्ता सुरक्षा को खतरे में डालता है, सुरक्षा से समझौता करता है या कानूनी जोखिम पैदा करता है, तो हम रिपोर्ट की समीक्षा कर उचित कार्रवाई कर सकते हैं। इसमें कंटेंट हटाना, सुविधाओं पर प्रतिबंध, खाते को निलंबित करना या समाप्त करना शामिल हो सकता है। जहाँ उचित और कानूनन आवश्यक हो, हम सूचना और अपील का तरीका दे सकते हैं। हम हर कंटेंट की समीक्षा या हर हानिकारक गतिविधि का पता लगाने की गारंटी नहीं देते।"],
 "Our collection and use of personal information are described in the PULSE Privacy Policy, which explains how information is handled, shared, retained, and how you can exercise applicable privacy rights. PULSE does not sell users' personal information.":["es":"La Política de privacidad de PULSE describe cómo recopilamos y usamos información personal, cómo la tratamos, compartimos y conservamos, y cómo puedes ejercer los derechos de privacidad aplicables. PULSE no vende la información personal de sus usuarios.","fr":"Notre collecte et notre utilisation des informations personnelles sont décrites dans la Politique de confidentialité de PULSE, qui explique comment les informations sont traitées, partagées et conservées, ainsi que la manière d’exercer les droits applicables. PULSE ne vend pas les informations personnelles des utilisateurs.","pt":"A coleta e o uso de informações pessoais são descritos na Política de Privacidade do PULSE, que explica como as informações são tratadas, compartilhadas e armazenadas e como você pode exercer os direitos de privacidade aplicáveis. O PULSE não vende informações pessoais dos usuários.","de":"Die Erhebung und Nutzung personenbezogener Daten wird in der PULSE-Datenschutzerklärung beschrieben. Sie erläutert, wie Daten verarbeitet, geteilt und gespeichert werden und wie du deine geltenden Datenschutzrechte ausüben kannst. PULSE verkauft keine personenbezogenen Daten von Nutzern.","zh":"PULSE 隐私政策说明我们如何收集和使用个人信息、如何处理、共享和保留信息，以及你如何行使适用的隐私权利。PULSE 不出售用户的个人信息。","ja":"個人情報の収集と利用については PULSE のプライバシーポリシーに記載されています。同ポリシーでは、情報の取り扱い、共有、保存、および適用されるプライバシー権の行使方法を説明しています。PULSE はユーザーの個人情報を販売しません。","ko":"개인정보의 수집 및 이용은 PULSE 개인정보 처리방침에 설명되어 있습니다. 해당 방침은 정보의 처리, 공유, 보관 방식과 적용되는 개인정보 권리를 행사하는 방법을 안내합니다. PULSE는 이용자의 개인정보를 판매하지 않습니다.","ar":"توضح سياسة خصوصية PULSE كيفية جمع المعلومات الشخصية واستخدامها ومعالجتها ومشاركتها والاحتفاظ بها، وكيفية ممارسة حقوق الخصوصية المعمول بها. لا تبيع PULSE المعلومات الشخصية للمستخدمين.","hi":"PULSE की गोपनीयता नीति बताती है कि व्यक्तिगत जानकारी कैसे एकत्र और उपयोग की जाती है, कैसे संभाली, साझा और रखी जाती है, और आप लागू गोपनीयता अधिकारों का उपयोग कैसे कर सकते हैं। PULSE उपयोगकर्ताओं की व्यक्तिगत जानकारी नहीं बेचता।"],
 "We may update, modify, suspend, or discontinue parts of PULSE for operational, security, legal, or product reasons. We aim to keep the service reliable but do not guarantee uninterrupted or error-free operation. We will provide notice or obtain consent for material changes where required by law.":["es":"Podemos actualizar, modificar, suspender o dejar de ofrecer partes de PULSE por motivos operativos, de seguridad, legales o relacionados con el producto. Procuramos que el servicio sea fiable, pero no garantizamos que funcione sin interrupciones ni errores. Avisaremos u obtendremos consentimiento para cambios importantes cuando la ley lo exija.","fr":"Nous pouvons mettre à jour, modifier, suspendre ou arrêter certaines parties de PULSE pour des raisons opérationnelles, de sécurité, juridiques ou liées au produit. Nous cherchons à maintenir un service fiable sans garantir un fonctionnement continu ou sans erreur. Nous informerons les utilisateurs ou demanderons leur consentement pour les changements importants lorsque la loi l’exige.","pt":"Podemos atualizar, modificar, suspender ou descontinuar partes do PULSE por motivos operacionais, de segurança, legais ou relacionados ao produto. Buscamos manter o serviço confiável, mas não garantimos funcionamento ininterrupto ou sem erros. Avisaremos ou obteremos consentimento para mudanças importantes quando a lei exigir.","de":"Wir können Teile von PULSE aus betrieblichen, sicherheitsbezogenen, rechtlichen oder produktbezogenen Gründen aktualisieren, ändern, aussetzen oder einstellen. Wir bemühen uns um einen zuverlässigen Dienst, garantieren aber keinen unterbrechungs- oder fehlerfreien Betrieb. Über wesentliche Änderungen informieren wir oder holen eine Zustimmung ein, soweit gesetzlich erforderlich.","zh":"我们可能因运营、安全、法律或产品原因更新、修改、暂停或停止 PULSE 的部分功能。我们致力于保持服务可靠，但不保证服务持续可用或完全无错误。法律要求时，我们会就重大变更发出通知或取得同意。","ja":"運用上、安全上、法的または製品上の理由により、PULSE の一部を更新、変更、一時停止または終了する場合があります。サービスの信頼性維持に努めますが、中断やエラーがないことは保証しません。法律上必要な場合、重要な変更について通知または同意取得を行います。","ko":"운영, 보안, 법률 또는 제품상의 이유로 PULSE의 일부를 업데이트, 수정, 중단 또는 종료할 수 있습니다. 서비스의 신뢰성을 위해 노력하지만 중단이나 오류가 없다고 보장하지는 않습니다. 법률상 필요한 경우 중요한 변경 사항을 알리거나 동의를 받겠습니다.","ar":"قد نحدّث أجزاء من PULSE أو نعدّلها أو نعلّقها أو نوقفها لأسباب تشغيلية أو أمنية أو قانونية أو متعلقة بالمنتج. نسعى إلى توفير خدمة موثوقة، لكننا لا نضمن العمل دون انقطاع أو أخطاء. سنقدم إشعارًا أو نحصل على الموافقة بشأن التغييرات الجوهرية عندما يقتضي القانون ذلك.","hi":"परिचालन, सुरक्षा, कानूनी या उत्पाद संबंधी कारणों से हम PULSE के कुछ हिस्सों को अपडेट, संशोधित, निलंबित या बंद कर सकते हैं। हम सेवा को विश्वसनीय रखने का प्रयास करते हैं, लेकिन बिना रुकावट या त्रुटि-मुक्त संचालन की गारंटी नहीं देते। कानून के अनुसार आवश्यक होने पर महत्वपूर्ण बदलावों की सूचना देंगे या सहमति लेंगे।"],
 "You may stop using PULSE at any time. We may restrict or terminate access for violations of these Terms, security concerns, safety risks, legal requirements, or conduct that threatens users or the service. Where account deletion is available, the applicable process and data-retention rules are described in the Privacy Policy. Provisions that by their nature should survive termination will continue to apply.":["es":"Puedes dejar de usar PULSE cuando quieras. Podemos restringir o cancelar el acceso por incumplimiento de estos Términos, problemas de seguridad, riesgos para las personas, obligaciones legales o conductas que amenacen a los usuarios o al servicio. Cuando esté disponible la eliminación de cuentas, el procedimiento y las reglas de conservación de datos se describirán en la Política de privacidad. Las disposiciones que deban seguir vigentes por su naturaleza continuarán aplicándose.","fr":"Vous pouvez cesser d’utiliser PULSE à tout moment. Nous pouvons restreindre ou résilier l’accès en cas de violation des présentes Conditions, de problèmes de sécurité, de risques pour les personnes, d’obligations légales ou de comportement menaçant les utilisateurs ou le service. Lorsque la suppression de compte est disponible, la procédure et les règles de conservation des données figurent dans la Politique de confidentialité. Les dispositions qui doivent par nature survivre à la résiliation restent applicables.","pt":"Você pode parar de usar o PULSE a qualquer momento. Podemos restringir ou encerrar o acesso em caso de violação destes Termos, preocupações de segurança, riscos à proteção das pessoas, exigências legais ou conduta que ameace usuários ou o serviço. Quando a exclusão de conta estiver disponível, o processo e as regras de retenção de dados estarão na Política de Privacidade. As disposições que, por sua natureza, devam continuar após o encerramento permanecerão em vigor.","de":"Du kannst PULSE jederzeit nicht mehr nutzen. Wir können den Zugang bei Verstößen gegen diese Bedingungen, Sicherheitsbedenken, Gefahren, gesetzlichen Anforderungen oder Verhalten, das Nutzer oder den Dienst bedroht, einschränken oder beenden. Soweit eine Kontolöschung verfügbar ist, werden Verfahren und Datenaufbewahrungsregeln in der Datenschutzerklärung beschrieben. Bestimmungen, die ihrer Natur nach fortgelten sollen, bleiben wirksam.","zh":"你可以随时停止使用 PULSE。如果违反本条款、存在安全顾虑或风险、法律要求，或行为威胁用户或服务，我们可能限制或终止访问。如可删除账户，相关流程和数据保留规则将在隐私政策中说明。按其性质应在终止后继续有效的条款仍然适用。","ja":"いつでも PULSE の利用を停止できます。本規約違反、安全上の懸念、危険、法的要件、またはユーザーやサービスを脅かす行為がある場合、アクセスを制限または終了することがあります。アカウント削除が可能な場合、その手続きとデータ保持規則はプライバシーポリシーに記載されます。性質上終了後も存続すべき条項は引き続き適用されます。","ko":"언제든지 PULSE 사용을 중단할 수 있습니다. 본 약관 위반, 보안 우려, 안전 위험, 법적 요구 또는 사용자나 서비스를 위협하는 행위가 있으면 접근을 제한하거나 종료할 수 있습니다. 계정 삭제가 가능한 경우 관련 절차와 데이터 보관 규칙은 개인정보 처리방침에 설명됩니다. 성격상 종료 후에도 유효해야 하는 조항은 계속 적용됩니다.","ar":"يمكنك التوقف عن استخدام PULSE في أي وقت. وقد نقيّد الوصول أو ننهيه بسبب مخالفة هذه الشروط أو مخاوف أمنية أو مخاطر سلامة أو متطلبات قانونية أو سلوك يهدد المستخدمين أو الخدمة. عند توفر حذف الحساب، توضح سياسة الخصوصية الإجراء وقواعد الاحتفاظ بالبيانات. وتظل الأحكام التي تقتضي طبيعتها استمرارها بعد الإنهاء سارية.","hi":"आप किसी भी समय PULSE का उपयोग बंद कर सकते हैं। इन शर्तों के उल्लंघन, सुरक्षा चिंताओं, सुरक्षा जोखिमों, कानूनी आवश्यकताओं या उपयोगकर्ताओं/सेवा को खतरा पहुँचाने वाले व्यवहार पर हम पहुँच सीमित या समाप्त कर सकते हैं। जहाँ खाता हटाना उपलब्ध है, प्रक्रिया और डेटा-संरक्षण नियम गोपनीयता नीति में बताए गए हैं। स्वभावतः समाप्ति के बाद भी लागू रहने वाले प्रावधान प्रभावी रहेंगे।"],
 "To the extent permitted by law, PULSE is provided on an 'as available' basis. We do not promise that the service will always meet every need, remain uninterrupted, or be free of errors. Nothing in these Terms excludes warranties, rights, or remedies that cannot legally be excluded.":["es":"En la medida permitida por la ley, PULSE se ofrece «según disponibilidad». No prometemos que el servicio satisfaga siempre todas las necesidades, funcione sin interrupciones o esté libre de errores. Estos Términos no excluyen garantías, derechos ni recursos que legalmente no puedan excluirse.","fr":"Dans la mesure permise par la loi, PULSE est fourni « selon disponibilité ». Nous ne garantissons pas que le service répondra toujours à tous les besoins, fonctionnera sans interruption ou sera exempt d’erreurs. Aucune disposition des présentes Conditions n’exclut les garanties, droits ou recours qui ne peuvent légalement être exclus.","pt":"Na medida permitida por lei, o PULSE é fornecido «conforme disponível». Não prometemos que o serviço atenderá sempre a todas as necessidades, funcionará sem interrupções ou estará livre de erros. Nada nestes Termos exclui garantias, direitos ou recursos que não possam ser legalmente excluídos.","de":"Soweit gesetzlich zulässig, wird PULSE „wie verfügbar“ bereitgestellt. Wir versprechen nicht, dass der Dienst stets alle Anforderungen erfüllt, unterbrechungsfrei läuft oder fehlerfrei ist. Diese Bedingungen schließen keine Garantien, Rechte oder Rechtsbehelfe aus, die gesetzlich nicht ausgeschlossen werden dürfen.","zh":"在法律允许的范围内，PULSE 按“现有可用状态”提供。我们不承诺服务始终满足所有需求、不会中断或没有错误。本条款不排除法律上不得排除的保证、权利或救济。","ja":"法律で認められる範囲で、PULSE は「提供可能な状態」で提供されます。サービスが常にすべてのニーズを満たすこと、中断しないこと、エラーがないことは保証しません。本規約は、法律上排除できない保証、権利、救済を排除するものではありません。","ko":"법률이 허용하는 범위에서 PULSE는 ‘제공 가능한 상태’로 제공됩니다. 서비스가 항상 모든 요구를 충족하거나 중단 없이 작동하거나 오류가 없다고 보장하지 않습니다. 본 약관은 법률상 배제할 수 없는 보증, 권리 또는 구제수단을 배제하지 않습니다.","ar":"بالقدر الذي يسمح به القانون، تُقدَّم PULSE على أساس «التوفر الحالي». لا نعد بأن الخدمة ستلبي كل الاحتياجات دائمًا أو ستعمل دون انقطاع أو أخطاء. لا تستبعد هذه الشروط أي ضمانات أو حقوق أو سبل انتصاف لا يجوز استبعادها قانونًا.","hi":"कानून द्वारा अनुमत सीमा तक PULSE ‘जैसा उपलब्ध है’ आधार पर प्रदान किया जाता है। हम वादा नहीं करते कि सेवा हमेशा हर आवश्यकता पूरी करेगी, बिना रुकावट चलेगी या त्रुटि-मुक्त होगी। ये शर्तें उन वारंटियों, अधिकारों या उपायों को बाहर नहीं करतीं जिन्हें कानूनन बाहर नहीं किया जा सकता।"],
 "To the extent permitted by applicable law, PULSE and its operator will not be liable for indirect, incidental, special, consequential, or punitive losses arising from use of the service. Nothing in these Terms limits liability where doing so would be unlawful, including liability that cannot legally be limited.":["es":"En la medida permitida por la ley aplicable, PULSE y su operador no serán responsables de pérdidas indirectas, incidentales, especiales, consecuentes o punitivas derivadas del uso del servicio. Nada de estos Términos limita la responsabilidad cuando hacerlo sea ilegal, incluida aquella que legalmente no pueda limitarse.","fr":"Dans la mesure permise par la loi applicable, PULSE et son exploitant ne seront pas responsables des pertes indirectes, accessoires, spéciales, consécutives ou punitives résultant de l’utilisation du service. Rien dans ces Conditions ne limite une responsabilité lorsque cela serait illégal, notamment une responsabilité qui ne peut légalement être limitée.","pt":"Na medida permitida pela lei aplicável, o PULSE e seu operador não serão responsáveis por perdas indiretas, incidentais, especiais, consequenciais ou punitivas decorrentes do uso do serviço. Nada nestes Termos limita uma responsabilidade quando isso for ilegal, inclusive aquela que não pode ser legalmente limitada.","de":"Soweit geltendes Recht dies zulässt, haften PULSE und dessen Betreiber nicht für mittelbare, beiläufige, besondere, Folge- oder Strafschäden aus der Nutzung des Dienstes. Nichts in diesen Bedingungen beschränkt eine Haftung, wenn dies rechtswidrig wäre, einschließlich einer gesetzlich nicht beschränkbaren Haftung.","zh":"在适用法律允许的范围内，PULSE 及其运营方不对因使用服务产生的间接、附带、特殊、后果性或惩罚性损失承担责任。本条款不会在法律禁止的情况下限制责任，包括依法不得限制的责任。","ja":"適用法で認められる範囲で、PULSE および運営者はサービスの利用に起因する間接的、付随的、特別、結果的または懲罰的損失について責任を負いません。本規約は、違法となる場合の責任や、法律上制限できない責任を制限するものではありません。","ko":"관련 법률이 허용하는 범위에서 PULSE와 운영자는 서비스 이용으로 발생한 간접적, 부수적, 특별, 결과적 또는 징벌적 손실에 대해 책임지지 않습니다. 본 약관은 위법한 경우의 책임이나 법률상 제한할 수 없는 책임을 제한하지 않습니다.","ar":"بالقدر الذي يسمح به القانون المعمول به، لا تتحمل PULSE ومشغّلها مسؤولية الخسائر غير المباشرة أو العرضية أو الخاصة أو التبعية أو العقابية الناشئة عن استخدام الخدمة. ولا تحد هذه الشروط من المسؤولية إذا كان ذلك غير قانوني، بما في ذلك المسؤولية التي لا يجوز تقييدها قانونًا.","hi":"लागू कानून द्वारा अनुमत सीमा तक, सेवा के उपयोग से होने वाले अप्रत्यक्ष, आकस्मिक, विशेष, परिणामी या दंडात्मक नुकसान के लिए PULSE और उसका संचालक उत्तरदायी नहीं होंगे। जहाँ ऐसा करना गैरकानूनी होगा, वहाँ ये शर्तें दायित्व को सीमित नहीं करतीं, जिसमें कानूनन असीमित रहने वाला दायित्व भी शामिल है।"],
 "The governing law and dispute-resolution process will be identified by the operator in the version applicable to your location, subject to mandatory consumer protections and other non-waivable rights under applicable law.":["es":"La legislación aplicable y el procedimiento para resolver disputas serán identificados por el operador en la versión correspondiente a tu ubicación, sujetos a las protecciones obligatorias para consumidores y a otros derechos irrenunciables conforme a la ley aplicable.","fr":"La loi applicable et la procédure de résolution des litiges seront précisées par l’exploitant dans la version correspondant à votre lieu de résidence, sous réserve des protections impératives des consommateurs et des autres droits auxquels il ne peut être renoncé en vertu de la loi.","pt":"A legislação aplicável e o processo de resolução de disputas serão identificados pelo operador na versão válida para sua localização, sujeitos às proteções obrigatórias ao consumidor e a outros direitos irrenunciáveis previstos na lei.","de":"Das anwendbare Recht und das Verfahren zur Streitbeilegung werden vom Betreiber in der für deinen Standort geltenden Fassung angegeben, vorbehaltlich zwingender Verbraucherschutzbestimmungen und anderer unverzichtbarer Rechte.","zh":"运营方将在适用于你所在地的版本中说明适用法律和争议解决程序，同时遵守强制性消费者保护规定及适用法律下其他不可放弃的权利。","ja":"準拠法および紛争解決手続きは、居住地に適用される版で運営者が明示します。ただし、強制的な消費者保護および適用法上放棄できないその他の権利が優先されます。","ko":"준거법과 분쟁 해결 절차는 이용자 지역에 적용되는 버전에서 운영자가 명시하며, 강행적 소비자 보호 및 관련 법률상 포기할 수 없는 권리는 그대로 적용됩니다.","ar":"سيحدد المشغّل القانون الحاكم وإجراءات تسوية النزاعات في النسخة المطبقة على موقعك، مع مراعاة حماية المستهلك الإلزامية والحقوق الأخرى التي لا يجوز التنازل عنها بموجب القانون.","hi":"लागू कानून और विवाद समाधान प्रक्रिया का उल्लेख संचालक आपके स्थान पर लागू संस्करण में करेगा, जो अनिवार्य उपभोक्ता सुरक्षा और लागू कानून के तहत छोड़े न जा सकने वाले अन्य अधिकारों के अधीन होगा।"],
 "For questions about these Terms, contact the PULSE team using the official contact details published by PULSE.":["es":"Si tienes preguntas sobre estos Términos, contacta con el equipo de PULSE mediante los datos oficiales publicados por PULSE.","fr":"Pour toute question concernant ces Conditions, contactez l’équipe PULSE à l’aide des coordonnées officielles publiées par PULSE.","pt":"Para dúvidas sobre estes Termos, entre em contato com a equipe do PULSE pelos dados oficiais de contato publicados pelo PULSE.","de":"Bei Fragen zu diesen Bedingungen kontaktiere das PULSE-Team über die offiziell von PULSE veröffentlichten Kontaktdaten.","zh":"如对本条款有疑问，请通过 PULSE 公布的官方联系方式联系 PULSE 团队。","ja":"本規約について質問がある場合は、PULSE が公開している公式連絡先を使って PULSE チームにお問い合わせください。","ko":"본 약관에 관한 질문은 PULSE가 게시한 공식 연락처를 통해 PULSE 팀에 문의하세요.","ar":"للاستفسارات حول هذه الشروط، تواصل مع فريق PULSE باستخدام بيانات الاتصال الرسمية التي تنشرها PULSE.","hi":"इन शर्तों के बारे में प्रश्नों के लिए PULSE द्वारा प्रकाशित आधिकारिक संपर्क विवरण के माध्यम से PULSE टीम से संपर्क करें।"],
 "Depending on the features you use, information may include your name, username, email address, profile details, posts, comments, media, support requests, reports, and preferences. Avoid including sensitive personal information in public posts or profile fields.":["es":"Según las funciones que uses, la información puede incluir tu nombre, nombre de usuario, correo electrónico, datos del perfil, publicaciones, comentarios, archivos multimedia, solicitudes de soporte, denuncias y preferencias. Evita incluir información personal sensible en publicaciones públicas o campos del perfil.","fr":"Selon les fonctionnalités utilisées, les informations peuvent inclure votre nom, nom d’utilisateur, adresse e-mail, profil, publications, commentaires, médias, demandes d’assistance, signalements et préférences. Évitez d’inclure des informations personnelles sensibles dans les publications publiques ou les champs de profil.","pt":"Dependendo dos recursos utilizados, as informações podem incluir nome, nome de usuário, e-mail, detalhes do perfil, publicações, comentários, mídia, solicitações de suporte, denúncias e preferências. Evite incluir informações pessoais sensíveis em publicações públicas ou campos do perfil.","de":"Je nach genutzten Funktionen können die Daten deinen Namen, Benutzernamen, deine E-Mail-Adresse, Profildetails, Beiträge, Kommentare, Medien, Supportanfragen, Meldungen und Einstellungen umfassen. Veröffentliche keine sensiblen personenbezogenen Daten in öffentlichen Beiträgen oder Profilfeldern.","zh":"根据你使用的功能，信息可能包括姓名、用户名、电子邮件地址、个人资料、帖子、评论、媒体、支持请求、举报和偏好设置。请勿在公开帖子或个人资料字段中填写敏感个人信息。","ja":"使用する機能によって、氏名、ユーザー名、メールアドレス、プロフィール情報、投稿、コメント、メディア、サポート依頼、報告、設定などが含まれる場合があります。公開投稿やプロフィール欄に機微な個人情報を含めないでください。","ko":"사용하는 기능에 따라 이름, 사용자 이름, 이메일 주소, 프로필 정보, 게시물, 댓글, 미디어, 지원 요청, 신고 및 환경설정이 포함될 수 있습니다. 공개 게시물이나 프로필 입력란에 민감한 개인정보를 포함하지 마세요.","ar":"بحسب الميزات التي تستخدمها، قد تشمل المعلومات اسمك واسم المستخدم والبريد الإلكتروني وتفاصيل الملف الشخصي والمنشورات والتعليقات والوسائط وطلبات الدعم والبلاغات والتفضيلات. تجنب إدراج معلومات شخصية حساسة في المنشورات العامة أو حقول الملف الشخصي.","hi":"आपके उपयोग की गई सुविधाओं के आधार पर जानकारी में नाम, उपयोगकर्ता नाम, ईमेल पता, प्रोफ़ाइल विवरण, पोस्ट, टिप्पणियाँ, मीडिया, सहायता अनुरोध, रिपोर्ट और प्राथमिकताएँ शामिल हो सकती हैं। सार्वजनिक पोस्ट या प्रोफ़ाइल फ़ील्ड में संवेदनशील व्यक्तिगत जानकारी न डालें।"],
 "When you access PULSE, we may process technical information needed to operate and secure the service, such as app and operating-system versions, device information, connection data, diagnostic events, and security logs. The information actually collected depends on the systems used to operate PULSE.":["es":"Cuando accedes a PULSE, podemos tratar información técnica necesaria para operar y proteger el servicio, como las versiones de la aplicación y del sistema operativo, información del dispositivo, datos de conexión, eventos de diagnóstico y registros de seguridad. La información que realmente se recopile dependerá de los sistemas usados para operar PULSE.","fr":"Lorsque vous accédez à PULSE, nous pouvons traiter les informations techniques nécessaires au fonctionnement et à la sécurité du service, telles que les versions de l’application et du système, les informations sur l’appareil, les données de connexion, les événements de diagnostic et les journaux de sécurité. Les données réellement collectées dépendent des systèmes utilisés pour exploiter PULSE.","pt":"Ao acessar o PULSE, podemos processar informações técnicas necessárias à operação e à segurança do serviço, como versões do aplicativo e do sistema operacional, dados do dispositivo e da conexão, eventos de diagnóstico e registros de segurança. As informações efetivamente coletadas dependem dos sistemas usados para operar o PULSE.","de":"Beim Zugriff auf PULSE können wir technische Informationen verarbeiten, die für Betrieb und Sicherheit erforderlich sind, etwa App- und Betriebssystemversionen, Geräteinformationen, Verbindungsdaten, Diagnoseereignisse und Sicherheitsprotokolle. Welche Daten tatsächlich erhoben werden, hängt von den für PULSE eingesetzten Systemen ab.","zh":"访问 PULSE 时，我们可能处理运营和保障服务安全所需的技术信息，例如应用和操作系统版本、设备信息、连接数据、诊断事件及安全日志。实际收集的信息取决于运营 PULSE 所使用的系统。","ja":"PULSE にアクセスすると、サービスの運用と安全確保に必要な技術情報（アプリや OS のバージョン、端末情報、接続データ、診断イベント、セキュリティログなど）を処理する場合があります。実際に収集する情報は PULSE の運用に使用するシステムによって異なります。","ko":"PULSE에 접속하면 서비스 운영과 보안에 필요한 기술 정보(앱 및 운영체제 버전, 기기 정보, 연결 데이터, 진단 이벤트, 보안 로그 등)를 처리할 수 있습니다. 실제 수집 정보는 PULSE 운영에 사용되는 시스템에 따라 달라집니다.","ar":"عند الوصول إلى PULSE، قد نعالج معلومات تقنية لازمة لتشغيل الخدمة وتأمينها، مثل إصدارات التطبيق ونظام التشغيل ومعلومات الجهاز وبيانات الاتصال وأحداث التشخيص وسجلات الأمان. وتعتمد المعلومات التي تُجمع فعليًا على الأنظمة المستخدمة لتشغيل PULSE.","hi":"PULSE तक पहुँचने पर हम सेवा चलाने और सुरक्षित रखने के लिए आवश्यक तकनीकी जानकारी, जैसे ऐप और ऑपरेटिंग सिस्टम के संस्करण, डिवाइस जानकारी, कनेक्शन डेटा, निदान घटनाएँ और सुरक्षा लॉग, संसाधित कर सकते हैं। वास्तव में एकत्र जानकारी PULSE चलाने वाली प्रणालियों पर निर्भर करती है।"],
 "We use information to provide requested features, maintain accounts, display content to intended audiences, protect accounts and the platform, prevent spam and fraud, investigate reports, respond to support requests, troubleshoot problems, improve reliability, enforce our Terms, and comply with applicable law.":["es":"Usamos la información para ofrecer las funciones solicitadas, mantener cuentas, mostrar contenido a sus destinatarios, proteger las cuentas y la plataforma, prevenir spam y fraude, investigar denuncias, responder a solicitudes de soporte, solucionar problemas, mejorar la fiabilidad, hacer cumplir estos Términos y cumplir la ley aplicable.","fr":"Nous utilisons les informations pour fournir les fonctionnalités demandées, gérer les comptes, afficher le contenu au public prévu, protéger les comptes et la plateforme, prévenir le spam et la fraude, examiner les signalements, répondre aux demandes d’assistance, résoudre les problèmes, améliorer la fiabilité, faire respecter nos Conditions et respecter la loi applicable.","pt":"Usamos informações para fornecer recursos solicitados, manter contas, exibir conteúdo ao público pretendido, proteger contas e a plataforma, prevenir spam e fraude, investigar denúncias, responder a pedidos de suporte, solucionar problemas, melhorar a confiabilidade, aplicar estes Termos e cumprir a legislação aplicável.","de":"Wir verwenden Daten, um angeforderte Funktionen bereitzustellen, Konten zu verwalten, Inhalte den vorgesehenen Zielgruppen anzuzeigen, Konten und Plattform zu schützen, Spam und Betrug zu verhindern, Meldungen zu untersuchen, Supportanfragen zu beantworten, Probleme zu beheben, Zuverlässigkeit zu verbessern, diese Bedingungen durchzusetzen und geltendes Recht einzuhalten.","zh":"我们使用信息来提供所请求的功能、维护账户、向预期受众展示内容、保护账户和平台、防止垃圾信息与欺诈、调查举报、回应支持请求、排查问题、提高可靠性、执行本条款并遵守适用法律。","ja":"情報は、要求された機能の提供、アカウント管理、対象ユーザーへのコンテンツ表示、アカウントとプラットフォームの保護、スパムや詐欺の防止、報告の調査、サポート依頼への対応、問題の解決、信頼性の向上、本規約の執行、適用法の遵守に使用します。","ko":"정보는 요청된 기능 제공, 계정 유지, 대상 사용자에게 콘텐츠 표시, 계정과 플랫폼 보호, 스팸 및 사기 방지, 신고 조사, 지원 요청 응답, 문제 해결, 신뢰성 향상, 약관 집행 및 관련 법률 준수를 위해 사용됩니다.","ar":"نستخدم المعلومات لتوفير الميزات المطلوبة، وإدارة الحسابات، وعرض المحتوى للجمهور المقصود، وحماية الحسابات والمنصة، ومنع الرسائل المزعجة والاحتيال، والتحقيق في البلاغات، والرد على طلبات الدعم، واستكشاف المشكلات، وتحسين الموثوقية، وإنفاذ شروطنا، والامتثال للقانون.","hi":"हम जानकारी का उपयोग माँगी गई सुविधाएँ देने, खाते बनाए रखने, लक्षित दर्शकों को कंटेंट दिखाने, खातों और प्लेटफ़ॉर्म की सुरक्षा, स्पैम और धोखाधड़ी रोकने, रिपोर्ट की जाँच, सहायता अनुरोधों का जवाब, समस्याएँ हल करने, विश्वसनीयता सुधारने, शर्तें लागू करने और लागू कानून का पालन करने के लिए करते हैं।"],
 "Your username, profile details, posts, comments, and other interactions may be visible to the audiences permitted by the relevant features and settings. Other users may copy or share content they can access. Deleting a post cannot remove copies already made by other users.":["es":"Tu nombre de usuario, los datos de tu perfil, publicaciones, comentarios y otras interacciones pueden ser visibles para las audiencias permitidas por las funciones y configuraciones correspondientes. Otros usuarios pueden copiar o compartir el contenido al que tengan acceso. Eliminar una publicación no elimina las copias que otros usuarios ya hayan hecho.","fr":"Votre nom d’utilisateur, les détails de votre profil, vos publications, commentaires et autres interactions peuvent être visibles par les publics autorisés par les fonctionnalités et paramètres concernés. D’autres utilisateurs peuvent copier ou partager le contenu auquel ils ont accès. Supprimer une publication ne supprime pas les copies déjà réalisées par d’autres utilisateurs.","pt":"Seu nome de usuário, dados do perfil, publicações, comentários e outras interações podem ficar visíveis para os públicos permitidos pelos recursos e configurações relevantes. Outros usuários podem copiar ou compartilhar conteúdo acessível. Excluir uma publicação não remove cópias já feitas por outros usuários.","de":"Dein Benutzername, deine Profildetails, Beiträge, Kommentare und sonstigen Interaktionen können für Zielgruppen sichtbar sein, die durch die jeweiligen Funktionen und Einstellungen zugelassen sind. Andere Nutzer können zugängliche Inhalte kopieren oder teilen. Das Löschen eines Beitrags entfernt keine bereits von anderen erstellten Kopien.","zh":"你的用户名、个人资料、帖子、评论及其他互动可能对相关功能和设置允许的受众可见。其他用户可能复制或分享他们能够访问的内容。删除帖子无法删除其他用户已制作的副本。","ja":"ユーザー名、プロフィール情報、投稿、コメント、その他のやり取りは、関連機能や設定で許可された対象者に表示される場合があります。他のユーザーはアクセスできるコンテンツをコピーまたは共有できます。投稿を削除しても、他者が既に作成したコピーは削除できません。","ko":"사용자 이름, 프로필 정보, 게시물, 댓글 및 기타 상호작용은 관련 기능과 설정에서 허용된 대상에게 보일 수 있습니다. 다른 사용자는 접근 가능한 콘텐츠를 복사하거나 공유할 수 있습니다. 게시물을 삭제해도 다른 사용자가 이미 만든 사본은 제거되지 않습니다.","ar":"قد يكون اسم المستخدم وتفاصيل الملف الشخصي والمنشورات والتعليقات والتفاعلات الأخرى مرئية للجمهور الذي تسمح به الميزات والإعدادات ذات الصلة. قد ينسخ المستخدمون الآخرون المحتوى الذي يمكنهم الوصول إليه أو يشاركوه. لا يؤدي حذف منشور إلى إزالة النسخ التي أنشأها الآخرون بالفعل.","hi":"आपका उपयोगकर्ता नाम, प्रोफ़ाइल विवरण, पोस्ट, टिप्पणियाँ और अन्य गतिविधियाँ संबंधित सुविधाओं और सेटिंग्स द्वारा अनुमत दर्शकों को दिखाई दे सकती हैं। अन्य उपयोगकर्ता उस कंटेंट को कॉपी या साझा कर सकते हैं जिस तक उनकी पहुँच है। पोस्ट हटाने से अन्य उपयोगकर्ताओं द्वारा बनाई गई प्रतियाँ नहीं हटतीं।"],
 "PULSE does not sell users' personal information. Information may be shared with service providers that help operate the service, with people you choose to share content with, when reasonably necessary to protect users or security, when required by valid legal process, or in connection with a business transfer subject to appropriate safeguards and applicable law.":["es":"PULSE no vende la información personal de sus usuarios. Podemos compartir información con proveedores que ayudan a operar el servicio, con las personas con quienes eliges compartir contenido, cuando sea razonablemente necesario para proteger a los usuarios o la seguridad, cuando lo exija un proceso legal válido o en relación con una transferencia empresarial sujeta a garantías adecuadas y a la ley aplicable.","fr":"PULSE ne vend pas les informations personnelles des utilisateurs. Les informations peuvent être partagées avec les prestataires qui contribuent au fonctionnement du service, les personnes avec lesquelles vous choisissez de partager du contenu, lorsque cela est raisonnablement nécessaire pour protéger les utilisateurs ou la sécurité, lorsqu’une procédure légale valide l’exige, ou dans le cadre d’un transfert d’entreprise assorti de garanties appropriées et conforme à la loi.","pt":"O PULSE não vende informações pessoais dos usuários. As informações podem ser compartilhadas com prestadores que ajudam a operar o serviço, com pessoas com quem você decide compartilhar conteúdo, quando razoavelmente necessário para proteger usuários ou a segurança, quando exigido por processo legal válido ou em uma transferência comercial sujeita a salvaguardas adequadas e à legislação aplicável.","de":"PULSE verkauft keine personenbezogenen Daten von Nutzern. Daten können an Dienstleister weitergegeben werden, die den Dienst betreiben, an Personen, mit denen du Inhalte teilen möchtest, soweit dies zum Schutz von Nutzern oder der Sicherheit angemessen erforderlich ist, aufgrund gültiger rechtlicher Verfahren oder im Zusammenhang mit einer Unternehmensübertragung unter geeigneten Schutzmaßnahmen und nach geltendem Recht.","zh":"PULSE 不出售用户的个人信息。信息可能会与协助运营服务的服务提供商、你选择分享内容的对象共享；在合理必要时为保护用户或安全而共享；在有效法律程序要求时共享；或在采取适当保障措施并遵守适用法律的业务转让中共享。","ja":"PULSE はユーザーの個人情報を販売しません。情報は、サービス運営を支援する事業者、あなたがコンテンツ共有を選んだ相手と共有される場合があります。また、ユーザーや安全を守るため合理的に必要な場合、有効な法的手続きで求められる場合、適切な保護措置と適用法に従った事業譲渡に関連する場合にも共有されることがあります。","ko":"PULSE는 이용자의 개인정보를 판매하지 않습니다. 정보는 서비스 운영을 돕는 제공업체, 이용자가 콘텐츠 공유 대상으로 선택한 사람과 공유될 수 있으며, 사용자나 보안을 보호하기 위해 합리적으로 필요한 경우, 유효한 법적 절차가 요구하는 경우, 적절한 보호 조치와 관련 법률에 따른 사업 양도와 관련된 경우에도 공유될 수 있습니다.","ar":"لا تبيع PULSE المعلومات الشخصية للمستخدمين. قد تُشارك المعلومات مع مزودي الخدمات الذين يساعدون في تشغيل الخدمة، أو مع الأشخاص الذين تختار مشاركة المحتوى معهم، أو عند الضرورة المعقولة لحماية المستخدمين أو الأمن، أو عندما تقتضي ذلك إجراءات قانونية صحيحة، أو ضمن نقل تجاري يخضع لضمانات مناسبة والقانون المعمول به.","hi":"PULSE उपयोगकर्ताओं की व्यक्तिगत जानकारी नहीं बेचता। जानकारी सेवा चलाने में मदद करने वाले सेवा प्रदाताओं, आपके चुने हुए कंटेंट-साझाकरण प्राप्तकर्ताओं के साथ, उपयोगकर्ताओं या सुरक्षा की रक्षा के लिए उचित रूप से आवश्यक होने पर, वैध कानूनी प्रक्रिया की माँग पर, या उचित सुरक्षा उपायों और लागू कानून के अधीन व्यावसायिक हस्तांतरण के दौरान साझा की जा सकती है।"],
 "Providers supporting hosting, storage, authentication, security, diagnostics, and support may process information on PULSE's behalf. Their access should be limited to what is necessary for their work and governed by appropriate agreements and safeguards.":["es":"Los proveedores de alojamiento, almacenamiento, autenticación, seguridad, diagnóstico y soporte pueden tratar información en nombre de PULSE. Su acceso debe limitarse a lo necesario para su trabajo y regirse por acuerdos y medidas de protección adecuados.","fr":"Les prestataires d’hébergement, de stockage, d’authentification, de sécurité, de diagnostic et d’assistance peuvent traiter des informations pour le compte de PULSE. Leur accès doit être limité à ce qui est nécessaire à leur mission et régi par des accords et des garanties appropriés.","pt":"Provedores de hospedagem, armazenamento, autenticação, segurança, diagnóstico e suporte podem processar informações em nome do PULSE. O acesso deve se limitar ao necessário para o trabalho e ser regido por acordos e salvaguardas adequados.","de":"Anbieter für Hosting, Speicherung, Authentifizierung, Sicherheit, Diagnose und Support können Daten im Auftrag von PULSE verarbeiten. Ihr Zugriff sollte auf das für ihre Aufgaben Erforderliche beschränkt und durch geeignete Vereinbarungen und Schutzmaßnahmen geregelt sein.","zh":"提供托管、存储、身份验证、安全、诊断和支持服务的供应商可能代表 PULSE 处理信息。其访问权限应限于工作所需，并受适当协议和保障措施约束。","ja":"ホスティング、保存、認証、セキュリティ、診断、サポートを提供する事業者は、PULSE に代わって情報を処理する場合があります。アクセスは業務上必要な範囲に限定し、適切な契約と保護措置で管理する必要があります。","ko":"호스팅, 저장, 인증, 보안, 진단 및 지원 제공업체는 PULSE를 대신해 정보를 처리할 수 있습니다. 접근은 업무에 필요한 범위로 제한하고 적절한 계약 및 보호 조치의 적용을 받아야 합니다.","ar":"قد يعالج مزودو الاستضافة والتخزين والمصادقة والأمان والتشخيص والدعم المعلومات نيابةً عن PULSE. وينبغي أن يقتصر وصولهم على ما يلزم لعملهم وأن يخضع لاتفاقيات وضمانات مناسبة.","hi":"होस्टिंग, स्टोरेज, प्रमाणीकरण, सुरक्षा, निदान और सहायता देने वाले प्रदाता PULSE की ओर से जानकारी संसाधित कर सकते हैं। उनकी पहुँच काम के लिए आवश्यक सीमा तक सीमित होनी चाहिए और उचित समझौतों व सुरक्षा उपायों के अधीन होनी चाहिए।"],
 "We use reasonable administrative, technical, and organizational measures designed to protect personal information against unauthorized access, loss, alteration, and disclosure. No internet-based service can guarantee absolute security.":["es":"Usamos medidas administrativas, técnicas y organizativas razonables diseñadas para proteger la información personal contra el acceso, la pérdida, la alteración y la divulgación no autorizados. Ningún servicio de internet puede garantizar una seguridad absoluta.","fr":"Nous utilisons des mesures administratives, techniques et organisationnelles raisonnables destinées à protéger les informations personnelles contre l’accès non autorisé, la perte, la modification et la divulgation. Aucun service en ligne ne peut garantir une sécurité absolue.","pt":"Usamos medidas administrativas, técnicas e organizacionais razoáveis para proteger informações pessoais contra acesso não autorizado, perda, alteração e divulgação. Nenhum serviço na internet pode garantir segurança absoluta.","de":"Wir setzen angemessene administrative, technische und organisatorische Maßnahmen ein, um personenbezogene Daten vor unbefugtem Zugriff, Verlust, Änderung und Offenlegung zu schützen. Kein internetbasierter Dienst kann absolute Sicherheit garantieren.","zh":"我们采用合理的管理、技术和组织措施，旨在保护个人信息免遭未经授权的访问、丢失、篡改和披露。任何互联网服务都无法保证绝对安全。","ja":"個人情報を不正アクセス、紛失、改変、開示から保護するため、合理的な管理的・技術的・組織的対策を講じます。インターネット上のサービスで絶対的な安全を保証することはできません。","ko":"개인정보를 무단 접근, 손실, 변경 및 공개로부터 보호하기 위해 합리적인 관리적·기술적·조직적 조치를 사용합니다. 인터넷 기반 서비스는 절대적인 보안을 보장할 수 없습니다.","ar":"نستخدم تدابير إدارية وتقنية وتنظيمية معقولة تهدف إلى حماية المعلومات الشخصية من الوصول غير المصرح به أو الفقد أو التغيير أو الإفصاح. لا يمكن لأي خدمة عبر الإنترنت ضمان الأمان المطلق.","hi":"हम व्यक्तिगत जानकारी को अनधिकृत पहुँच, हानि, बदलाव और खुलासे से बचाने के लिए उचित प्रशासनिक, तकनीकी और संगठनात्मक उपाय अपनाते हैं। इंटरनेट-आधारित कोई सेवा पूर्ण सुरक्षा की गारंटी नहीं दे सकती।"],
 "We retain information for as long as reasonably necessary for the purposes described in this Policy, including security, dispute resolution, and legal compliance. When information is no longer needed, we delete it, anonymize it, or securely dispose of it as appropriate. Backup copies may remain until they are overwritten or removed.":["es":"Conservamos la información durante el tiempo razonablemente necesario para los fines descritos en esta Política, incluida la seguridad, la resolución de disputas y el cumplimiento legal. Cuando deja de ser necesaria, la eliminamos, anonimizamos o destruimos de forma segura, según corresponda. Las copias de seguridad pueden permanecer hasta que se sobrescriban o eliminen.","fr":"Nous conservons les informations aussi longtemps que raisonnablement nécessaire aux fins décrites dans cette Politique, notamment la sécurité, le règlement des litiges et le respect de la loi. Lorsqu’elles ne sont plus nécessaires, nous les supprimons, les anonymisons ou les éliminons de manière sécurisée, selon le cas. Des copies de sauvegarde peuvent subsister jusqu’à leur écrasement ou leur suppression.","pt":"Retemos informações pelo tempo razoavelmente necessário para os fins descritos nesta Política, incluindo segurança, resolução de disputas e cumprimento legal. Quando deixam de ser necessárias, nós as excluímos, anonimizamos ou descartamos com segurança, conforme apropriado. Cópias de backup podem permanecer até serem sobrescritas ou removidas.","de":"Wir speichern Daten so lange, wie es für die in dieser Erklärung beschriebenen Zwecke angemessen erforderlich ist, einschließlich Sicherheit, Streitbeilegung und Einhaltung gesetzlicher Vorgaben. Wenn Daten nicht mehr benötigt werden, löschen, anonymisieren oder entsorgen wir sie sicher. Sicherungskopien können bis zum Überschreiben oder Entfernen bestehen bleiben.","zh":"我们会在实现本政策所述目的所合理必要的期间内保留信息，包括安全、争议解决和遵守法律。信息不再需要时，我们会酌情删除、匿名化或安全处置。备份副本可能会保留到被覆盖或删除为止。","ja":"セキュリティ、紛争解決、法令遵守を含む本ポリシーの目的に合理的に必要な期間、情報を保持します。不要になった情報は、状況に応じて削除、匿名化、または安全に処分します。バックアップは上書きまたは削除されるまで残る場合があります。","ko":"보안, 분쟁 해결 및 법률 준수를 포함해 본 방침에 명시된 목적에 합리적으로 필요한 기간 동안 정보를 보관합니다. 더 이상 필요하지 않으면 상황에 따라 삭제, 익명화 또는 안전하게 폐기합니다. 백업 사본은 덮어쓰거나 제거될 때까지 남을 수 있습니다.","ar":"نحتفظ بالمعلومات للمدة اللازمة بشكل معقول للأغراض الموضحة في هذه السياسة، بما في ذلك الأمن وتسوية النزاعات والامتثال القانوني. وعندما لا تعود المعلومات ضرورية، نحذفها أو نجعلها مجهولة الهوية أو نتخلص منها بأمان حسب الاقتضاء. قد تبقى النسخ الاحتياطية حتى يتم استبدالها أو حذفها.","hi":"हम इस नीति में बताए गए उद्देश्यों, जैसे सुरक्षा, विवाद समाधान और कानूनी अनुपालन, के लिए उचित रूप से आवश्यक अवधि तक जानकारी रखते हैं। आवश्यकता समाप्त होने पर हम उसे हटाते, गुमनाम बनाते या सुरक्षित रूप से नष्ट करते हैं। बैकअप प्रतियाँ ओवरराइट या हटाए जाने तक रह सकती हैं।"],
 "Depending on your location, you may have rights to request access to, correction of, or deletion of your information, withdraw consent, object to certain processing, request a portable copy, or complain to a data protection authority. Contact PULSE through its published privacy contact to submit a request. We may need to verify your identity and may apply lawful exceptions.":["es":"Según tu ubicación, puedes tener derecho a solicitar acceso, corrección o eliminación de tu información; retirar tu consentimiento; oponerte a ciertos tratamientos; solicitar una copia portátil; o presentar una reclamación ante una autoridad de protección de datos. Envía tu solicitud al contacto de privacidad publicado por PULSE. Puede que debamos verificar tu identidad y que se apliquen excepciones legales.","fr":"Selon votre lieu de résidence, vous pouvez avoir le droit de demander l’accès à vos informations, leur rectification ou leur suppression, de retirer votre consentement, de vous opposer à certains traitements, de demander une copie portable ou de déposer une plainte auprès d’une autorité de protection des données. Contactez PULSE via le contact de confidentialité publié pour soumettre une demande. Nous pouvons devoir vérifier votre identité et appliquer des exceptions légales.","pt":"Dependendo de onde você mora, você pode ter o direito de solicitar acesso, correção ou exclusão de suas informações, retirar o consentimento, contestar certos tratamentos, solicitar uma cópia portátil ou reclamar a uma autoridade de proteção de dados. Envie a solicitação pelo contato de privacidade publicado pelo PULSE. Talvez precisemos verificar sua identidade e aplicar exceções legais.","de":"Je nach Wohnort hast du möglicherweise das Recht, Auskunft, Berichtigung oder Löschung deiner Daten zu verlangen, eine Einwilligung zu widerrufen, bestimmten Verarbeitungen zu widersprechen, eine übertragbare Kopie anzufordern oder dich bei einer Datenschutzbehörde zu beschweren. Reiche Anfragen über den veröffentlichten Datenschutzkontakt von PULSE ein. Wir müssen möglicherweise deine Identität prüfen und können gesetzliche Ausnahmen anwenden.","zh":"根据你所在地区，你可能有权请求访问、更正或删除个人信息，撤回同意，反对某些处理，索取可携带副本，或向数据保护机构投诉。请通过 PULSE 公布的隐私联系方式提交请求。我们可能需要验证身份，并可能适用法律规定的例外。","ja":"居住地によっては、情報へのアクセス、訂正、削除の請求、同意の撤回、特定の処理への異議申し立て、移行可能なコピーの請求、データ保護機関への苦情申し立てなどの権利が認められる場合があります。PULSE が公開するプライバシー窓口に連絡してください。本人確認や法的例外の適用が必要となる場合があります。","ko":"거주 지역에 따라 정보 열람·정정·삭제 요청, 동의 철회, 특정 처리에 대한 이의 제기, 이동 가능한 사본 요청 또는 개인정보 보호 당국에 대한 민원 제기 권리가 있을 수 있습니다. PULSE가 게시한 개인정보 문의처로 요청을 보내세요. 신원 확인이 필요하거나 법적 예외가 적용될 수 있습니다.","ar":"بحسب موقعك، قد يحق لك طلب الوصول إلى معلوماتك أو تصحيحها أو حذفها، وسحب الموافقة، والاعتراض على بعض المعالجة، وطلب نسخة قابلة للنقل، أو تقديم شكوى إلى سلطة حماية البيانات. قدّم الطلب عبر جهة اتصال الخصوصية التي تنشرها PULSE. وقد نحتاج إلى التحقق من هويتك وتطبيق استثناءات قانونية.","hi":"आपके स्थान के आधार पर आपको अपनी जानकारी तक पहुँच, सुधार या हटाने का अनुरोध करने, सहमति वापस लेने, कुछ प्रसंस्करण पर आपत्ति करने, पोर्टेबल प्रति माँगने या डेटा सुरक्षा प्राधिकरण से शिकायत करने का अधिकार हो सकता है। अनुरोध के लिए PULSE के प्रकाशित गोपनीयता संपर्क से संपर्क करें। हमें आपकी पहचान सत्यापित करनी पड़ सकती है और कानूनी अपवाद लागू हो सकते हैं।"],
 "PULSE is intended for people who meet the minimum age requirements in the Terms of Service and applicable law. We do not knowingly process children's personal information in circumstances where doing so is prohibited or required consent has not been obtained. Where applicable law provides additional protections for minors, those protections apply.":["es":"PULSE está destinado a personas que cumplen la edad mínima establecida en los Términos del servicio y en la ley aplicable. No tratamos deliberadamente información personal de menores en circunstancias en las que esté prohibido o no se haya obtenido el consentimiento requerido. Cuando la ley aplicable otorgue protecciones adicionales a los menores, estas se aplicarán.","fr":"PULSE est destiné aux personnes qui respectent l’âge minimum prévu dans les Conditions d’utilisation et par la loi applicable. Nous ne traitons pas sciemment les informations personnelles d’enfants lorsque cela est interdit ou lorsque le consentement requis n’a pas été obtenu. Les protections supplémentaires accordées aux mineurs par la loi s’appliquent.","pt":"O PULSE destina-se a pessoas que atendem à idade mínima prevista nos Termos de Serviço e na legislação aplicável. Não processamos conscientemente informações pessoais de crianças quando isso é proibido ou quando o consentimento exigido não foi obtido. Aplicam-se as proteções adicionais a menores previstas na lei.","de":"PULSE richtet sich an Personen, die die in den Nutzungsbedingungen und geltendem Recht festgelegten Mindestalter erfüllen. Wir verarbeiten wissentlich keine personenbezogenen Daten von Kindern, wenn dies verboten ist oder die erforderliche Einwilligung fehlt. Zusätzliche gesetzliche Schutzmaßnahmen für Minderjährige gelten entsprechend.","zh":"PULSE 面向符合服务条款和适用法律最低年龄要求的人士。在法律禁止或未取得所需同意的情况下，我们不会明知而处理儿童的个人信息。适用法律为未成年人提供的额外保护同样适用。","ja":"PULSE は利用規約および適用法の最低年齢要件を満たす人を対象としています。法律で禁止されている場合や必要な同意が得られていない場合、子どもの個人情報を故意に処理しません。適用法が未成年者に追加の保護を定めている場合、その保護が適用されます。","ko":"PULSE는 서비스 약관과 관련 법률의 최소 연령 요건을 충족하는 사람을 대상으로 합니다. 법률상 금지되거나 필요한 동의를 받지 않은 경우 아동의 개인정보를 고의로 처리하지 않습니다. 관련 법률이 미성년자에게 추가 보호를 제공하면 해당 보호가 적용됩니다.","ar":"تستهدف PULSE الأشخاص الذين يستوفون الحد الأدنى للعمر في شروط الخدمة والقانون المعمول به. لا نعالج عن علم المعلومات الشخصية للأطفال في الحالات التي يُحظر فيها ذلك أو لم تُحصل فيها الموافقة المطلوبة. وتسري أي حماية إضافية للقاصرين ينص عليها القانون.","hi":"PULSE उन लोगों के लिए है जो सेवा की शर्तों और लागू कानून में निर्धारित न्यूनतम आयु पूरी करते हैं। जहाँ ऐसा करना प्रतिबंधित है या आवश्यक सहमति नहीं मिली है, वहाँ हम जानबूझकर बच्चों की व्यक्तिगत जानकारी संसाधित नहीं करते। लागू कानून द्वारा नाबालिगों को दी गई अतिरिक्त सुरक्षा लागू होगी।"],
 "Information may be processed or stored in countries other than where you live. Where required by law, appropriate safeguards will be used for international transfers.":["es":"La información puede tratarse o almacenarse en países distintos de aquel donde resides. Cuando la ley lo exija, se aplicarán garantías adecuadas para las transferencias internacionales.","fr":"Les informations peuvent être traitées ou stockées dans des pays autres que votre pays de résidence. Lorsque la loi l’exige, des garanties appropriées seront utilisées pour les transferts internationaux.","pt":"As informações podem ser processadas ou armazenadas em países diferentes daquele em que você mora. Quando exigido por lei, serão usadas salvaguardas apropriadas para transferências internacionais.","de":"Daten können in anderen Ländern als deinem Wohnsitzland verarbeitet oder gespeichert werden. Soweit gesetzlich erforderlich, werden für internationale Übermittlungen geeignete Schutzmaßnahmen eingesetzt.","zh":"信息可能会在你居住国以外的国家处理或存储。法律要求时，国际传输将采用适当的保障措施。","ja":"情報は居住国以外の国で処理または保存される場合があります。法律で求められる場合、国際移転には適切な保護措置を講じます。","ko":"정보는 거주 국가가 아닌 다른 국가에서 처리되거나 저장될 수 있습니다. 법률상 필요한 경우 국제 이전에 적절한 보호 조치를 적용합니다.","ar":"قد تُعالج المعلومات أو تُخزّن في بلدان غير بلد إقامتك. وعندما يقتضي القانون ذلك، تُستخدم ضمانات مناسبة لعمليات النقل الدولية.","hi":"जानकारी आपके निवास स्थान के अलावा अन्य देशों में संसाधित या संग्रहीत हो सकती है। कानून द्वारा आवश्यक होने पर अंतरराष्ट्रीय हस्तांतरण के लिए उचित सुरक्षा उपाय अपनाए जाएँगे।"],
 "PULSE may link to or integrate with third-party services. Those services have their own privacy practices and policies, which we encourage you to review before sharing information with them.":["es":"PULSE puede enlazar con servicios de terceros o integrarse con ellos. Esos servicios tienen sus propias prácticas y políticas de privacidad, que te recomendamos revisar antes de compartir información con ellos.","fr":"PULSE peut proposer des liens vers des services tiers ou s’y intégrer. Ces services disposent de leurs propres pratiques et politiques de confidentialité, que nous vous encourageons à consulter avant de leur communiquer des informations.","pt":"O PULSE pode conter links ou integrações com serviços de terceiros. Esses serviços têm suas próprias práticas e políticas de privacidade, que recomendamos consultar antes de compartilhar informações com eles.","de":"PULSE kann auf Dienste Dritter verlinken oder mit ihnen integriert sein. Diese Dienste haben eigene Datenschutzpraktiken und -richtlinien, die du vor der Weitergabe von Informationen prüfen solltest.","zh":"PULSE 可能链接到第三方服务或与其集成。这些服务有自己的隐私做法和政策，建议你在向其分享信息前先行查阅。","ja":"PULSE は第三者サービスへのリンクを提供したり、第三者サービスと連携したりする場合があります。情報を共有する前に、それらのサービス独自のプライバシー慣行とポリシーを確認することをお勧めします。","ko":"PULSE는 제3자 서비스로 연결되거나 해당 서비스와 통합될 수 있습니다. 해당 서비스는 자체 개인정보 보호 관행과 정책을 가지고 있으므로 정보를 공유하기 전에 확인하는 것이 좋습니다.","ar":"قد تحتوي PULSE على روابط لخدمات تابعة لجهات خارجية أو تتكامل معها. لهذه الخدمات ممارسات وسياسات خصوصية خاصة بها، ونشجعك على مراجعتها قبل مشاركة المعلومات معها.","hi":"PULSE तृतीय-पक्ष सेवाओं से लिंक कर सकता है या उनके साथ एकीकृत हो सकता है। उन सेवाओं की अपनी गोपनीयता प्रथाएँ और नीतियाँ हैं; उनसे जानकारी साझा करने से पहले उन्हें पढ़ने की सलाह दी जाती है।"],
 "We may update this Policy as our service or legal obligations change. We will update the effective date and provide additional notice or obtain consent where required by law.":["es":"Podemos actualizar esta Política cuando cambien el servicio o nuestras obligaciones legales. Actualizaremos la fecha de entrada en vigor y daremos aviso adicional u obtendremos consentimiento cuando la ley lo exija.","fr":"Nous pouvons mettre à jour cette Politique lorsque notre service ou nos obligations légales évoluent. Nous modifierons la date d’entrée en vigueur et fournirons un avis supplémentaire ou recueillerons le consentement lorsque la loi l’exige.","pt":"Podemos atualizar esta Política conforme o serviço ou nossas obrigações legais mudarem. Atualizaremos a data de vigência e forneceremos aviso adicional ou obteremos consentimento quando exigido por lei.","de":"Wir können diese Erklärung aktualisieren, wenn sich unser Dienst oder unsere rechtlichen Pflichten ändern. Wir passen das Gültigkeitsdatum an und informieren zusätzlich oder holen eine Einwilligung ein, soweit gesetzlich erforderlich.","zh":"随着服务或法律义务变化，我们可能更新本政策。我们会更新生效日期，并在法律要求时提供额外通知或取得同意。","ja":"サービスや法的義務の変更に応じて本ポリシーを更新する場合があります。発効日を更新し、法律で求められる場合は追加の通知または同意取得を行います。","ko":"서비스나 법적 의무가 변경되면 본 방침을 업데이트할 수 있습니다. 시행일을 갱신하고 법률상 필요한 경우 추가 통지를 하거나 동의를 받겠습니다.","ar":"قد نحدّث هذه السياسة عند تغير الخدمة أو التزاماتنا القانونية. وسنحدّث تاريخ السريان ونقدم إشعارًا إضافيًا أو نحصل على الموافقة عندما يقتضي القانون ذلك.","hi":"सेवा या कानूनी दायित्वों में बदलाव के अनुसार हम इस नीति को अपडेट कर सकते हैं। हम प्रभावी तिथि बदलेंगे और कानून द्वारा आवश्यक होने पर अतिरिक्त सूचना देंगे या सहमति प्राप्त करेंगे।"],
 "For privacy questions or requests, use the official PULSE privacy contact published by the service.":["es":"Para consultas o solicitudes sobre privacidad, utiliza el contacto oficial de privacidad de PULSE publicado por el servicio.","fr":"Pour toute question ou demande relative à la confidentialité, utilisez le contact officiel de PULSE dédié à la confidentialité et publié par le service.","pt":"Para dúvidas ou solicitações de privacidade, use o contato oficial de privacidade do PULSE divulgado pelo serviço.","de":"Bei Datenschutzfragen oder -anfragen nutze den vom Dienst veröffentlichten offiziellen Datenschutzkontakt von PULSE.","zh":"如有隐私问题或请求，请使用 PULSE 公布的官方隐私联系方式。","ja":"プライバシーに関する質問や依頼は、サービスが公開している PULSE の公式プライバシー連絡先をご利用ください。","ko":"개인정보 관련 질문이나 요청은 서비스에 게시된 PULSE 공식 개인정보 문의처를 이용하세요.","ar":"للاستفسارات أو الطلبات المتعلقة بالخصوصية، استخدم جهة الاتصال الرسمية للخصوصية التي تنشرها PULSE.","hi":"गोपनीयता संबंधी प्रश्नों या अनुरोधों के लिए सेवा द्वारा प्रकाशित PULSE के आधिकारिक गोपनीयता संपर्क का उपयोग करें।"]
 ];
 static func t(_ key:String)->String { legalMap[key]?[lang] ?? map[key]?[lang] ?? key }
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
                        validationHint(L("Use 3–20 letters, numbers, or underscores."))
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

                    inputField(L("Email address"), placeholder: L("you@example.com"), text: $email, symbol: "envelope")
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
                                    TextField(L("At least 8 characters"), text: $password)
                                } else {
                                    SecureField(L("At least 8 characters"), text: $password)
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
                            .accessibilityLabel(L(showPassword ? "Hide password" : "Show password"))
                        }
                        .inputSurface()
                        if !password.isEmpty && password.count < 8 {
                            validationHint(L("Use at least 8 characters."))
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(L("Confirm password"))
                            .font(.custom("PlusJakartaSans-Medium", size: 15))
                        HStack(spacing: 12) {
                            Image(systemName: "lock.shield")
                                .foregroundStyle(.secondary)
                                .frame(width: 20)
                            SecureField(L("Enter your password again"), text: $confirmPassword)
                                .textContentType(.newPassword)
                        }
                        .inputSurface()
                        if !confirmPassword.isEmpty && !passwordsMatch {
                            validationHint(L("Passwords don't match."), color: .red)
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

                separatorLabel(L("OR"))
                    .modifier(PULSEEntrance(delay: 0.24))

                passkeyButton(title: L("Create account with a passkey"), symbol: "person.badge.key.fill")

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
            Text(L(heading))
                .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)

            Text(L(body))
                .termsParagraph()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var termsSheet: some View {
        legalDocumentSheet(title: L("Terms of Service"), subtitle: L("Effective October 9, 2026")) {
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
        legalDocumentSheet(title: L("Privacy Policy"), subtitle: L("Effective October 9, 2026")) {
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
                    inputField(L("Email address"), placeholder: L("you@example.com"), text: $signInEmail, symbol: "envelope")
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
                    Text(L("Sign in"))
                        .font(.custom("PlusJakartaSans-SemiBold", size: 17))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                }
                .buttonStyle(PULSEPrimaryButtonStyle())
                .disabled(!isValidEmail(signInEmail) || signInPassword.isEmpty)
                .modifier(PULSEEntrance(delay: 0.18))

                separatorLabel(L("OR"))
                    .modifier(PULSEEntrance(delay: 0.24))

                passkeyButton(title: L("Continue with a passkey"), symbol: "person.badge.key.fill")

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
        usernameAvailabilityMessage = L("Format looks good. Unique availability must be confirmed by the account service.")
        usernameAvailabilityIsError = true
    }

    private func showBackendNotice(_ feature: String) {
        message = "\(L(feature))\(L(" is designed in the interface, but it won\'t work until PULSE is connected to an authentication backend. Passkeys also need server-generated challenges and a registered relying-party domain."))"
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
