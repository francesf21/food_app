import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/res/components/components.dart';
import 'package:food_app/view_models/view_model.dart';
import 'package:food_app/data/response/status.dart';

class ListItemProduct extends StatefulWidget {
  final Categories categories;

  const ListItemProduct({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<ListItemProduct> createState() => _ListItemProductState();
}

class _ListItemProductState extends State<ListItemProduct> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    _viewModel = HomeViewModel();
    _viewModel.getProductOfCategoryIdListApi(widget.categories.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 420,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimens.d8,
              horizontal: Dimens.d24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.categories.nameCategory,
                  style: AppStyle.instance.bodyMediumBlack,
                ),
              ],
            ),
          ),
          Expanded(
            child: ChangeNotifierProvider<HomeViewModel>(
              create: (context) => _viewModel,
              child: Consumer<HomeViewModel>(
                builder: (_, value, __) {
                  switch (value.productsList.status) {
                    case Status.completed:
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: value.productsList.data!.length,
                        itemBuilder: (context, index) {
                          final product = value.productsList.data![index];
                          return CardItemProduct(
                            nameProduct: product.name,
                            priceoProduct: product.price,
                            urlProduct: product.image,
                            descriptionProduct: product.descripction,
                          );
                        },
                      );
                    case Status.loading:
                      return const LoadingWidget();
                    case Status.error:
                      return const LoadingWidget();
                    default:
                      return const LoadingWidget();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
