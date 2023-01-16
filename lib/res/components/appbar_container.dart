import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/data/response/status.dart';
import 'package:food_app/view_models/view_model.dart';

class AppbarContainer extends StatefulWidget {
  const AppbarContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppbarContainer> createState() => _AppbarContainerState();
}

class _AppbarContainerState extends State<AppbarContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel()..getProfileApi(),
      child: Consumer<ProfileViewModel>(
        builder: (_, value, __) {
          switch (value.userProfile.status) {
            case Status.completed:
              return _AppBarElement(
                isLoading: false,
                isError: false,
                isDefault: false,
                urlImage: value.userProfile.data!.avatarUrl,
                name:
                    "${value.userProfile.data!.firstname} ${value.userProfile.data!.lastname}",
              );
            case Status.loading:
              return const _AppBarElement(
                isLoading: true,
                isError: false,
                isDefault: false,
              );
            case Status.error:
              value.getProfileApi();
              return const _AppBarElement(
                isLoading: true,
                isError: true,
                isDefault: false,
              );
            default:
              return const _AppBarElement(
                isLoading: false,
                isError: false,
                isDefault: true,
              );
          }
        },
      ),
    );
  }
}

class _AppBarElement extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final bool isDefault;
  final String? urlImage;
  final String? name;

  const _AppBarElement({
    Key? key,
    required this.isLoading,
    required this.isError,
    required this.isDefault,
    this.name = '',
    this.urlImage = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.d24,
        vertical: Dimens.d16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Dimens.d24,
            backgroundImage: (isLoading
                ? null
                : (urlImage != '' ? NetworkImage(urlImage!) : null)),
            child: (isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (isDefault
                    ? Image.asset(AppString.instance.pathProfileImage)
                    : null)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.d16),
            child: Text(
              name ?? '',
              style: AppStyle.instance.textAppBar,
            ),
          ),
        ],
      ),
    );
  }
}
