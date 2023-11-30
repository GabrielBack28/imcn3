import 'package:flutter/material.dart';
import 'package:imcn3/models/imcs.dart';
import 'package:imcn3/widgets/rounded_button.dart';

import 'custom_form_field.dart';

class ImcForm extends StatefulWidget {
  static const editForm = 'edit';
  static const registerForm = 'register';

  const ImcForm({
    super.key,
    required this.formKey,
    required this.formType,
    required this.onPressed,
    required this.onChangedWeight,
    required this.onChangedHeight,
    required this.onChangedName,
    this.imc
  });

  final GlobalKey<FormState> formKey;
  final String formType;
  final VoidCallback onPressed;
  final Function(String?) onChangedWeight;
  final Function(String?) onChangedHeight;
  final Function(String?) onChangedName;
  final IMC? imc;

  @override
  State<StatefulWidget> createState() => ImcFormState();
}

class ImcFormState extends State<ImcForm> {
  
  late GlobalKey<FormState> _formKey;
  late String _formType;
  late VoidCallback _onPressed;
  late Function(String?) _onChangedWeight;
  late Function(String?) _onChangedHeight;
  late Function(String?) _onChangedName;
  IMC? imcInitialValue;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
    _formType = widget.formType;
    _onPressed = widget.onPressed;
    _onChangedWeight = widget.onChangedWeight;
    _onChangedHeight = widget.onChangedHeight;
    _onChangedName = widget.onChangedName;
    
    if (widget.imc != null) {
      imcInitialValue = widget.imc;
      _onChangedHeight(imcInitialValue!.height.toString());
      _onChangedWeight(imcInitialValue!.weight.toString());
      _onChangedName(imcInitialValue!.name);
    }
  }

  String getButtonTitle() {
    if (_formType == ImcForm.editForm) {
      return 'Editar IMC';
    } else {
      return 'Adicionar IMC';
    }
  }

  void backHome() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 48),
            CustomFormField(
              hintText: 'Entre seu nome',
              onChanged: _onChangedName,
              initialValue: imcInitialValue?.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome';
                }
                return null;
              }
            ),
            const SizedBox(height: 8),
            CustomFormField(
              hintText: 'Entre seu peso',
              onChanged: _onChangedWeight,
              initialValue: imcInitialValue?.weight.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu peso';
                }
                return null;
              }
            ),
            const SizedBox(height: 8),
            CustomFormField(
              hintText: 'Entre sua altura',
              onChanged: _onChangedHeight,
              initialValue: imcInitialValue?.height.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua altura';
                }
                return null;
              }
            ),
            RoundedButton(title: getButtonTitle(), color: Colors.green, onPressed: _onPressed),
            RoundedButton(title: 'Voltar', color: Colors.blue, onPressed: backHome)
          ],
        ),
        )
      )
    );
  }
}
