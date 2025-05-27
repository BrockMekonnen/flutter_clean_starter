// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _zh = {
  "loginPage": {
    "signIn": "符号",
    "password": "密码",
    "dontHaveAccount": "没有账户？",
    "signUp": "报名",
    "emailAddress": "电子邮件",
    "passwordMinLengthErrorMessage": "密码长度必须至少为 8 位",
    "passwordSpecialCharacterErrorMessage": "密码必须至少包含一个特殊字符"
  },
  "registerPage": {
    "signUp": "报名",
    "firstName": "名字",
    "lastName": "姓",
    "phoneNumber": "电话号码",
    "emailAddress": "电子邮件",
    "password": "密码",
    "confirm": "确认",
    "showPassword": "显示密码",
    "iAgreeToTermCondition": "我同意条款和条件",
    "alreadyHaveAccount": "已有账户？",
    "signIn": "登入",
    "passwordDoNotMatch": "密码不匹配",
    "validPhoneNumberErrorMessage": "请输入有效的电话号码",
    "phoneNumberHint": "输入您的电话号码（例如，+1 123-456-7890）"
  },
  "homePage": {
    "title": "首页",
    "hello": "你好"
  },
  "settingsPage": {
    "title": "设置",
    "darkMode": "深色模式",
    "lightMode": "灯光模式",
    "language": "语言"
  },
  "layoutPage": {
    "home": "首页",
    "profile": "轮廓",
    "settings": "设置",
    "logout": "登出",
    "changeLanguage": "更改语言",
    "changeTheme": "更改主题"
  },
  "profilePage": {
    "title": "轮廓"
  },
  "landingPage": {
    "welcomeTo": "欢迎来到",
    "cleanStarter": "清爽起步",
    "paragraph1": "本 Flutter 模板项目基于清晰架构和模块化架构原则构建，提供了一个坚实且可扩展的基础，帮助你快速启动结构清晰、易于维护、具备扩展性的 Flutter 应用程序。",
    "paragraph2": "这个项目非常适合希望通过可扩展且清晰架构快速启动 Flutter 应用的开发者。它易于扩展、维护，并可轻松适配为生产就绪的应用程序。祝你构建愉快！🚀",
    "featuresTitle": "📦 包含的功能",
    "structureTitle": "📁 项目结构",
    "structureLine1": "- _core: 核心功能、库和配置\n- _shared: 共享页面、小部件和工具\n- modules: 基于功能的结构\n  • auth:\n    ├── data（数据层）\n    ├── domain（领域层）\n    └── features（界面层）\n  • user: 用户功能的占位符\n  • todo: 预留给未来开发",
    "structureDetails": "- _core: 核心功能、库和配置\n- _shared: 共享页面、小部件和工具\n- modules: 基于功能的结构\n  • auth:\n    ├── data（数据层）\n    ├── domain（领域层）\n    └── features（界面层）\n  • user: 用户功能的占位符\n  • todo: 预留给未来开发",
    "gettingStartedTitle": "🚀 入门",
    "gettingStartedDetails": "1. 从 GitHub 克隆仓库  \n2. 运行 `flutter pub get`  \n3. 使用 `flutter run` 启动项目  \n4. 开始构建你的功能！",
    "techStackTitle": "🛠️ 技术栈",
    "techStackDetails": "🧭 GoRouter 用于现代路由  \n📦 BLoC 用于状态管理  \n📁 Hive 用于本地缓存和存储  \n🌐 Dio 用于网络请求  \n🧩 GetIt 用于依赖注入  ",
    "featuresDetails": "✅ 登录和注册流程  \n✅ 主页、个人资料和设置页面  \n✅ 支持深色和浅色主题  \n✅ 本地化：英语、西班牙语、中文、阿拉伯语  \n✅ 响应式设计，适配网页和移动设备  ",
    "viewOnGithub": "在 GitHub 上查看",
    "paragraph3": "我们欢迎各种形式的贡献！\n请 Fork 仓库，进行修改，然后提交 Pull Request。",
    "contributionsWelcome": "🤝 欢迎贡献"
  },
  "postPage": {
    "title1": "帖子",
    "title2": "我的帖子",
    "edit": "编辑",
    "delete": "删除",
    "publish": "发布",
    "postDetails": "帖子详情",
    "editPost": "编辑帖子",
    "createPost": "创建帖子"
  }
};
static const Map<String,dynamic> _en = {
  "loginPage": {
    "signIn": "Sign In",
    "password": "Password",
    "dontHaveAccount": "Don't Have Account?",
    "signUp": "Sign Up",
    "emailAddress": "Email Address",
    "passwordMinLengthErrorMessage": "Password must be at least 8 digits long",
    "passwordSpecialCharacterErrorMessage": "Passwords must have at least one special character"
  },
  "registerPage": {
    "signUp": "Sign Up",
    "firstName": "First Name",
    "lastName": "Last Name",
    "phoneNumber": "Phone Number",
    "emailAddress": "Email Address",
    "password": "Password",
    "confirm": "Confirm",
    "showPassword": "Show Password",
    "iAgreeToTermCondition": "I Agree to Term and Condition",
    "alreadyHaveAccount": "Already Have Account?",
    "signIn": "Sign In",
    "passwordDoNotMatch": "Password do not match",
    "validPhoneNumberErrorMessage": "Please enter a valid phone number",
    "phoneNumberHint": "Enter your phone number (e.g., +1 123-456-7890)"
  },
  "homePage": {
    "title": "Home",
    "hello": "Hello"
  },
  "settingsPage": {
    "title": "Settings",
    "darkMode": "Dark Mode",
    "lightMode": "Light Mode",
    "language": "Language"
  },
  "layoutPage": {
    "home": "Home",
    "profile": "Profile",
    "settings": "Settings",
    "logout": "Logout",
    "changeLanguage": "Change Language",
    "changeTheme": "Change Theme"
  },
  "profilePage": {
    "title": "Profile"
  },
  "landingPage": {
    "welcomeTo": "Welcome to",
    "cleanStarter": "Clean Starter",
    "paragraph1": "This Flutter template project is built upon the principles of Clean Architecture and Modular Architecture. It provides a solid, scalable foundation designed to help you kickstart Flutter applications that are well-structured, easy to maintain, and ready for growth.",
    "paragraph2": "This project is ideal for developers who want to jump-start their Flutter apps with a scalable and clean architecture. It’s easy to extend, maintain, and adapt to production-ready applications. Enjoy building! 🚀",
    "featuresTitle": "📦 Included Features",
    "structureTitle": "📁 Project Structure",
    "structureLine1": "- _core: Core functions, libraries, and configurations\n- _shared: Shared pages, widgets, and utilities\n- modules: Feature-based structure\n  • auth:\n    ├── data (Data layer)\n    ├── domain (Domain layer)\n    └── features (UI layer)\n  • user: Placeholder for user features\n  • todo: Reserved for future development",
    "structureDetails": "- _core: Core functions, libraries, and configurations\n- _shared: Shared pages, widgets, and utilities\n- modules: Feature-based structure\n  • auth:\n    ├── data (Data layer)\n    ├── domain (Domain layer)\n    └── features (UI layer)\n  • user: Placeholder for user features\n  • todo: Reserved for future development",
    "gettingStartedTitle": "🚀 Getting Started",
    "gettingStartedDetails": "1. Clone the repo from GitHub\n2. Run `flutter pub get`\n3. Launch using `flutter run`\n4. Start building your features!",
    "techStackTitle": "🛠️ Tech Stack",
    "techStackDetails": "🧭 GoRouter for modern routing\n📦 BLoC for state management\n📁 Hive for local caching and storage\n🌐 Dio for networking\n🧩 GetIt for dependency injection",
    "featuresDetails": "✅ Sign In and Sign Up Flows\n✅ Home, Profile, and Settings Pages\n✅ Dark and Light Theme Support\n✅ Localization: English, Spanish, Chinese, Arabic\n✅ Responsive Design for Web and Mobile",
    "viewOnGithub": "View on GitHub",
    "paragraph3": "We welcome contributions of all kinds!\nFork the repo, make changes, and submit a pull request.",
    "contributionsWelcome": "🤝 Contributions Welcome"
  },
  "postPage": {
    "title1": "Posts",
    "title2": "My Posts",
    "edit": "Edit",
    "delete": "Delete",
    "publish": "Publish",
    "postDetails": "Post Details",
    "editPost": "Edit Post",
    "createPost": "Create Post"
  }
};
static const Map<String,dynamic> _es = {
  "loginPage": {
    "signIn": "Iniciar sesión",
    "password": "Contraseña",
    "dontHaveAccount": "¿No tienes cuenta?",
    "signUp": "Inscribirse",
    "emailAddress": "Dirección de correo electrónico",
    "passwordMinLengthErrorMessage": "La contraseña debe tener al menos 8 dígitos",
    "passwordSpecialCharacterErrorMessage": "Las contraseñas deben tener al menos un carácter especial"
  },
  "registerPage": {
    "signUp": "Inscribirse",
    "firstName": "Nombre de pila",
    "lastName": "Apellido",
    "phoneNumber": "Número de teléfono",
    "emailAddress": "Dirección de correo electrónico",
    "password": "Contraseña",
    "confirm": "Confirmar",
    "showPassword": "Mostrar contraseña",
    "iAgreeToTermCondition": "Acepto los términos y condiciones",
    "alreadyHaveAccount": "¿Ya tienes cuenta?",
    "signIn": "Iniciar sesión",
    "passwordDoNotMatch": "La contraseña no coincide",
    "validPhoneNumberErrorMessage": "Por favor, introduzca un número de teléfono válido",
    "phoneNumberHint": "Ingrese su número de teléfono (por ejemplo, +1 123-456-7890)"
  },
  "homePage": {
    "title": "Inicio",
    "hello": "Hola"
  },
  "settingsPage": {
    "title": "Ajustes",
    "darkMode": "Modo oscuro",
    "lightMode": "Modo de luz",
    "language": "Idioma"
  },
  "layoutPage": {
    "home": "Inicio",
    "profile": "Perfil",
    "settings": "Ajustes",
    "logout": "Cerrar sesión",
    "changeLanguage": "Cambiar idioma",
    "changeTheme": "Cambiar tema"
  },
  "profilePage": {
    "title": "Perfil"
  },
  "landingPage": {
    "welcomeTo": "Bienvenido a",
    "cleanStarter": "Inicio Limpio",
    "paragraph1": "Este proyecto de plantilla de Flutter está basado en los principios de Arquitectura Limpia y Arquitectura Modular. Proporciona una base sólida y escalable diseñada para ayudarte a iniciar aplicaciones Flutter bien estructuradas, fáciles de mantener y preparadas para crecer.",
    "paragraph2": "Este proyecto es ideal para desarrolladores que desean iniciar rápidamente sus aplicaciones Flutter con una arquitectura limpia y escalable. Es fácil de extender, mantener y adaptar para aplicaciones listas para producción. ¡Disfruta programando! 🚀",
    "featuresTitle": "📦 Funciones incluidas",
    "structureTitle": "📁 Estructura del proyecto",
    "structureLine1": "- _core: Funciones principales, bibliotecas y configuraciones\n- _shared: Páginas, widgets y utilidades compartidas\n- modules: Estructura basada en características\n  • auth:\n    ├── data (Capa de datos)\n    ├── domain (Capa de dominio)\n    └── features (Capa de interfaz)\n  • user: Marcador de posición para funciones de usuario\n  • todo: Reservado para desarrollo futuro",
    "structureDetails": "- _core: Funciones principales, bibliotecas y configuraciones\n- _shared: Páginas, widgets y utilidades compartidas\n- modules: Estructura basada en características\n  • auth:\n    ├── data (Capa de datos)\n    ├── domain (Capa de dominio)\n    └── features (Capa de interfaz)\n  • user: Marcador de posición para funciones de usuario\n  • todo: Reservado para desarrollo futuro",
    "gettingStartedTitle": "🚀 Comenzando",
    "gettingStartedDetails": "1. Clona el repositorio desde GitHub  \n2. Ejecuta `flutter pub get`  \n3. Inicia la aplicación con `flutter run`  \n4. ¡Empieza a construir tus funcionalidades!",
    "techStackTitle": "🛠️ Conjunto de tecnologías",
    "techStackDetails": "🧭 GoRouter para enrutamiento moderno  \n📦 BLoC para gestión de estado  \n📁 Hive para almacenamiento en caché y local  \n🌐 Dio para conexión de red  \n🧩 GetIt para inyección de dependencias  ",
    "featuresDetails": "✅ Flujos de inicio de sesión y registro  \n✅ Páginas de Inicio, Perfil y Configuración  \n✅ Soporte para temas claro y oscuro  \n✅ Localización: inglés, español, chino, árabe  \n✅ Diseño responsivo para web y dispositivos móviles  ",
    "viewOnGithub": "Ver en GitHub",
    "paragraph3": "¡Damos la bienvenida a todo tipo de contribuciones!\nHaz un fork del repositorio, realiza cambios y envía un pull request.",
    "contributionsWelcome": "🤝 Bienvenidas las contribuciones"
  },
  "postPage": {
    "title1": "Publicaciones",
    "title2": "Mis publicaciones",
    "edit": "Editar",
    "delete": "Eliminar",
    "publish": "Publicar",
    "postDetails": "Detalles de la publicación",
    "editPost": "Editar publicación",
    "createPost": "Crear publicación"
  }
};
static const Map<String,dynamic> _ar = {
  "loginPage": {
    "dontHaveAccount": "ليس لديك حساب؟",
    "emailAddress": "عنوان البريد الإلكتروني",
    "password": "كلمة المرور",
    "signIn": "تسجيل الدخول",
    "signUp": "اشتراك",
    "passwordMinLengthErrorMessage": "يجب أن تتكون كلمة المرور من 8 أرقام على الأقل",
    "passwordSpecialCharacterErrorMessage": "يجب أن تحتوي كلمات المرور على حرف خاص واحد على الأقل"
  },
  "registerPage": {
    "emailAddress": "عنوان البريد الإلكتروني",
    "firstName": "الاسم الأول",
    "lastName": "اسم العائلة",
    "phoneNumber": "رقم التليفون",
    "signUp": "اشتراك",
    "password": "كلمة المرور",
    "confirm": "يتأكد",
    "showPassword": "إظهار كلمة المرور",
    "iAgreeToTermCondition": "أوافق على الشروط والأحكام",
    "alreadyHaveAccount": "هل لديك حساب بالفعل؟",
    "signIn": "تسجيل الدخول",
    "passwordDoNotMatch": "كلمة المرور غير متطابقة",
    "validPhoneNumberErrorMessage": "الرجاء إدخال رقم هاتف صالح",
    "phoneNumberHint": "أدخل رقم هاتفك (على سبيل المثال، +1 123-456-7890)"
  },
  "homePage": {
    "title": "الرئيسية",
    "hello": "مرحبًا"
  },
  "settingsPage": {
    "title": "إعدادات",
    "darkMode": "الوضع المظلم",
    "lightMode": "وضع الضوء",
    "language": "لغة"
  },
  "layoutPage": {
    "home": "الرئيسية",
    "profile": "حساب تعريفي",
    "settings": "إعدادات",
    "logout": "تسجيل الخروج",
    "changeLanguage": "تغيير اللغة",
    "changeTheme": "تغيير النمط"
  },
  "profilePage": {
    "title": "حساب تعريفي"
  },
  "landingPage": {
    "welcomeTo": "مرحبًا بك في",
    "cleanStarter": "البداية النظيفة",
    "paragraph1": "تم بناء هذا المشروع النموذجي لـ Flutter استنادًا إلى مبادئ الهندسة النظيفة والهندسة المعمارية المعيارية. يوفر أساسًا قويًا وقابلًا للتوسع لمساعدتك في بدء تطوير تطبيقات Flutter منظمة وسهلة الصيانة وجاهزة للنمو.",
    "paragraph2": "هذا المشروع مثالي للمطورين الذين يرغبون في بدء تطبيقات Flutter الخاصة بهم باستخدام بنية نظيفة وقابلة للتوسع. من السهل توسيعه وصيانته وتكييفه ليكون جاهزًا للإنتاج. استمتع بالبناء! 🚀",
    "featuresTitle": "📦 الميزات المضمنة",
    "structureTitle": "📁 هيكل المشروع",
    "structureLine1": "- _core: الوظائف الأساسية، المكتبات، والتكوينات\n- _shared: الصفحات، الواجهات، والأدوات المشتركة\n- modules: هيكل قائم على الميزات\n  • auth:\n    ├── data (طبقة البيانات)\n    ├── domain (طبقة المجال)\n    └── features (طبقة الواجهة)\n  • user: مخصص لميزات المستخدم\n  • todo: محجوز للتطوير المستقبلي",
    "structureDetails": "- _core: الوظائف الأساسية، المكتبات، والتكوينات\n- _shared: الصفحات، الواجهات، والأدوات المشتركة\n- modules: هيكل قائم على الميزات\n  • auth:\n    ├── data (طبقة البيانات)\n    ├── domain (طبقة المجال)\n    └── features (طبقة الواجهة)\n  • user: مخصص لميزات المستخدم\n  • todo: محجوز للتطوير المستقبلي",
    "gettingStartedTitle": "🚀 البدء",
    "gettingStartedDetails": "1. استنِسخ المستودع من GitHub  \n2. شغّل الأمر `flutter pub get`  \n3. ابدأ التشغيل باستخدام `flutter run`  \n4. ابدأ ببناء ميزاتك الخاصة!",
    "techStackTitle": "🛠️ مجموعة التقنيات",
    "techStackDetails": "🧭 GoRouter لتوجيه حديث  \n📦 BLoC لإدارة الحالة  \n📁 Hive للتخزين المؤقت المحلي والتخزين  \n🌐 Dio للشبكات  \n🧩 GetIt للحقن التبعي  ",
    "featuresDetails": "✅ تدفقات تسجيل الدخول والتسجيل  \n✅ صفحات الصفحة الرئيسية، الملف الشخصي، والإعدادات  \n✅ دعم الوضع الداكن والفاتح  \n✅ دعم اللغات: الإنجليزية، الإسبانية، الصينية، العربية  \n✅ تصميم متجاوب للويب والجوال  ",
    "viewOnGithub": "عرض على GitHub",
    "paragraph3": "نرحب بجميع أنواع المساهمات!\nقم بعمل تفرع للمستودع، وأجرِ التعديلات، وقدم طلب سحب.",
    "contributionsWelcome": "🤝 نرحب بالمساهمات"
  },
  "postPage": {
    "title1": "المنشورات",
    "title2": "منشوراتي",
    "edit": "تعديل",
    "delete": "حذفEliminar",
    "publish": "نشر",
    "postDetails": "تفاصيل المنشور",
    "editPost": "تعديل المنشور",
    "createPost": "إنشاء منشور"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"zh": _zh, "en": _en, "es": _es, "ar": _ar};
}
