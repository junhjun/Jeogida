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
    // TODO: implement toString
    print("displayName : " + displayName.toString());
    print("email : " + email.toString());
    print("id : " + id.toString());
    print("photoUrl : " + photoUrl.toString());
    return super.toString();
  }
}
