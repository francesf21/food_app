import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/view_models/view_model.dart';
import 'package:food_app/res/components/components.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ForgotViewModel forgotProvider = Provider.of<ForgotViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              AppString.instance.restpass,
              style: AppStyle.instance.bodyMedium.copyWith(
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
                  child: Column(
                    children: [
                      InputForm(
                        textLabel: AppString.instance.textEmail,
                        controller: _emailcontroller,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.d40,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            forgotProvider.forgotPassword(
                              email: _emailcontroller.text,
                            );
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushNamed(
                                RoutesName.login,
                              );
                            });
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
