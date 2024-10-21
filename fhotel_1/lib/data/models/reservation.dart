class Reservation {
  String? customerId;
  String? checkInDate;
  String? checkOutDate;
  double? totalAmount;
  String? reservationStatus;
  String? roomTypeId;
  int? numberOfRooms;
  String? createdDate;
  String? actualCheckInTime;
  String? actualCheckOutDate;

  Reservation(
      {this.customerId,
        this.checkInDate,
        this.checkOutDate,
        this.totalAmount,
        this.reservationStatus,
        this.roomTypeId,
        this.numberOfRooms,
        this.createdDate,
        this.actualCheckInTime,
        this.actualCheckOutDate});

  Reservation.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    totalAmount = json['totalAmount'];
    reservationStatus = json['reservationStatus'];
    roomTypeId = json['roomTypeId'];
    numberOfRooms = json['numberOfRooms'];
    createdDate = json['createdDate'];
    actualCheckInTime = json['actualCheckInTime'];
    actualCheckOutDate = json['actualCheckOutDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['customerId'] = customerId;
    data['checkInDate'] = checkInDate;
    data['checkOutDate'] = checkOutDate;
    data['totalAmount'] = totalAmount;
    data['reservationStatus'] = reservationStatus;
    data['roomTypeId'] = roomTypeId;
    data['numberOfRooms'] = numberOfRooms;
    data['createdDate'] = createdDate;
    data['actualCheckInTime'] = actualCheckInTime;
    data['actualCheckOutDate'] = actualCheckOutDate;
    return data;
  }
}
