import 'package:pingvite/features/location_search/domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.id,
    required super.name,
    required super.code,
    required super.dialingCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      dialingCode: json['dialing_code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code, 'dialing_code': dialingCode};
  }
}
