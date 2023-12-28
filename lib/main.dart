import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/home_controller.dart';
import 'package:flutter_project/controllers/login_controller.dart';
import 'package:flutter_project/controllers/resgister_controller.dart';
import 'package:flutter_project/data/repository/user_repository_imp.dart';
import 'package:flutter_project/framework/view/home_view.dart';
import 'package:flutter_project/framework/view/login_view.dart';
import 'package:flutter_project/framework/view/note_view.dart';
import 'package:flutter_project/framework/view/splash_view.dart';
import 'package:flutter_project/framework/view/register_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final injectHomeController = ChangeNotifierProvider((ref) => HomeController(UserRepositoryImp()));
final injectLoginController = ChangeNotifierProvider((ref) => LoginController(UserRepositoryImp()));
final injectRegisterController = ChangeNotifierProvider((ref) => RegisterController(UserRepositoryImp()));

Future<void> main() async {

  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      initialRoute: "/",
      routes: {
          '/': (_) => const SplashView(),
          '/login': (_) => const LoginView(),
          '/home': (_) => const HomeView(),
          '/note': (_) => const NoteView(),
          '/register': (_) => RegisterView(),
        });
  }
}