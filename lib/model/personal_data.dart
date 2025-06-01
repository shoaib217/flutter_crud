import '../widgets/personal_from.dart';

class PersonData {
  String id;
  String name;
  String email;
  String mobile;
  Gender gender;
  int color;

  PersonData(
      {this.id = '0',
      required this.name,
      required this.email,
      required this.mobile,
      required this.gender,
      required this.color});
}
