import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';

class LocationSuggestionModel extends LocationSuggestion {
  const LocationSuggestionModel({
    required super.id,
    required super.name,
    required super.type,
    super.code,
  });

  factory LocationSuggestionModel.fromJson(Map<String, dynamic> json) {
    return LocationSuggestionModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'type': type, 'code': code};
  }
}
