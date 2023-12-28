import 'package:flutter/material.dart';
import 'package:flutter_project/components/login/custom_button_login_component.dart';
import 'package:flutter_project/components/login/custom_button_register_component.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/widgets/custom_text_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(18),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/user_icon.png', height: 120,),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFieldWidget(
                      onChange:  ref.read(injectLoginController).setLogin,
                      label: "Login",
                    prefixIcon: Icons.supervised_user_circle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldWidget(
                    onChange: ref.read(injectLoginController).setPass,
                    label: "Senha",
                    obscureText: true,
                    prefixIcon: Icons.key_outlined,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const CustomButtonLoginComponent(),
                  const SizedBox(
                    height: 30,
                  ),
                  const CustomButtonRegisterComponent(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          "Versão 0.0.1",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}