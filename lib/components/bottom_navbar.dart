import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomNavigation({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: widget.currentIndex,
      onTap: widget.onTabTapped,
      items: [
        _createNavItem(0, Icons.home, 'Home'),
        _createNavItem(1, Icons.person, 'Profile'),
        _createNavItem(2, Icons.notifications, 'Notifications'),
        _createNavItem(3, Icons.chat_bubble_outline, 'Chat'),
      ],
    );
  }

  BottomNavigationBarItem _createNavItem(int index, IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: ElevatedButton(
        onPressed: () {
          widget.onTabTapped(index);
        },
        style: ElevatedButton.styleFrom(
          elevation: widget.currentIndex == index ? 4 : 0,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: widget.currentIndex == index ? Colors.blue : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: widget.currentIndex == index ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      label: '',
    );
  }
}
