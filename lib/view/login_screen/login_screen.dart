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
  late final LoginViewModel _viewModel;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _viewModel = LoginViewModel();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => _viewModel,
      child: Consumer<LoginViewModel>(
        builder: (_, value, __) {
          switch (value.sessionUser.status) {
            case Status.initial:
              return _ComponentHome(
                emailController: _emailController,
                passwordController: _passwordController,
                viewModel: _viewModel,
              );
            case Status.loading:
              return const LoadingWidget();
            case Status.completed:
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.home,
                  ((route) => false),
                ),
              );
              return Container();
            case Status.error:
              // Tomar los errores del servicio
              return const CircularProgressIndicator();
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class _ComponentHome extends StatelessWidget {
  final LoginViewModel _viewModel;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  const _ComponentHome({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required LoginViewModel viewModel,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _viewModel = viewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        top: Dimens.d48,
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
                  child: Column(
                    children: [
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
                            _viewModel.signInWithPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
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
            ),
          ],
        ),
      ),
    );
  }
}
