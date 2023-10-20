import 'package:boardingadmissions/components/side_menu_bar.dart';
import 'package:boardingadmissions/views/search_page.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(76.0);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Color.fromRGBO(2, 84, 152, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchBarButton()));
                      // Handle notifications icon press
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                      color: Color.fromRGBO(2, 84, 152, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuScreen()));
                      // Handle notifications icon press
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
