import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/models/service.dart';

class OrderDetail {
  String? orderDetailId;
  String? orderId;
  String? serviceId;
  String? roomFacilityId;
  double? price;
  int? quantity;
  Order? order;
  Services? services;

  OrderDetail(
      {this.orderDetailId,
        this.orderId,
        this.serviceId,
        this.price,
        this.roomFacilityId,
        this.quantity,
      this.order,
      this.services});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['orderDetailId'];
    orderId = json['orderId'];
    serviceId = json['serviceId'];
    roomFacilityId = json['roomFacilityId'];
    price = json['price'];
    quantity = json['quantity'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    services = json['service'] != null ? Services.fromJson(json['service']) : null; // Updated key
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['orderDetailId'] = orderDetailId;
    data['orderId'] = orderId;
    data['serviceId'] = serviceId;
    data['roomFacilityId'] = roomFacilityId;
    data['price'] = price;
    data['quantity'] = quantity;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (services != null) {
      data['services'] = services!.toJson();
    }

    return data;
  }
}
