import 'package:fhotel_1/data/models/reservation.dart';

class Feedbacks {
  String? feedbackId;
  String? reservationId;
  int? hotelRating;
  String? comment;
  String? createdDate;
  Reservation? reservation;

  Feedbacks(
      {this.feedbackId,
        this.reservationId,
        this.hotelRating,
        this.comment,
        this.createdDate,
      this.reservation});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    feedbackId = json['feedbackId'];
    reservationId = json['reservationId'];
    hotelRating = json['hotelRating'];
    comment = json['comment'];
    createdDate = json['createdDate'];
    reservation = json['reservation'] != null ? Reservation.fromJson(json['reservation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedbackId'] = this.feedbackId;
    data['reservationId'] = this.reservationId;
    data['hotelRating'] = this.hotelRating;
    data['comment'] = this.comment;
    data['createdDate'] = this.createdDate;
    if (reservation != null) {
      data['reservation'] = reservation!.toJson();
    }
    return data;
  }
}
