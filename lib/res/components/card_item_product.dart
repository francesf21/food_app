import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/res/res.dart';

class CardItemProduct extends StatefulWidget {
  final String nameProduct;
  final double priceoProduct;
  final String urlProduct;
  final String descriptionProduct;
  final bool? statusFavorite;

  final void Function()? onPressed;

  const CardItemProduct({
    Key? key,
    required this.nameProduct,
    required this.priceoProduct,
    required this.urlProduct,
    required this.descriptionProduct,
    this.statusFavorite,
    this.onPressed,
  }) : super(key: key);

  @override
  State<CardItemProduct> createState() => _CardItemProductState();
}

class _CardItemProductState extends State<CardItemProduct> {
  late bool _showFrontSide;
  late bool _flipXAxis;

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 420,
      child: _buildFlipAnimation(),
    );
  }

  Widget _buildFlipAnimation() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: _transitionBuilder,
      layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeInBack.flipped,
      child: _showFrontSide ? _CardFront() : _CardBack(),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildLayout({
    required Key key,
    required Widget child,
  }) {
    return Container(
      key: key,
      child: child,
    );
  }

  Widget _CardFront() {
    return _buildLayout(
      key: const ValueKey(true),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.d70,
              left: Dimens.d8,
              right: Dimens.d8,
            ),
            child: Card(
              elevation: Dimens.d8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.d24),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimens.d8,
                        right: Dimens.d8,
                        top: Dimens.d8,
                      ),
                      child: Center(
                        child: Text(
                          widget.nameProduct,
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
                        'S/. ${widget.priceoProduct}',
                        style: AppStyle.instance.bodyMediumBlack,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.d8),
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.primaryColor,
                        ),
                        onPressed: widget.onPressed,
                        label: Text(
                          AppString.instance.addText,
                        ),
                        icon: FaIcon(
                          widget.statusFavorite != null
                              ? widget.statusFavorite!
                                  ? FontAwesomeIcons.heartCircleCheck
                                  : FontAwesomeIcons.heart
                              : FontAwesomeIcons.heart,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  _switchCard();
                  setState(() {});
                },
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.only(
                    right: Dimens.d16,
                    left: Dimens.d16,
                    top: Dimens.d4,
                    bottom: Dimens.d4,
                  ),
                  child: Icon(
                    Icons.replay_outlined,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 138,
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
                      backgroundImage: NetworkImage(widget.urlProduct),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _CardBack() {
    return _buildLayout(
      key: const ValueKey(false),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.d70,
              left: Dimens.d8,
              right: Dimens.d8,
            ),
            child: Card(
              elevation: Dimens.d8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.d24),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.descriptionProduct,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.instance.errorbody,
                        maxLines: 6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _switchCard();
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            right: Dimens.d16,
                            left: Dimens.d16,
                            top: Dimens.d4,
                            bottom: Dimens.d4,
                          ),
                          child: Icon(
                            Icons.replay_outlined,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
