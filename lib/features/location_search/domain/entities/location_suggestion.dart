import 'package:equatable/equatable.dart';

class LocationSuggestion extends Equatable {
  final String id;
  final String name;
  final String type; // 'country', 'state', 'city'
  final String? code; // country code (e.g., 'IN', 'US') or state code

  const LocationSuggestion({
    required this.id,
    required this.name,
    required this.type,
    this.code,
  });

  @override
  List<Object?> get props => [id, name, type, code];
}
