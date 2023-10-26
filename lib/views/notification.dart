
import 'package:boardingadmissions/views/side_menu_bar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();

    // Simulated notifications
    notifications = [
      NotificationItem(content: "Notification 1", isRead: false),
      NotificationItem(content: "Notification 2", isRead: true),
      NotificationItem(content: "Notification 3", isRead: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                stops: const [
                  0.0,
                  1,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search,
                            size: 30, color: Color.fromRGBO(2, 84, 152, 1)),
                        onPressed: () {
                          // Handle search icon press
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu,
                            size: 30, color: Color.fromRGBO(2, 84, 152, 1)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MenuScreen()));
                          // Handle notifications icon press
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (BuildContext context, int index) {
            return buildNotificationItem(notifications[index]);
          },
        ),
      ),
    );
  }

  Widget buildNotificationItem(NotificationItem notification) {
    Color backgroundColor =
        notification.isRead ? Colors.lightBlue : Colors.blue;

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Text(
        notification.content,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}

class NotificationItem {
  final String content;
  final bool isRead;

  NotificationItem({required this.content, required this.isRead});
}
