import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class ProcessPaymentEvent extends PaymentEvent {
  final int amount;
  final String eventTitle;

  const ProcessPaymentEvent({required this.amount, required this.eventTitle});

  @override
  List<Object?> get props => [amount, eventTitle];
}
