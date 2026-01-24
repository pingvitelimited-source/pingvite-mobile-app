import 'package:equatable/equatable.dart';
import 'package:pingvite/features/payment_success/domain/entities/transaction_details.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final TransactionDetails transactionDetails;

  const PaymentSuccess({required this.transactionDetails});

  @override
  List<Object?> get props => [transactionDetails];
}

class PaymentFailure extends PaymentState {
  final String error;

  const PaymentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
