import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButtonLoginComponent extends ConsumerWidget {

  const CustomButtonLoginComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: ref.read(injectLoginController).inLoading,
        builder: (_, inLoader, __) {
          return inLoader
              ? const CircularProgressIndicator()
              : OutlinedButton(
                  onPressed: () {
                    ref.read(injectLoginController).singIn().then((result) {
                      if (result) {
                        Navigator.of(context).pushReplacementNamed("/home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Falha ao realizar login"),
                                duration: Duration(seconds: 5)
                            )
                        );
                      }
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      SizedBox(
                        width: 10,
                        height: 40,
                      ),
                      Icon(Icons.login)
                    ],
                  ));
        });
  }
}
