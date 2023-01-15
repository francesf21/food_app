import 'package:flutter/material.dart';
import 'package:food_app/data/response/status.dart';
import 'package:food_app/models/product.dart';
import 'package:food_app/res/components/error_component.dart';
import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchViewModel _viewModel;

  @override
  void initState() {
    _viewModel = SearchViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.d16,
                  left: Dimens.d24,
                  right: Dimens.d24,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: (() {
                        Future.delayed(Duration.zero, () {
                          Navigator.of(context).pushNamed(
                            RoutesName.home,
                          );
                        });
                      }),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.d8),
                      child: Text(
                        "Buscador",
                        style: AppStyle.instance.bodyXLargeBlack,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.d16,
                  left: Dimens.d24,
                  right: Dimens.d24,
                  bottom: Dimens.d16,
                ),
                child: Container(
                  height: Dimens.d70,
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColors.greyColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.d16,
                      top: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.search),
                        Flexible(
                          child: TextFormField(
                            onChanged: (value) {
                              _viewModel.getSearchProductList(value);
                            },
                            cursorColor: AppColors.primaryColor,
                            keyboardType: TextInputType.text,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              hintText: "Busca lo que quieras!",
                              hintStyle: AppStyle.instance.errorbody,
                              focusColor: AppColors.primaryColor,
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ChangeNotifierProvider<SearchViewModel>(
                  create: (context) => _viewModel,
                  child: Consumer<SearchViewModel>(
                    builder: (_, value, __) {
                      switch (value.searchProductList.status) {
                        case Status.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case Status.completed:
                          return CardSearchProduct(
                            products: value.searchProductList.data!,
                          );
                        case Status.error:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case Status.initial:
                          return const ErrorComponent(
                            icon: Icons.search,
                            titleError: 'Inicia Tu Busqueda',
                            bodyError:
                                'Descubre todos los productos que tenemos para ti',
                          );
                        default:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardSearchProduct extends StatefulWidget {
  final List<Products> products;

  const CardSearchProduct({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<CardSearchProduct> createState() => _CardSearchProductState();
}

class _CardSearchProductState extends State<CardSearchProduct> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return Padding(
            padding: const EdgeInsets.only(
              top: Dimens.d8,
              left: Dimens.d24,
              right: Dimens.d24,
            ),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        height: 100,
                        width: 150,
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
                              backgroundImage: NetworkImage(product.image),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: Dimens.d6),
                            child: Center(
                              child: Text(
                                product.name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppStyle.instance.bodyText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.d8,
                              right: Dimens.d8,
                            ),
                            child: Text(
                              'S/. ${product.price}',
                              style: AppStyle.instance.errorbody,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: Dimens.d8,
                      right: Dimens.d16,
                    ),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () {},
                      label: Text(
                        AppString.instance.addText,
                      ),
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
