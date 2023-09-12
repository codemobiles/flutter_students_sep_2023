import 'package:flutter/material.dart';

class CMTextForm extends StatelessWidget {
  String label;
  String initialValue;
  Function onSave;

  CMTextForm({
    required this.label,
    required this.initialValue,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: _inputStyle(label),
        onSaved: (newValue) => onSave(newValue),
      ),
    );
  }

  InputDecoration _inputStyle(String label) => InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        errorText: false ? 'Value Can\'t Be Empty' : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        labelText: label,
      );
}
