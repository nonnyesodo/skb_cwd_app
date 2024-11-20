///user model to save user information coming from backend

class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  dynamic mobileNmuber;
  String? profilePicture;
  bool? emailVerified;
  bool? isAdmin;
  String? bearerToken;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.emailVerified,
      this.mobileNmuber,
      this.bearerToken,
      this.isAdmin});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    mobileNmuber = json['mobile_number'];
    lastName = json['last_name'];
    profilePicture = json['profile_picture'];
    emailVerified = json['email_verified'];
    bearerToken = json['bearer_token'];
    isAdmin = json['isAdmin'];
  }
}
