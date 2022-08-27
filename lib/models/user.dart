class User {
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;

  User(this.displayName, this.email, this.id, this.photoUrl) {
    photoUrl ??=
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREgQfgTOLnvNfd2u93zEUpsfW3z3AG1rcWJA&usqp=CAU";
  }

  Map<String, dynamic> toJson() => {
        'code': id,
        'email': email,
        'nickname': displayName,
        'photo_url': photoUrl
      };

  @override
  String toString() {
    var result = """displayName : ${displayName.toString()}
email : ${email.toString()}
id : ${id.toString()}
photoUrl : ${photoUrl.toString()}""";
    return result;
  }
}
