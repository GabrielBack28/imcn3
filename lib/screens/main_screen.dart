import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imcn3/models/imcs.dart';
import 'package:imcn3/widgets/add_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ super.key });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<IMC> imcs = [];
  CollectionReference imcsFirebase = FirebaseFirestore.instance.collection('imcs');

  String getIMCStatus(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do Peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Peso Normal';
    } else if (imc >= 25 && imc < 29.9) {
      return 'Sobrepeso';
    } else {
      return 'Obesidade';
    }
  }

  @override
  void initState() {
    super.initState();
    imcsFirebase.get()
      .then((value) => {
        setState(() {
          imcs = value.docs.map((e) => IMC(
            name: e['name'],
            weight: e['weight'],
            height: e['height'],
            imc: e['imc'],
            id: e.id
          )).toList();
        })
      })
      // ignore: invalid_return_type_for_catch_error
      .catchError((error) => log("Failed to get imcs: $error"));
  }

  removeImc(String id) {
    imcsFirebase.doc(id).delete()
      .then((value) => {
        setState(() {
          imcs.removeWhere((element) => element.id == id);
        })
      })
      // ignore: invalid_return_type_for_catch_error
      .catchError((error) => log("Failed to delete imc: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: imcs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/edit', arguments: imcs[index]);
                      },
                      onLongPress: () {
                        removeImc(imcs[index].id!);
                      },
                      title: Text(imcs[index].name),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Peso: ${imcs[index].weight}'),
                              Text('Altura: ${imcs[index].height}'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('IMC: ${imcs[index].imc}'),
                              Text('IMC Status: ${getIMCStatus(imcs[index].imc)}')
                            ],
                          ),
                        ]
                      ),
                    ),
                  );
                },
              ),
            ),

            AddButton(onPressed: () {
                Navigator.pushNamed(context, '/register');
            }),
            const SizedBox(height: 16),
          ],
        ),
      )
    );
  }
}