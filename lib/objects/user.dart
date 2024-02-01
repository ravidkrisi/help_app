import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  late String userId;
  late String name;
  late String email;
  late String nickname;
  late String creditcard;

  // // default constructor
  // User() : userId = '', name = '', email = '', nickname = '', creditcard = '';

  // Constructor for creating a user instance with data
  AppUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.nickname,
    required this.creditcard,
  });

  // Named constructor for creating a default user
  AppUser.defaultUser()
      : userId = '',
        name = '',
        email = '',
        nickname = '',
        creditcard = '';

  // Factory constructor to create a user instance from a DocumentSnapshot
  factory AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print("retrieve data from user");
    return AppUser(
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      nickname: data['nickname'] ?? '',
      creditcard: data['creditcard'] ?? '',
    );
  }

  // Function to add user data to Firestore
  static Future<void> addUserDataToFirestore(AppUser user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.add({
      'userId': user.userId,
      'name': user.name,
      'email': user.email,
      'nickname': user.nickname,
      'creditcard': user.creditcard,
    });
  }

  // Function to get user data from Firestore by ID
  static Future<AppUser?> getUserById(String? userId) async {

    // check if user null
    if (userId == null) return null;
    
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: userId)
              .get();

      // Check if there are any matching documents
      if (querySnapshot.docs.isNotEmpty) {
        // Access the first document in the snapshot
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;

        // Create a User instance from the document
        AppUser user = AppUser.fromSnapshot(documentSnapshot);

        return user;
      } else {
        // No matching documents found
        return null;
      }
    } catch (error) {
      print('Error retrieving user data: $error');
      return null;
    }
  }
}
