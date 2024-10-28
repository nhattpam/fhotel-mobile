import 'package:fhotel_1/data/models/order.dart';

class OrderDetail {
  String? orderDetailId;
  String? orderId;
  String? serviceId;
  String? roomFacilityId;
  int? quantity;
  Order? order;

  OrderDetail(
      {this.orderDetailId,
        this.orderId,
        this.serviceId,
        this.roomFacilityId,
        this.quantity,
      this.order});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['orderDetailId'];
    orderId = json['orderId'];
    serviceId = json['serviceId'];
    roomFacilityId = json['roomFacilityId'];
    quantity = json['quantity'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['orderDetailId'] = orderDetailId;
    data['orderId'] = orderId;
    data['serviceId'] = serviceId;
    data['roomFacilityId'] = roomFacilityId;
    data['quantity'] = quantity;
    if (order != null) {
      data['order'] = order!.toJson();
    }

    return data;
  }
}
