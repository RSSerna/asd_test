import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_entity.dart';

class PopularResponse extends Equatable {
  const PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieEntity> results;
  final int totalPages;
  final int totalResults;

  @override
  List<Object> get props => [page, results, totalPages, totalResults];

  PopularResponse copyWith({
    int? page,
    List<MovieEntity>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return PopularResponse(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'results': results.map((x) => x.toMap()).toList(),
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }

  factory PopularResponse.fromMap(Map<String, dynamic> map) {
    return PopularResponse(
      page: map['page']?.toInt() ?? 0,
      results: List<MovieEntity>.from(
          map['results']?.map((x) => MovieEntity.fromMap(x))),
      totalPages: map['totalPages']?.toInt() ?? 0,
      totalResults: map['totalResults']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularResponse.fromJson(String source) =>
      PopularResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PopularResponse(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }
}
