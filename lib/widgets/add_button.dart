import 'package:flutter/material.dart';
import 'package:imcn3/widgets/rounded_button.dart';

class AddButton extends StatelessWidget {
  const AddButton({ Key? key, required this.onPressed }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
        title: 'Adicionar Registro', color: Colors.blueAccent, onPressed: onPressed);
  }
}