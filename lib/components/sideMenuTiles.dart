import 'package:boardingadmissions/models/rive_assets.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideMenuTiles extends StatelessWidget {
  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  const SideMenuTiles({
    Key? key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Container(
        height: 34,
        width: 34,
        child: RiveAnimation.asset(
          menu.src,
          artboard: menu.artboard,
          onInit: riveonInit,
        ),
      ),
    );
  }
}
