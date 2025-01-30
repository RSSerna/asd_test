import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Cast extends Equatable {
  const Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int? order;
  final String? department;
  final String? job;

  get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  @override
  List<Object?> get props {
    return [
      adult,
      gender,
      id,
      knownForDepartment,
      name,
      originalName,
      popularity,
      profilePath,
      castId,
      character,
      creditId,
      order,
      department,
      job,
    ];
  }

  Cast copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    ValueGetter<String?>? profilePath,
    ValueGetter<int?>? castId,
    ValueGetter<String?>? character,
    String? creditId,
    ValueGetter<int?>? order,
    ValueGetter<String?>? department,
    ValueGetter<String?>? job,
  }) {
    return Cast(
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath != null ? profilePath() : this.profilePath,
      castId: castId != null ? castId() : this.castId,
      character: character != null ? character() : this.character,
      creditId: creditId ?? this.creditId,
      order: order != null ? order() : this.order,
      department: department != null ? department() : this.department,
      job: job != null ? job() : this.job,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'gender': gender,
      'id': id,
      'knownForDepartment': knownForDepartment,
      'name': name,
      'originalName': originalName,
      'popularity': popularity,
      'profilePath': profilePath,
      'castId': castId,
      'character': character,
      'creditId': creditId,
      'order': order,
      'department': department,
      'job': job,
    };
  }

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      adult: map['adult'] ?? false,
      gender: map['gender']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      knownForDepartment: map['knownForDepartment'] ?? '',
      name: map['name'] ?? '',
      originalName: map['originalName'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      profilePath: map['profilePath'],
      castId: map['castId']?.toInt(),
      character: map['character'],
      creditId: map['creditId'] ?? '',
      order: map['order']?.toInt(),
      department: map['department'],
      job: map['job'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cast.fromJson(String source) => Cast.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cast(adult: $adult, gender: $gender, id: $id, knownForDepartment: $knownForDepartment, name: $name, originalName: $originalName, popularity: $popularity, profilePath: $profilePath, castId: $castId, character: $character, creditId: $creditId, order: $order, department: $department, job: $job)';
  }
}
