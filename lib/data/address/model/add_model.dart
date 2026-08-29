import 'dart:convert';

import 'package:kauto/domain/address/address.dart';

class AddModel extends Address {
  AddModel({
    required super.name,
    required super.phone,
    required super.add1,
    required super.add2,
    required super.city,
    required super.state,
    required super.pincode,
  });
  AddModel copyWith({
    String? name,
    String? phone,
    String? add1,
    String? add2,
    String? city,
    String? state,
    String? pincode,
  }) {
    return AddModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      add1: add1 ?? this.add1,
      add2: add2 ?? this.add2,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'add1': add1,
      'add2': add2,
      'city': city,
      'state': state,
      'pincode': pincode,
    };
  }

  factory AddModel.fromMap(Map<String, dynamic> map) {
    return AddModel(
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      add1: map['address1'] as String? ?? '',
      city: map['city'] as String? ?? '',
      state: map['state'] as String? ?? '',
      pincode: map['pincode'] as String? ?? '',
      add2: map['address2'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddModel.fromJson(String source) =>
      AddModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(name: $name, phone: $phone, add1: $add1, add2: $add2, city: $city, state: $state, pincode: $pincode)';
  }

  @override
  bool operator ==(covariant AddModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.add1 == add1 &&
        other.add2 == add2 &&
        other.city == city &&
        other.state == state &&
        other.pincode == pincode;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        add1.hashCode ^
        add2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        pincode.hashCode;
  }
}
