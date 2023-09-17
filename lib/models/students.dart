class Students {
 late int? id;
 late String fullName;
 late String email;
 late String gender;
 late Null? verificationCode;
 late Null? fcmToken;
 late String password ;
 late String token;
 late String refreshToken;
 late bool isActive;

  Students();

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    verificationCode = json['verification_code'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    refreshToken = json['refresh_token'];
    isActive = json['is_active'];
  }

}