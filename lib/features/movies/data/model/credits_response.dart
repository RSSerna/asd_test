import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/cast_entity.dart';

class CreditsResponse extends Equatable {
  const CreditsResponse({
    required this.id,
    required this.cast,
  });

  final int id;
  final List<Cast> cast;

  @override
  List<Object> get props => [id, cast];

  CreditsResponse copyWith({
    int? id,
    List<Cast>? cast,
  }) {
    return CreditsResponse(
      id: id ?? this.id,
      cast: cast ?? this.cast,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cast': cast.map((x) => x.toMap()).toList(),
    };
  }

  factory CreditsResponse.fromMap(Map<String, dynamic> map) {
    return CreditsResponse(
      id: map['id']?.toInt() ?? 0,
      cast: List<Cast>.from(map['cast']?.map((x) => Cast.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditsResponse.fromJson(String source) =>
      CreditsResponse.fromMap(json.decode(source));

  @override
  String toString() => 'CreditsResponse(id: $id, cast: $cast)';
}
