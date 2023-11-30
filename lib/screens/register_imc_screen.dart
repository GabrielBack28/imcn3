import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:imcn3/widgets/imc_form.dart';

class RegisterImcScreen extends StatefulWidget {
  const RegisterImcScreen({super.key });
  
  @override
  State<StatefulWidget> createState() => _RegisterImcState();
}

class _RegisterImcState extends State<RegisterImcScreen> {

  double? _weight;
  double? _height;
  String? _name;
  double? _imc;
  final _formKey = GlobalKey<FormState>();
  CollectionReference imcs = FirebaseFirestore.instance.collection('imcs');

  Future<void> registerImc() async {
    if (_formKey.currentState!.validate()) {
      _imc = double.parse((_weight! / (_height! * _height!)).toStringAsFixed(2));
      imcs.add({
        'weight': _weight,
        'height': _height,
        'name': _name,
        'imc': _imc,
      })
      .then((value) => Navigator.pushNamed(context, '/'))
      // ignore: invalid_return_type_for_catch_error
      .catchError((error) => log("Failed to add imc: $error"));
    }
  }

  void onChangedWeight(String? value) {
    _weight = double.parse(value!);
  }

  void onChangedHeight(String? value) {
    _height = double.parse(value!);
  }

  void onChangedName(String? value) {
    _name = value;
  }

  @override
  Widget build(BuildContext context) {
    return ImcForm(
      formKey: _formKey,
      formType: ImcForm.registerForm,
      onPressed: registerImc,
      onChangedWeight: onChangedWeight,
      onChangedHeight: onChangedHeight,
      onChangedName: onChangedName,
    );
  }
}

class DatabaseReference {
}

class FirebaseDatabase {
}