class User {
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;

  User(this.displayName, this.email, this.id, this.photoUrl);

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'id': id,
        'photoUrl': photoUrl
      };

  @override
  String toString() {
    var result = "displayName : ${displayName.toString()}\n" +
        "email : ${email.toString()}\n" +
        "id : ${id.toString()}\n" +
        "photoUrl : ${photoUrl.toString()}";
    return result;
  }
}
