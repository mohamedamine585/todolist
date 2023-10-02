import 'package:to_do_app/Backend/modules/Group.dart';

class User {
  String email;
  String? id;
  List<String>? groups;
  User({this.id, required this.email, this.groups});
}
