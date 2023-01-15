import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/data/response/status.dart';
import 'package:food_app/res/components/components.dart';
import 'package:food_app/view_models/favorite_view_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.d24,
              vertical: Dimens.d12,
            ),
            child: Text(
              "Favoritos",
              style: AppStyle.instance.h2BoldBlack,
            ),
          ),
          ChangeNotifierProvider<FavoriteViewModel>(
            create: (context) => FavoriteViewModel()..getFavorite(),
            child: Consumer<FavoriteViewModel>(
              builder: (_, value, __) {
                switch (value.favoriteList.status) {
                  case Status.loading:
                    return _ComponentFavorite(
                      viewModel: value,
                      isLoading: true,
                      isError: false,
                      listLength: 0,
                    );
                  case Status.completed:
                    return _ComponentFavorite(
                      viewModel: value,
                      isLoading: false,
                      isError: false,
                      listLength: value.favoriteList.data!.length,
                      favorites: value.favoriteList.data,
                    );
                  case Status.error:
                    return _ComponentFavorite(
                      viewModel: value,
                      isLoading: false,
                      isError: true,
                      listLength: 0,
                    );
                  case Status.initial:
                    return _ComponentFavorite(
                      viewModel: value,
                      isLoading: false,
                      isError: false,
                      listLength: 0,
                    );
                  default:
                    return _ComponentFavorite(
                      viewModel: value,
                      isLoading: true,
                      isError: false,
                      listLength: 0,
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ComponentFavorite extends StatelessWidget {
  final bool isLoading;
  bool isError;
  final String? messageSnackBar;

  final int listLength;
  final List<Favorites>? favorites;

  final FavoriteViewModel viewModel;

  _ComponentFavorite({
    Key? key,
    this.isLoading = false,
    this.messageSnackBar = '',
    this.listLength = 0,
    this.isError = false,
    this.favorites,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Visibility(
        visible: isLoading,
        replacement: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: listLength,
          itemBuilder: (context, index) {
            final favorite = favorites![index];
            return Padding(
              padding: const EdgeInsets.only(
                top: Dimens.d8,
                left: Dimens.d24,
                right: Dimens.d24,
                bottom: Dimens.d12,
              ),
              child: CardProductList(
                image: favorite.image,
                name: favorite.name,
                price: favorite.price,
                statusFavorite: favorite.status,
                onPressed: () {
                  viewModel.updateFavorite(
                    statusFavorite: !favorite.status,
                    favoriteId: favorite.favoriteId,
                  );
                },
              ),
            );
          },
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
