import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/data/response/status.dart';
import 'package:food_app/res/components/components.dart';
import 'package:food_app/view_models/view_model.dart';

class ItemListCategories extends StatefulWidget {
  const ItemListCategories({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemListCategories> createState() => _ItemListCategoriesState();
}

class _ItemListCategoriesState extends State<ItemListCategories> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    _viewModel = HomeViewModel();
    _viewModel.getCategoriesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => _viewModel,
      child: Consumer<HomeViewModel>(
        builder: (_, value, __) {
          switch (value.categoriesList.status) {
            case Status.completed:
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemCount: value.categoriesList.data!.length,
                itemBuilder: (context, index) {
                  final category = value.categoriesList.data![index];
                  return ListItemProduct(
                    categories: category,
                  );
                },
              );
            case Status.error:
              return const LoadingWidget();
            case Status.loading:
              return const LoadingWidget();
            default:
              return const LoadingWidget();
          }
        },
      ),
    );
  }
}
