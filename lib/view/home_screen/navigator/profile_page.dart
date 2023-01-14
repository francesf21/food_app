import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/data/response/status.dart';
import 'package:food_app/models/profile.dart';
import 'package:food_app/res/components/app_text.dart';
import 'package:food_app/res/components/components.dart';
import 'package:food_app/res/components/error_component.dart';
import 'package:food_app/res/res.dart';
import 'package:food_app/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ProfileViewModel();
    _viewModel.getProfileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => _viewModel,
      child: Consumer<ProfileViewModel>(
        builder: (_, value, __) {
          switch (value.userProfile.status) {
            case Status.loading:
              return const LoadingWidget();
            case Status.completed:
              return _ComponentProfile(profile: value.userProfile.data!);
            case Status.error:
              return const ErrorComponent(
                icon: FontAwesomeIcons.userXmark,
                titleError: 'Perfil no Encontrado',
                bodyError: 'El perfil no ha sido encontrado',
              );
            case Status.initial:
              return const LoadingWidget();
            default:
              return const LoadingWidget();
          }
        },
      ),
    );
  }
}

class _ComponentProfile extends StatelessWidget {
  final Profiles profile;

  const _ComponentProfile({
    Key? key,
    required this.profile,
  }) : super(key: key);

  Future<void> _showMyDialog(BuildContext context) async {
    final ProfileViewModel _viweModel = ProfileViewModel();

    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Cerrar Sesion'),
        content: Text("¿Estas seguro que deseas cerrar sesion?"),
        actions: <Widget>[
          TextButton(
              child: Text(
                "Aceptar",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
              onPressed: () {
                _viweModel.signOut();
              }),
          TextButton(
              child: Text(
                "Cancelar",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppText(
            topPadding: Dimens.d8,
            text: 'Perfil',
            style: AppStyle.instance.h2BoldBlack,
          ),
          SizedBox(
            width: double.infinity,
            height: 450,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.d70,
                    left: Dimens.d24,
                    right: Dimens.d24,
                  ),
                  child: Card(
                    elevation: Dimens.d12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.d24),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.d8,
                              right: Dimens.d8,
                              top: Dimens.d80,
                            ),
                            child: Center(
                              child: Text(
                                '${profile.firstname} ${profile.lastname}',
                                textAlign: TextAlign.center,
                                style: AppStyle.instance.h5BoldBlack,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.d8,
                              right: Dimens.d8,
                            ),
                            child: Text(
                              profile.username,
                              style: AppStyle.instance.bodyMediumBlack,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.d8,
                              right: Dimens.d8,
                            ),
                            child: Text(
                              profile.phoneUser,
                              style: AppStyle.instance.bodyMediumBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Material(
                      shape: const CircleBorder(
                        side: BorderSide.none,
                      ),
                      elevation: Dimens.d16,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(profile.avatarUrl!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ItemButtonProfile(
            icon: Icons.help_outline_outlined,
            text: 'Ayuda',
            onTap: () {},
          ),
          ItemButtonProfile(
            icon: Icons.exit_to_app,
            text: 'Cerrar Sesión',
            onTap: () {
              _showMyDialog(context);
            },
          )
        ],
      ),
    );
  }
}

class ItemButtonProfile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const ItemButtonProfile({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.d24,
        vertical: Dimens.d6,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Card(
          elevation: Dimens.d8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.d16),
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.d16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.start,
                    style: AppStyle.instance.bodyMediumBlack,
                  ),
                  Icon(
                    icon,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
