
class UserEntity {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final String username;
  final String password;

  UserEntity(
      {this.id,
      required this.fname,
      required this.lname,
      required this.phone,
      required this.username,
      required this.password,
      this.image});
}
