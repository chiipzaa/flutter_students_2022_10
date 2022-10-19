import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter1/src/bloc/management/management_bloc.dart';
import 'package:flutter1/src/models/Product.dart';
import 'package:flutter1/src/pages/management/widgets/product_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onPressed: () => context.read<ManagementBloc>().add(
                ManagementEvent_Submit(
                  product: _product,
                  form: _form,
                  isEditMode: _editMode,
                  image: _imageFile,
                ),
              ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ProductForm(
            _product,
            callBackSetImage: (file) {
              _imageFile = file;
            },
            formKey: _form,
            deleteProduct: () {},
          ),
        ),
      ),
    );
  }
}
