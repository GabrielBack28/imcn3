import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:imcn3/models/imcs.dart';
import 'package:imcn3/widgets/imc_form.dart';

class EditImcScreen extends StatefulWidget {
  const EditImcScreen({super.key });
  
  @override
  State<StatefulWidget> createState() => _EditImcState();
}

class _EditImcState extends State<EditImcScreen> {

  IMC? _imcData;
  String? _id;
  double? _weight;
  double? _height;
  String? _name;
  double? _imc;
  final _formKey = GlobalKey<FormState>();
  CollectionReference imcs = FirebaseFirestore.instance.collection('imcs');

  Future<void> editImc() async {
    if (_formKey.currentState!.validate()) {
      _imc = double.parse((_weight! / (_height! * _height!)).toStringAsFixed(2));

      imcs.doc(_id).update({
        'weight': _weight,
        'height': _height,
        'name': _name,
        'imc': _imc,
      })
      .then((value) => Navigator.pushNamed(context, '/'))
      // ignore: invalid_return_type_for_catch_error
      .catchError((error) => log("Failed to edit imc: $error"));
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
  void didChangeDependencies() {
    super.didChangeDependencies();

    _imcData = ModalRoute.of(context)?.settings.arguments as IMC?;
    _id = _imcData!.id;
  }

  @override
  Widget build(BuildContext context) {
    return ImcForm(
      formKey: _formKey,
      formType: ImcForm.editForm,
      onPressed: editImc,
      onChangedWeight: onChangedWeight,
      onChangedHeight: onChangedHeight,
      onChangedName: onChangedName,
      imc: _imcData,
    );
  }
}
