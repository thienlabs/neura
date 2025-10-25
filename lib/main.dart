import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neura/core/services/socket_service.dart';
import 'package:neura/core/themes/theme.dart';
import 'package:neura/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:neura/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:neura/feature/auth/domain/usecases/login_use_case.dart';
import 'package:neura/feature/auth/domain/usecases/register_use_case.dart';
import 'package:neura/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:neura/feature/auth/presentation/ui/login_screen.dart';
import 'package:neura/feature/auth/presentation/ui/register_screen.dart';
import 'package:neura/feature/chat/data/datasources/message_remote_data_source.dart';
import 'package:neura/feature/chat/data/repositories/message_repository_impl.dart';
import 'package:neura/feature/chat/domain/usecases/fetch_message_use_case.dart';
import 'package:neura/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:neura/feature/contacts/data/datasources/contact_remote_data_source.dart';
import 'package:neura/feature/contacts/data/repositories/contact_repository_impl.dart';
import 'package:neura/feature/contacts/domain/usecases/add_contact_use_case.dart';
import 'package:neura/feature/contacts/domain/usecases/fetch_contact_use_case.dart';
import 'package:neura/feature/contacts/presentation/bloc/contact_bloc.dart';
import 'package:neura/feature/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:neura/feature/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:neura/feature/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:neura/feature/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:neura/feature/conversation/presentation/ui/conversation_screen.dart';

void main() {
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: AuthRemoteDataSource(),
  );
  final conversationRepository = ConversationRepositoryImpl(
    converSationRemoteDataDource: ConversationRemoteDataSource(),
  );
  final messageRepository = MessageRepositoryImpl(
    messageRemoteDataSource: MessageRemoteDataSource(),
  );
  final contactRepository = ContactRepositoryImpl(
    contactRemoteDataSource: ContactRemoteDataSource(),
  );

  runApp(
    MyApp(
      authRepository: authRepository,
      conversationRepository: conversationRepository,
      messageRepository: messageRepository, 
      contactRepository: contactRepository,
      
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationRepositoryImpl conversationRepository;
  final MessageRepositoryImpl messageRepository;
  final ContactRepositoryImpl contactRepository;
  const MyApp({
    super.key,
    required this.authRepository,
    required this.conversationRepository,
    required this.messageRepository, 
    required this.contactRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            RegisterUseCase(repository: authRepository),
            LoginUseCase(repository: authRepository),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationBloc(
            fetchConversationsUseCase: FetchConversationsUseCase(
              repository: conversationRepository,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ChatBloc(
            fetchMessageUseCase: FetchMessageUseCase(
              repository: messageRepository,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ContactBloc(
            fetchContactUseCase: FetchContactUseCase(
              contactRepository: contactRepository,
            ),
            addContactUseCase: AddContactUseCase(
              contactRepository: contactRepository,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Neura App',
        theme: AppTheme.darkTheme,
        home: LoginScreen(),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/home': (_) => const ConversationScreen(),
        },
      ),
    );
  }
}
