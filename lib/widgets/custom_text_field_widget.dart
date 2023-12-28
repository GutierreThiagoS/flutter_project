import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final Function(String) onChange;
  final String label;
  final TextEditingController? userNameController;
  final bool obscureText;
  final IconData? prefixIcon;

  const CustomTextFieldWidget(
      {
        super.key,
        required this.onChange,
        required this.label,
        this.obscureText = false,
        this.userNameController,
        this.prefixIcon
      });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {

  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  @override
  void initState() {
    visible.value = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder<bool>(
        valueListenable: visible,
      builder: (_, isVisible, __) {
            return TextField(
        controller: widget.userNameController,
        decoration: InputDecoration(
            label: Text(widget.label),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade900, width: 1.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visible.value = !isVisible;
                      });
                    },
                  )
                : null),
        onChanged: widget.onChange,
        obscureText: isVisible,
      );
    });
  }
}
