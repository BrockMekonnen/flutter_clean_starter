// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:go_router/go_router.dart';

// import '../_shared/shared_module.dart';
// import '../firebase_options.dart';
// import '../modules/auth/auth_module.dart';
// import '../modules/bid/bid_module.dart';
// import '../modules/blog/blog_module.dart';
// import '../modules/chat/chat_modules.dart';
// import '../modules/employer/employer_module.dart';
// import '../modules/feedback/feedback_module.dart';
// import '../modules/freelancer/freelancer_module.dart';
// import '../modules/job/job_module.dart';
// import '../modules/notification/notification_module.dart';
// import '../modules/portfolio/portfolio_module.dart';
// import '../modules/review/review_module.dart';
// import '../modules/wallet/wallet_module.dart';
// import 'config.dart';
// import 'container.dart';
// import 'dio.dart';
// import 'hive.dart';
// import 'initial_data_load.dart';
// import 'local_notification.dart';
// import 'router/app_router.dart';
// import 'socket.dart';

// class Bootstrap {
//   static Future<void> init() async {
//     FirebaseApp firebaseApp =
//         await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//     di.registerLazySingleton(() => firebaseApp);
//     di.registerLazySingleton(() => FirebaseMessaging.instance);
//     di.registerLazySingleton(() => FirebaseAuth.instance);
//     di.registerLazySingleton(() => FirebaseAnalytics.instance);

//     //* Initiate Core
//     final List<RouteBase> routes = [];
//     di.registerLazySingleton(() => Config());
//     await DioConfig.init();
//     await HiveConfig.init();
//     await SocketClient.init();
//     LocalNotification.init();
//     await LoadInitialData.init();
    

//     //* Registering Modules
//     await registerAuthModule(di, routes);
//     await registerNotificationModule(di, routes);
//     await registerBidModule(di, routes);
//     await registerEmployerModule(di, routes);
//     await registerFreelancerModule(di, routes);
//     await registerJobModule(di, routes);
//     await registerPortfolioModule(di, routes);
//     await registerReviewModule(di, routes);
//     await registerSharedModule(di, routes);
//     await registerFeedbackModule(di, routes);
//     await registerChatModule(di, routes);
//     await registerWalletModule(di, routes);

//     //* Web Specific
//     await registerBlogModule(di, routes);

//     //* initialize all routes
//     di.registerLazySingleton(
//       () => AppRouter(
//         observer: FirebaseAnalyticsObserver(analytics: di()),
//         authBloc: di(),
//         routes: routes,
//       ),
//     );
//   }
// }
