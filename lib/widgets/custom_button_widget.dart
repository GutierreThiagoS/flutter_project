import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? titleSize;
  final bool disable;
  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.disable = false,
    this.titleSize
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty
            .resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) return Colors.red;
              if (states.contains(MaterialState.pressed)) return Colors.blue;
              return Colors.green;
            }),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            )
        ),
        textStyle: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return TextStyle(fontSize: titleSize != null ? titleSize! * 2 : 28);
              }
              return TextStyle(fontSize: titleSize);
            })
      ),
      child: Text(title),
    );
  }
}
