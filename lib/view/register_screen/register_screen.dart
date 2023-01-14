import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/data/response/status.dart';
import 'package:food_app/view_models/view_model.dart';
import 'package:food_app/res/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (_, value, __) {
          switch (value.sessionUser.status) {
            case Status.loading:
              _isLoading = true;
              return _ComponentsRegister(
                isLoading: _isLoading,
                viewModel: value,
              );
            case Status.completed:
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.person,
                  ((route) => false),
                ),
              );
              return Container();
            case Status.error:
              _isLoading = false;
              return _ComponentsRegister(
                isError: true,
                messageSnackBar: value.sessionUser.message!,
                viewModel: value,
              );
            case Status.initial:
              _isLoading = false;
              return _ComponentsRegister(
                isLoading: _isLoading,
                viewModel: value,
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
  final RegisterViewModel viewModel;

  final bool isLoading;
  final bool isError;
  final String messageSnackBar;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _ComponentsRegister({
    Key? key,
    required this.viewModel,
    this.isLoading = false,
    this.isError = false,
    this.messageSnackBar = "",
  }) : super(key: key);

  Widget showErrorMessage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.showErrorSnackBar(
        message: messageSnackBar,
      ),
    );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoading,
        replacement: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isError) showErrorMessage(context),
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
                    key: _formKey,
                    child: Column(
                      children: [
                        InputForm(
                          controller: _emailController,
                          textLabel: AppString.instance.textEmail,
                          textInputType: TextInputType.emailAddress,
                          onValidate: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese un correo electrónico valido";
                            }

                            if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value)) {
                              return 'El valor ingresado no es un correo electrónico';
                            }

                            return null;
                          },
                        ),
                        InputForm(
                          controller: _passwordController,
                          textLabel: AppString.instance.textPassword,
                          obscureText: true,
                          onValidate: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese una contraseña valida";
                            }

                            if (value.length < 6) {
                              return "La contraseña debe tener al menos 6 caracteres";
                            }

                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Dimens.d40,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.signUpUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
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
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
