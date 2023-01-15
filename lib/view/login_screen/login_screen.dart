import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/data/response/status.dart';
import 'package:food_app/view_models/view_model.dart';
import 'package:food_app/res/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (_, value, __) {
          switch (value.sessionUser.status) {
            case Status.loading:
              _isLoading = true;
              return _ComponentLogin(
                isLoading: _isLoading,
                viewModel: value,
              );
            case Status.completed:
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.home,
                  ((route) => false),
                ),
              );
              return Container();
            case Status.error:
              _isLoading = false;
              return _ComponentLogin(
                isError: true,
                messageSnackBar: value.sessionUser.message!,
                viewModel: value,
              );
            case Status.initial:
              _isLoading = false;
              return _ComponentLogin(
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

class _ComponentLogin extends StatelessWidget {
  final LoginViewModel viewModel;

  final bool isLoading;
  bool isError;
  final String messageSnackBar;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _ComponentLogin({
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
    isError = false;
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
                        text: AppString.instance.welcome,
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
                              return AppString
                                  .instance.textValidateEmailIsEmpty;
                            }

                            if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value)) {
                              return AppString.instance.textValidateEmailRegex;
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
                              return AppString
                                  .instance.textValidatePasswordIsEmpty;
                            }

                            if (value.length < 6) {
                              return AppString.instance.textValidatePasswordMin;
                            }

                            return null;
                          },
                        ),
                        ForgetAuthOption(
                          onPressed: () {
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushNamed(
                                RoutesName.resetPassowrd,
                              );
                            });
                          },
                          text: '',
                          action: AppString.instance.textTitleReset,
                          isRight: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Dimens.d40,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.signInWithPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                            child: Text(
                              AppString.instance.actionRegister,
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
                                RoutesName.register,
                              );
                            });
                          },
                          text: AppString.instance.textTitleLogin,
                          action: AppString.instance.actionlogin,
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
