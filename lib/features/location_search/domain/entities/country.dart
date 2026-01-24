import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String id;
  final String name;
  final String code;
  final String dialingCode;

  const Country({
    required this.id,
    required this.name,
    required this.code,
    required this.dialingCode,
  });

  @override
  List<Object?> get props => [id, name, code, dialingCode];
}
