import 'package:equatable/equatable.dart';

class LocationSuggestion extends Equatable {
  final String id;
  final String name;
  final String type; // 'country', 'state', 'city'

  const LocationSuggestion({
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, type];
}
