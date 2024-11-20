///admin models

class AdminUsersModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  Null profilePicture;
  bool? emailVerified;
  bool? isAdmin;

  AdminUsersModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.emailVerified,
      this.isAdmin});

  AdminUsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePicture = json['profile_picture'];
    emailVerified = json['email_verified'];
    isAdmin = json['isAdmin'];
  }
}
