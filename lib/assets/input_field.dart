import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldArea extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType inputType;
  final String label;
  final String hint;

  const InputFieldArea({Key key, this.controller, this.label, this.hint, this.inputType, this.inputFormatters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}