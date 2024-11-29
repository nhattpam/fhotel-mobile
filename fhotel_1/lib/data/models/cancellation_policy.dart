class CancellationPolicy {
  String? hotelId;
  int? refundPercentage;
  int? cancellationDays;
  CancellationTime? cancellationTime;
  String? createdDate;
  String? updatedDate;

  CancellationPolicy(
      {this.hotelId,
        this.refundPercentage,
        this.cancellationDays,
        this.cancellationTime,
        this.createdDate,
        this.updatedDate});

  CancellationPolicy.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotelId'];
    refundPercentage = json['refundPercentage'];
    cancellationDays = json['cancellationDays'];
    cancellationTime = json['cancellationTime'] != null
        ? new CancellationTime.fromJson(json['cancellationTime'])
        : null;
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotelId'] = this.hotelId;
    data['refundPercentage'] = this.refundPercentage;
    data['cancellationDays'] = this.cancellationDays;
    if (this.cancellationTime != null) {
      data['cancellationTime'] = this.cancellationTime!.toJson();
    }
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}

class CancellationTime {
  int? ticks;
  int? days;
  int? hours;
  int? milliseconds;
  int? minutes;
  int? seconds;

  CancellationTime(
      {this.ticks,
        this.days,
        this.hours,
        this.milliseconds,
        this.minutes,
        this.seconds});

  CancellationTime.fromJson(Map<String, dynamic> json) {
    ticks = json['ticks'];
    days = json['days'];
    hours = json['hours'];
    milliseconds = json['milliseconds'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticks'] = this.ticks;
    data['days'] = this.days;
    data['hours'] = this.hours;
    data['milliseconds'] = this.milliseconds;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}
