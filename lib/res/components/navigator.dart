import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/res/res.dart';

class NavigatorAppBar extends StatefulWidget {
  final void Function(int) onIndexPage;
  final int indexPage;

  const NavigatorAppBar({
    super.key,
    required this.onIndexPage,
    required this.indexPage,
  });

  @override
  State<NavigatorAppBar> createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorAppBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(Dimens.d24),
        topLeft: Radius.circular(Dimens.d24),
      ),
      child: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.backgroundItem,
        type: BottomNavigationBarType.shifting,
        currentIndex: widget.indexPage,
        onTap: (value) {
          widget.onIndexPage(value);
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Favoritos',
            icon: FaIcon(
              FontAwesomeIcons.heart,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: FaIcon(
              FontAwesomeIcons.circleUser,
            ),
          ),
        ],
      ),
    );
  }
}
