class UserModel {
  String? cid;
  String? email;
  String? companyName;


  UserModel({this.cid, this.email, this.companyName,});

  //data from server
  factory UserModel.fromMap(map)
  {

    return UserModel(
        cid: map['cid'],
        email: map['email'],
        companyName: map['companyname'],

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'cid': cid,
      'email':email,

    };

  }

}