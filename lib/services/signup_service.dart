import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup_service {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String selectedClass,
    required String location,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Save additional user data to Firestore
        await _fireStore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email':email, 'displayName':name, 'status': 'Online'},SetOptions(merge: true));

        // User registration successful, you can navigate to a new page or perform other actions.
      }
    } catch (e) {
      // Handle errors, e.g., show a snackbar to the user.
      print(e.toString());
    }
  }
}
