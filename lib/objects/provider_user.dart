// Extended class with additional property
import 'package:help_app/objects/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderUser extends AppUser {
  late String profession;
  late double rating;

  ProviderUser({
    required String userId,
    required String name,
    required String email,
    //required String area,
    required int type,
    required this.profession,
    required this.rating,
  }) : super(
          userId: userId,
          name: name,
          email: email,
          //area: area,
          type: type,
        );

  // Override the getUserById method to return additional information
  static Future<ProviderUser?> getUserById(String? userId) async {
    if (userId == null) return null;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: userId)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Create a ProviderUser instance
        print(data['rating']);
        ProviderUser user = ProviderUser(
          userId: data['userId'] ?? '',
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          profession: data['proffesion'] ?? '',
          rating: double.parse(data['rating'] ?? '0'),
          // area: data['area'] ?? '',
          type: data['type'] ?? '',
        );

        return user;
      } else {
        return null;
      }
    } catch (error) {
      print('Error retrieving user data: $error');
      return null;
    }
  }
}
