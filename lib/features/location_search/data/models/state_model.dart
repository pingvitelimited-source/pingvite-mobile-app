import 'package:pingvite/features/location_search/domain/entities/state.dart';

class StateModel extends State {
  const StateModel({
    required super.id,
    required super.name,
    required super.code,
    required super.countryCode,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      countryCode: json['country_code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code, 'country_code': countryCode};
  }
}
