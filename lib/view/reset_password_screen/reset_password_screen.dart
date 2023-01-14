import 'package:flutter/material.dart';
import 'package:food_app/data/response/status.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/view_models/view_model.dart';
import 'package:food_app/res/components/components.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotViewModel>(
      create: (context) => ForgotViewModel(),
      child: Consumer<ForgotViewModel>(
        builder: (_, value, __) {
          switch (value.emailUser.status) {
            case Status.loading:
              _isLoading = true;
              return _ComponentsResetPassword(
                isLoading: _isLoading,
                viewModel: value,
              );
            case Status.completed:
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.login,
                  ((route) => false),
                ),
              );
              return Container();
            case Status.error:
              _isLoading = false;
              return _ComponentsResetPassword(
                isError: true,
                messageSnackBar: value.emailUser.message!,
                viewModel: value,
              );
            case Status.initial:
              _isLoading = false;
              return _ComponentsResetPassword(
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

class _ComponentsResetPassword extends StatelessWidget {
  final ForgotViewModel viewModel;

  final bool isLoading;
  final bool isError;
  final String messageSnackBar;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailcontroller = TextEditingController();

  _ComponentsResetPassword({
    Key? key,
    required this.viewModel,
    this.isLoading = false,
    this.isError = false,
    this.messageSnackBar = '',
  }) : super(key: key);

  Widget showErrorMessage(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(messageSnackBar),
          backgroundColor: Colors.red,
        ),
      );
    });
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoading,
        replacement: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                AppString.instance.restpass,
                style: AppStyle.instance.bodyMediumItems.copyWith(
                  color: AppColors.blackColor,
                  fontSize: Dimens.d20,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimens.d32),
                child: SizedBox(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputForm(
                          textLabel: AppString.instance.textEmail,
                          controller: _emailcontroller,
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
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Dimens.d40,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.sendEmail(
                                  email: _emailcontroller.text,
                                );
                              }
                            },
                            child: Text(
                              AppString.instance.enviarcontra,
                              style: AppStyle.instance.bodyMedium.copyWith(
                                fontSize: Dimens.d18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: Dimens.d40),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                                'Usted Recibira un correo que lo ayudara para restabblecer su contraseña',
                                textAlign: TextAlign.center,
                                style: AppStyle.instance.bodyMediumBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// reset pass complete
