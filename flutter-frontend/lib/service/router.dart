import 'package:go_router/go_router.dart';
import 'package:news_pulse/model/group.dart';
import 'package:news_pulse/view/auth/screen/login_screen.dart';
import 'package:news_pulse/view/auth/screen/sign_in_screen.dart';
import 'package:news_pulse/view/chat/screens/chat_screen.dart';
import 'package:news_pulse/view/home/screens/home_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/signin',
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(path: '/login', builder: (context, state) =>  const LoginScreen()),
  GoRoute(
    path: '/chat',
    builder: (context, state) =>  ChatScreen(group: state.extra as Group),
  ),
]);
