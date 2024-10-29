import 'package:fhotel_1/data/models/facility.dart';

class RoomFacility {
  String? roomFacilityId;
  String? roomTypeId;
  String? facilityId;
  Facility? facility;

  RoomFacility({this.roomFacilityId, this.roomTypeId, this.facilityId, this.facility});

  RoomFacility.fromJson(Map<String, dynamic> json) {
    roomFacilityId = json['roomFacilityId'];
    roomTypeId = json['roomTypeId'];
    facilityId = json['facilityId'];
    facility = json['facility'] != null ? Facility.fromJson(json['facility']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['roomFacilityId'] = roomFacilityId;
    data['roomTypeId'] = roomTypeId;
    data['facilityId'] = facilityId;
    data['facility'] = facility;
    return data;
  }
}
