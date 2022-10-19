import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter1/src/models/Product.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _form = GlobalKey<FormState>();
  var _product = Product(name: "", price: 0, stock: 0);
  var _editMode = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Product) {
      _product = arguments;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Management"), actions: [
        IconButton(
          icon: Icon(Icons.upload),
          onPressed: () {
            _form.currentState?.save();
            print("Debug: ${_product.name}\n ${_product.price}\n ${_product.stock}");
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              // name
              TextFormField(
                initialValue: _product.name,
                decoration: InputDecoration(labelText: "Name"),
                onSaved: (value){
                  if (value != null) {
                    _product.name = value;
                  }
              },),
              // price
              TextFormField(
                initialValue: _product.price.toString(),
                decoration: InputDecoration(labelText: "Price"),
                onSaved: (value){
                  if (value != null) {
                    _product.price = int.parse(value);
                  }
                },),
              TextFormField(
                initialValue: _product.stock.toString(),
                decoration: InputDecoration(labelText: "Stock"),
                onSaved: (value){
                  if (value != null) {
                    _product.stock = int.parse(value);
                  }
                },),
            ],
          ),
        ),
      ),
    );
  }
}
