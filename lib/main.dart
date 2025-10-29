// main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neura/core/helpers/app_pages.dart';
import 'package:neura/core/services/fcm_service.dart';
import 'package:neura/core/themes/theme.dart';

// Import các lớp Repository trừu tượng (Best Practice)
import 'package:neura/feature/auth/domain/repositories/auth_repository.dart';
import 'package:neura/feature/conversation/domain/repositories/conversation_repository.dart';
import 'package:neura/feature/chat/domain/repositories/message_repository.dart';
import 'package:neura/feature/contacts/domain/repositories/contact_repository.dart';

// Import các lớp Repository triển khai
import 'package:neura/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:neura/feature/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:neura/feature/chat/data/repositories/message_repository_impl.dart';
import 'package:neura/feature/contacts/data/repositories/contact_repository_impl.dart';

// Import các DataSources
import 'package:neura/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:neura/feature/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:neura/feature/chat/data/datasources/message_remote_data_source.dart';
import 'package:neura/feature/contacts/data/datasources/contact_remote_data_source.dart';

// Import các UseCases
import 'package:neura/feature/auth/domain/usecases/login_use_case.dart';
import 'package:neura/feature/auth/domain/usecases/register_use_case.dart';
import 'package:neura/feature/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:neura/feature/chat/domain/usecases/fetch_message_use_case.dart';
import 'package:neura/feature/contacts/domain/usecases/fetch_contact_use_case.dart';
import 'package:neura/feature/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:neura/feature/conversation/domain/usecases/check_or_create_conversation_use_case.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) =>
              AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource()),
        ),
        RepositoryProvider<ConversationRepository>(
          create: (_) => ConversationRepositoryImpl(
            converSationRemoteDataDource: ConversationRemoteDataSource(),
          ),
        ),
        RepositoryProvider<MessageRepository>(
          create: (_) => MessageRepositoryImpl(
            messageRemoteDataSource: MessageRemoteDataSource(),
          ),
        ),
        RepositoryProvider<ContactRepository>(
          create: (_) => ContactRepositoryImpl(
            contactRemoteDataSource: ContactRemoteDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Các BLoC sẽ sử dụng context.read<T>() để lấy repository tương ứng
          BlocProvider(
            create: (context) => AuthBloc(
              RegisterUseCase(repository: context.read<AuthRepository>()),
              LoginUseCase(repository: context.read<AuthRepository>()),
            ),
          ),
          BlocProvider(
            create: (context) => ConversationBloc(
              fetchConversationsUseCase: FetchConversationsUseCase(
                repository: context.read<ConversationRepository>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ChatBloc(
              fetchMessageUseCase: FetchMessageUseCase(
                repository: context.read<MessageRepository>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ContactBloc(
              fetchContactUseCase: FetchContactUseCase(
                contactRepository: context.read<ContactRepository>(),
              ),
              addContactUseCase: AddContactUseCase(
                contactRepository: context.read<ContactRepository>(),
              ),
              checkOrCreateConversationUseCase:
                  CheckOrCreateConversationUseCase(
                    conversationRepository: context
                        .read<ConversationRepository>(),
                  ),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Neura App',
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: '/login',
          routes: AppPages.pages,
        ),
      ),
    );
  }
}
