import 'package:boardingadmissions/views/notification.dart';
import 'package:boardingadmissions/views/side_menu_bar.dart';
import 'package:boardingadmissions/views/search_page.dart';

import 'package:flutter/material.dart';

class CompatibilityTestAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CompatibilityTestAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(76.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 76,
      elevation: 0,
      flexibleSpace: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.8),
              Colors.white,
            ],
            stops: const [0.0, 1],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
