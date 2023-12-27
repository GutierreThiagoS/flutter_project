import 'package:flutter/material.dart';
import 'package:flutter_project/components/custom_progress.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        ref.read(injectLoginController).isLogin(),
      ]).then((value) => value[0] ?  Navigator.of(context).pushReplacementNamed("/home") :  Navigator.of(context).pushReplacementNamed("/login"));
    });

    return Container(
      color: Colors.white,
      child: const CustomProgress(),
    );
  }
}
