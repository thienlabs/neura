// main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neura/core/di/injection_container.dart';
import 'package:neura/core/helpers/app_pages.dart';
import 'package:neura/core/services/fcm_service.dart';

import 'package:neura/core/themes/theme.dart';

// Import các BLoCs
import 'package:neura/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:neura/feature/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:neura/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:neura/feature/contacts/presentation/bloc/contact_bloc.dart';
import 'package:neura/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase Initialized Successfully!");
  } catch (e) {
    print("❌ Firebase Init Error: $e");
    // Optional: Hiển thị snackbar hoặc crash report, nhưng đừng để app crash
  }
  await initDependencies();
  // Set background handler (phải trước runApp)
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Await FCM init để đảm bảo token ready trước khi app start
  try {
    await FCMService().initNotifications();
    print("✅ FCM Notifications Initialized!");
  } catch (e) {
    print("❌ FCM Init Error: $e");
    // App vẫn chạy, nhưng notifications có thể không hoạt động
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(sl(), sl())),
        BlocProvider(
          create: (_) => ConversationBloc(fetchConversationsUseCase: sl()),
        ),
        BlocProvider(create: (_) => ChatBloc(fetchMessageUseCase: sl())),
        BlocProvider(
          create: (_) => ContactBloc(
            fetchContactUseCase: sl(),
            addContactUseCase: sl(),
            checkOrCreateConversationUseCase: sl(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Neura App',
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: '/splash',
        routes: AppPages.pages,
      ),
    );
  }
}
