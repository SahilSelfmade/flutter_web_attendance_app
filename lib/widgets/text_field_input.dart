import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final bool isPass;
  final bool enabled;
  List<TextInputFormatter> inputFormatters = [];
  final String? hintText;
  final String? labelText;
  final TextInputType? textInputType;
  TextFieldInput({
    Key? key,
    // this.inputFormatters,
    this.textEditingController,
    this.onChanged,
    this.enabled=true,
    this.isPass = false,
    this.hintText,
    this.labelText,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      enabled: enabled,
      
      onChanged: onChanged,
      
      controller: textEditingController,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
