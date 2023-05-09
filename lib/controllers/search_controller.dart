import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/models/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get seachedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    print('#####################################');
    print(typedUser);
    _searchedUsers.bindStream(
      firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<User> retVal = [];
          for (var elem in query.docs) {
            retVal.add(User.fromSnap(elem));
          }

          return retVal;
        },
      ),
    );
  }
}
// https://www.youtube.com/watch?v=WbXTl9tiziI
