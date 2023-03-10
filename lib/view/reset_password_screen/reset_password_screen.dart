import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/data/response/status.dart';
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
              return _ComponentResetPassword(
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
              return Container(
                color: AppColors.backgroundColor,
              );
            case Status.error:
              _isLoading = false;
              return _ComponentResetPassword(
                isError: true,
                messageSnackBar: value.emailUser.message!,
                viewModel: value,
              );
            case Status.initial:
              _isLoading = false;
              return _ComponentResetPassword(
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

class _ComponentResetPassword extends StatelessWidget {
  final ForgotViewModel viewModel;

  final bool isLoading;
  bool isError;
  final String messageSnackBar;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailcontroller = TextEditingController();

  _ComponentResetPassword({
    Key? key,
    required this.viewModel,
    this.isLoading = false,
    this.isError = false,
    this.messageSnackBar = '',
  }) : super(key: key);

  Widget showErrorMessage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(messageSnackBar),
          backgroundColor: Colors.red,
        ),
      );
    });
    isError = false;
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoading,
        replacement: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  AppString.instance.resetPassword,
                  style: AppStyle.instance.bodyXLargeBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.d32,
                  right: Dimens.d16,
                  left: Dimens.d16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputForm(
                        controller: _emailcontroller,
                        textLabel: AppString.instance.textEmail,
                        textInputType: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            return AppString.instance.textValidateEmailIsEmpty;
                          }

                          if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value)) {
                            return AppString.instance.textValidateEmailRegex;
                          }

                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.d16,
                          left: Dimens.d24,
                          right: Dimens.d24,
                        ),
                        child: Container(
                          color: AppColors.primaryColor.withOpacity(.2),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              AppString.instance.textSendEmailPasswordReset,
                              textAlign: TextAlign.justify,
                              style: AppStyle.instance.errorbody.copyWith(
                                color: AppColors.blackColor.withOpacity(.6),
                              ),
                            ),
                          ),
                        ),
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
                    ],
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
