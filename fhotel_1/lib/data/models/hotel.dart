class Hotel {
  String? hotelId;
  String? hotelName;
  String? address;
  String? phone;
  String? email;
  String? description;
  String? districtId;
  int? star;
  String? cityId;
  String? ownerId;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  City? city;
  Owner? owner;

  Hotel(
      {this.hotelId,
        this.hotelName,
        this.address,
        this.phone,
        this.email,
        this.description,
        this.districtId,
        this.star,
        this.cityId,
        this.ownerId,
        this.createdDate,
        this.updatedDate,
        this.isActive,
        this.city,
        this.owner});

  Hotel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotelId'];
    hotelName = json['hotelName'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    description = json['description'];
    districtId = json['districtId'];
    star = json['star'];
    cityId = json['cityId'];
    ownerId = json['ownerId'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    isActive = json['isActive'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hotelId'] = hotelId;
    data['hotelName'] = hotelName;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['description'] = description;
    data['districtId'] = districtId;
    data['star'] = star;
    data['cityId'] = cityId;
    data['ownerId'] = ownerId;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['isActive'] = isActive;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}

class City {
  String? cityId;
  String? cityName;
  String? postalCode;
  String? countryId;
  Country? country;

  City(
      {this.cityId,
        this.cityName,
        this.postalCode,
        this.countryId,
        this.country});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    cityName = json['cityName'];
    postalCode = json['postalCode'];
    countryId = json['countryId'];
    country =
    json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['postalCode'] = postalCode;
    data['countryId'] = countryId;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }
}

class Country {
  String? countryId;
  String? countryName;

  Country({this.countryId, this.countryName});

  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    return data;
  }
}

class Owner {
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

  Owner(
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

  Owner.fromJson(Map<String, dynamic> json) {
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
