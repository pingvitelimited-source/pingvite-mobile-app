import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/features/payment_success/data/models/transaction_details_model.dart';
import 'package:pingvite/features/payment_success/presentation/bloc/payment_event.dart';
import 'package:pingvite/features/payment_success/presentation/bloc/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<ProcessPaymentEvent>(_onProcessPayment);
  }

  Future<void> _onProcessPayment(
    ProcessPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentProcessing());

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // For now, use dummy data
      final transactionDetails = TransactionDetailsModel.getDummyData();

      emit(PaymentSuccess(transactionDetails: transactionDetails));
    } catch (e) {
      emit(PaymentFailure(error: e.toString()));
    }
  }
}
