class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? image;
  String? identificationNumber;
  String? phoneNumber;
  String? address;
  bool? sex;
  String? hotelId;
  String? roleId;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  Role? role;

  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.image,
      this.identificationNumber,
      this.phoneNumber,
      this.address,
      this.sex,
      this.hotelId,
      this.roleId,
      this.createdDate,
      this.updatedDate,
      this.isActive,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    identificationNumber = json['identificationNumber'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    sex = json['sex'];
    hotelId = json['hotelId'];
    roleId = json['roleId'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    isActive = json['isActive'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    data['identificationNumber'] = identificationNumber;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['sex'] = sex;
    data['hotelId'] = hotelId;
    data['roleId'] = roleId;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['isActive'] = isActive;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  String? roleId;
  String? roleName;

  Role({this.roleId, this.roleName});

  Role.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roleId'] = roleId;
    data['roleName'] = roleName;
    return data;
  }
}