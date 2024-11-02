class Feedbacks {
  String? feedbackId;
  String? reservationId;
  int? hotelRating;
  String? comment;
  String? createdDate;

  Feedbacks(
      {this.feedbackId,
        this.reservationId,
        this.hotelRating,
        this.comment,
        this.createdDate});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    feedbackId = json['feedbackId'];
    reservationId = json['reservationId'];
    hotelRating = json['hotelRating'];
    comment = json['comment'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedbackId'] = this.feedbackId;
    data['reservationId'] = this.reservationId;
    data['hotelRating'] = this.hotelRating;
    data['comment'] = this.comment;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
