import 'package:flutter/material.dart';
import 'package:food_app/data/response/status.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/view_models/view_model.dart';
import 'package:food_app/res/components/components.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final RegisterViewModel _viewModel;

  @override
  void initState() {
    _viewModel = RegisterViewModel();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => _viewModel,
      child: Consumer<RegisterViewModel>(
        builder: (_, value, __) {
          switch (value.sessionUser.status) {
            case Status.loading:
              return const LoadingWidget();
            case Status.completed:
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.person,
                  ((route) => false),
                ),
              );
              return Container();
            case Status.error:
              // tomar los errores del servicio
              return const CircularProgressIndicator();
            case Status.initial:
              return _ComponentsRegister(
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                viewModel: _viewModel,
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class _ComponentsRegister extends StatelessWidget {
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final RegisterViewModel _viewModel;

  const _ComponentsRegister({
    Key? key,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required RegisterViewModel viewModel,
  })  : _nameController = nameController,
        _emailController = emailController,
        _passwordController = passwordController,
        _viewModel = viewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Dimens.d32,
                ),
              ),
              elevation: Dimens.d8,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Dimens.d40,
                      ),
                      child: LogoImage(
                        image: AppString.instance.pathOnboardImageIcon,
                        height: Dimens.heightIcon,
                      ),
                    ),
                    AppText(
                      text: AppString.instance.registerTitle,
                      style: AppStyle.instance.titleText,
                      topPadding: Dimens.d24,
                      bottomPadding: Dimens.d24,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: Dimens.d32,
              ),
              child: SizedBox(
                child: Form(
                  child: Column(
                    children: [
                      InputForm(
                        controller: _nameController,
                        textLabel: AppString.instance.textUserName,
                      ),
                      InputForm(
                        controller: _emailController,
                        textLabel: AppString.instance.textEmail,
                        textInputType: TextInputType.emailAddress,
                      ),
                      InputForm(
                        controller: _passwordController,
                        textLabel: AppString.instance.textPassword,
                        obscureText: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.d40,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _viewModel.signUpUser(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushNamed(
                                RoutesName.person,
                              );
                            });
                          },
                          child: Text(
                            AppString.instance.registerTitle,
                            style: AppStyle.instance.bodyMedium.copyWith(
                              fontSize: Dimens.d18,
                            ),
                          ),
                        ),
                      ),
                      ForgetAuthOption(
                        onPressed: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).pushNamed(
                              RoutesName.login,
                            );
                          });
                        },
                        text: AppString.instance.textTitleRegister,
                        action: AppString.instance.actionRegister,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
