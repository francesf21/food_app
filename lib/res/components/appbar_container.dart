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
            case Status.completed:
              return _AppBarElement(
                isLoading: false,
                isError: false,
                isDefault: false,
                urlImage: value.userProfile.data!.avatarUrl,
              );
            case Status.loading:
              return const _AppBarElement(
                isLoading: true,
                isError: false,
                isDefault: false,
              );
            case Status.error:
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

  const _AppBarElement({
    Key? key,
    required this.isLoading,
    required this.isError,
    required this.isDefault,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primaryColor,
              size: Dimens.d32,
            ),
          )
        ],
      ),
    );
  }
}
