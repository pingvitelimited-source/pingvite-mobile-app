import 'package:pingvite/features/payment_success/domain/entities/transaction_details.dart';

class TransactionDetailsModel extends TransactionDetails {
  TransactionDetailsModel({
    required super.transactionId,
    required super.eventTitle,
    required super.eventLocation,
    required super.eventDateTime,
    required super.tickets,
    required super.gst,
    required super.total,
  });

  factory TransactionDetailsModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailsModel(
      transactionId: json['transactionId'] ?? '',
      eventTitle: json['eventTitle'] ?? '',
      eventLocation: json['eventLocation'] ?? '',
      eventDateTime: json['eventDateTime'] ?? '',
      tickets:
          (json['tickets'] as List<dynamic>?)
              ?.map((ticket) => TicketDetailModel.fromJson(ticket))
              .toList() ??
          [],
      gst: json['gst'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'eventTitle': eventTitle,
      'eventLocation': eventLocation,
      'eventDateTime': eventDateTime,
      'tickets': tickets.map((t) => (t as TicketDetailModel).toJson()).toList(),
      'gst': gst,
      'total': total,
    };
  }

  // Dummy data for testing
  static TransactionDetailsModel getDummyData() {
    return TransactionDetailsModel(
      transactionId: 'AF1533FMC261220256',
      eventTitle: 'Fintech Masterclass Workshop',
      eventLocation: 'Jio World Convention Center',
      eventDateTime: '02 OCT, 02:00 PM',
      tickets: [
        TicketDetailModel(
          ticketName: 'Visitor Day Pass',
          location: 'Jio World Convention Center',
          dateTime: '02 OCT, 02:00 PM',
          quantity: 2,
          price: 200,
        ),
        TicketDetailModel(
          ticketName: 'Delegate Day Pass',
          location: 'Jio World Convention Center',
          dateTime: '02 OCT, 02:00 PM',
          quantity: 1,
          price: 500,
        ),
      ],
      gst: 35,
      total: 735,
    );
  }
}

class TicketDetailModel extends TicketDetail {
  TicketDetailModel({
    required super.ticketName,
    required super.location,
    required super.dateTime,
    required super.quantity,
    required super.price,
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) {
    return TicketDetailModel(
      ticketName: json['ticketName'] ?? '',
      location: json['location'] ?? '',
      dateTime: json['dateTime'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketName': ticketName,
      'location': location,
      'dateTime': dateTime,
      'quantity': quantity,
      'price': price,
    };
  }
}
