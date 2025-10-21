import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neura/core/themes/theme.dart';
import 'package:neura/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:neura/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:neura/feature/auth/domain/usecases/login_use_case.dart';
import 'package:neura/feature/auth/domain/usecases/register_use_case.dart';
import 'package:neura/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:neura/feature/auth/presentation/ui/login_screen.dart';
import 'package:neura/feature/auth/presentation/ui/register_screen.dart';
import 'package:neura/feature/message/presentation/ui/chat_screen.dart';
import 'package:neura/feature/message/presentation/ui/message_screen.dart';

void main() {
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: AuthRemoteDataSource(),
  );

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;

  const MyApp({super.key, required this.authRepository});

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Neura App',
        theme: AppTheme.darkTheme,
        home: const RegisterScreen(),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/chat': (_) => const ChatScreen(),
          '/home': (_) => const MessageScreen(),
        },
      ),
    );
  }
}
