
import 'package:flutter/material.dart';

class ConfirmDialog {
  Future<void> displayConfirmDialog(
      BuildContext context, OnClickConfirmCallBack onClickConfirm) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Atenção'),
            content: const Text("Deseja realmente deslogar?"),
            actions: <Widget>[
              TextButton(
                child: const Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('Sim'),
                  onPressed: () {
                    onClickConfirm();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef OnClickConfirmCallBack = void Function();
