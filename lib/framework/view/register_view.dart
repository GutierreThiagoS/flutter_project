
import 'package:flutter/material.dart';
import 'package:flutter_project/data/remote/state/state_info.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/widgets/custom_text_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerWidget {
  RegisterView({super.key});
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro")
      ),
      body: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(18),
        alignment: Alignment.center,
        child: Card(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: EdgeInsets.all(22),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Cadastrar Usuário", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFieldWidget(
                    onChange: ref.read(injectRegisterController).setFullName,
                    label: "Nome Completo",
                    prefixIcon: Icons.account_box,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                    onChange: ref.read(injectRegisterController).setEmail,
                    label: "Email",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: ref.read(injectRegisterController).userName,
                    builder: (_, userName, __) {
                      userNameController.text = userName;
                      userNameController.selection = TextSelection.collapsed(offset: userNameController.text.length);
                      return CustomTextFieldWidget(
                        onChange: ref
                            .read(injectRegisterController)
                            .setUserName,
                        label: "Login",
                        prefixIcon: Icons.person_add,
                        userNameController: userNameController,
                      );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                    onChange: ref.read(injectRegisterController).setPassword,
                    label: "Senha",
                    prefixIcon: Icons.password,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder<bool>(
                  valueListenable:  ref.read(injectRegisterController).loading,
                  builder: (_, value, __) {
                    return value
                    ? CircularProgressIndicator()
                    : OutlinedButton(
                        onPressed: () async {
                          StateInfo state = await ref.read(
                              injectRegisterController).registerUser();
                          if (state.status) {
                            Navigator.of(context).pop("/login");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(state.info),
                                    duration: Duration(seconds: 5)));
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enviar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            SizedBox(
                              width: 10,
                              height: 40,
                            ),
                            Icon(Icons.send_outlined)
                          ],
                        )
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
