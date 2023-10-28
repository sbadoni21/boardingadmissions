// import 'package:boardingadmissions/views/chatapp.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class ChatNavBar extends StatefulWidget implements PreferredSizeWidget {
//   ChatNavBar({super.key});

//   @override
//   _ChatNavBarState createState() => _ChatNavBarState();
// }
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   String? displayName;
//   String? profilePhoto;
// @override
// void initState() {

//   fetchDisplayName();
// }
// void fetchDisplayName() async {
//   // Replace 'users' with the path to your collection containing user data
//   final userDoc = FirebaseFirestore.instance
//       .collection('users')
//       .doc(_firebaseAuth.currentUser!.uid);
//   userDoc.get().then((doc) {
//     if (doc.exists) {
//       final userData = doc.data() as Map<String, dynamic>;
//       setState(() {
//         displayName = userData['displayName'];
//         profilePhoto = userData['profilePhoto'];
//         // Adjust the field name as per your database structure
//       });
//     }
//   }).catchError((error) {
//     print('Error fetching display name: $error');
//   });
// }
// @override
// Size get preferredSize => const Size.fromHeight(76.0);
// @override
// Widget build(BuildContext context) {
//   return AppBar(
//     automaticallyImplyLeading: false,
//     toolbarHeight: 76,
//     elevation: 0,
//     flexibleSpace: Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.white.withOpacity(0.8),
//             Colors.white,
//           ],
//           stops: const [0.0, 1],
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             width: 150,
//             padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//             child: Image.asset(
//               'assets/logo.png',
//               fit: BoxFit.fill,
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     size: 30,
//                     color: Color.fromRGBO(2, 84, 152, 1),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ChatApp()));
//                     // Handle notifications icon press
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(
//                     Icons.menu,
//                     size: 30,
//                     color: Color.fromRGBO(2, 84, 152, 1),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const MenuScreen()));
//                     // Handle notifications icon press
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }