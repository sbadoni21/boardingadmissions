import 'package:boardingadmissions/components/sideMenuTiles.dart';
import 'package:flutter/material.dart';
import 'package:boardingadmissions/models/rive_assets.dart';

class SideMenuBar extends StatefulWidget {
  const SideMenuBar({Key? key});

  @override
  State<SideMenuBar> createState() => _SideMenuBarState();
}

class _SideMenuBarState extends State<SideMenuBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Use SingleChildScrollView to make the content scrollable
        child: Container(
          width: 288,
          color: Colors.blue,
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Container(child: Image.asset('school2.png')),
                    backgroundColor: Colors.white70,
                  ),
                  title: Text(
                    "XAVIER",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Xavier@hotmail.com",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: CloseButton(
                    onPressed: () => {},
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Browse"),
                // Use a Column instead of ListView to avoid infinite height
                Expanded(
                 
                  child: Column(
                    children: sideMenus
                      .map((menu) => SideMenuTiles(
                            menu: menu,
                            riveonInit: (artboard) {},
                            press: () {},
                            isActive: true,
                          ))
                      .toList(),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
