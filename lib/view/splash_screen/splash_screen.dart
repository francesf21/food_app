import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/data/response/status.dart';
import 'package:food_app/view_models/view_model.dart';
import 'package:food_app/res/components/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> executeAfterBuild(String route) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushNamedAndRemoveUntil(
        route,
        ((route) => false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashViewModel>(
      create: (context) => SplashViewModel()..initSplash(),
      child: Consumer<SplashViewModel>(
        builder: (_, value, __) {
          switch (value.statusSplash.status) {
            case Status.error:
              return const _ComponentSplash();
            case Status.completed:
              if (value.statusSplash.data!) {
                executeAfterBuild(RoutesName.home);
                return Container(
                  color: AppColors.backgroundColor,
                );
              } else {
                executeAfterBuild(RoutesName.onboard);
                return Container(
                  color: AppColors.backgroundColor,
                );
              }
            case Status.loading:
              return const _ComponentSplash();
            default:
              return const _ComponentSplash();
          }
        },
      ),
    );
  }
}

class _ComponentSplash extends StatelessWidget {
  const _ComponentSplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            LogoImage(
              image: AppString.instance.pathLogoTipoImage,
              height: Dimens.heightLogo,
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(Dimens.d32),
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primaryColor,
                color: AppColors.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
