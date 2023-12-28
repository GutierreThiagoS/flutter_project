import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButtonRegisterComponent extends ConsumerWidget {

  const CustomButtonRegisterComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/register");
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cadastrar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.person_add_alt_1)
              ],
            )
    );
  }
}
