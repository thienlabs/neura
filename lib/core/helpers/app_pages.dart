
import 'package:neura/feature/auth/presentation/ui/login_screen.dart';
import 'package:neura/feature/auth/presentation/ui/register_screen.dart';
import 'package:neura/feature/conversation/presentation/ui/conversation_screen.dart';

class AppPages {
  static final pages = {
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/home': (context) => const ConversationScreen(),
  };
}
