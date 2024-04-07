import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  const PasswordFormField({
    super.key,
    this.initialValue,
    this.controller,
    required this.onSaved,
    required this.validator,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      initialValue: widget.initialValue,
      controller: widget.controller,
      obscureText: isObscure,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
          hintText: widget.hintText,
          suffix: InkWell(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.visibility)))),
    );
  }
}
