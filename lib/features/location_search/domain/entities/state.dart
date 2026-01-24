import 'package:equatable/equatable.dart';

class State extends Equatable {
  final String id;
  final String name;
  final String code;
  final String countryCode;

  const State({
    required this.id,
    required this.name,
    required this.code,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [id, name, code, countryCode];
}
