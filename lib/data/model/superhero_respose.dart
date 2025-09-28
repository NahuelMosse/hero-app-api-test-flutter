import 'package:hero_app/data/model/superhero_detail_response.dart';

class SuperheroRespose {
  final String response;
  final List<SuperheroDetailResponse> results;

  SuperheroRespose({required this.response, required this.results});

  factory SuperheroRespose.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List? ?? [];
    List<SuperheroDetailResponse> resultsList = list.map((i) => SuperheroDetailResponse.fromJson(i)).toList();

    return SuperheroRespose(
      response: json['response'],
      results: resultsList,
    );
  }
}