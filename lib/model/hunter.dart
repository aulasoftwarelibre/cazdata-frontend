class Hunter {
  String id;
  String email;
  String displayName;
  String photoUrl;
  bool isEmailVerified;

  Hunter(
      {this.id, this.email, this.displayName, this.photoUrl,this.isEmailVerified});

  Map toJson() {
    return {
      'id': this.id,
      'email': this.email,
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'isEmailVerified': this.isEmailVerified,
    };
  }


  factory Hunter.fromJson(Map<String, dynamic> json) {
    return new Hunter(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      isEmailVerified: json['isEmailVerified'],
    );
  }
}
