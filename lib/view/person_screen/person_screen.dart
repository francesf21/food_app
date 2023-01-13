import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/routes/routes.dart';
import 'package:food_app/res/components/components.dart';
import 'package:food_app/view_models/view_model.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  late final TextEditingController _userNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;

  String? _avatarUrl;

  Future<void> _onUpload(String imageUrl) async {
    _avatarUrl = imageUrl;
    setState(() {});
  }

  @override
  void initState() {
    _userNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileProvider = Provider.of<ProfileViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Avatar(
            imageUrl: _avatarUrl,
            onUpload: _onUpload,
          ),
          InputForm(
            textLabel: 'Nombre de Usuario',
            controller: _userNameController,
          ),
          InputForm(
            textLabel: 'Nombres',
            controller: _firstNameController,
          ),
          InputForm(
            textLabel: 'Apellidos',
            controller: _lastNameController,
          ),
          InputForm(
            textLabel: 'Telefono',
            controller: _phoneController,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 24,
              right: 24,
            ),
            child: ElevatedButton(
              onPressed: (() {
                profileProvider.createProfile(
                  username: _userNameController.text,
                  firstname: _firstNameController.text,
                  lastname: _lastNameController.text,
                  phoneUser: _phoneController.text,
                  avatarUrl: _avatarUrl ?? "",
                );
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushNamed(
                    RoutesName.home,
                  );
                });
              }),
              child: const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}
