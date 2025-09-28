import 'dart:convert';

import 'package:hero_app/data/model/superhero_respose.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<SuperheroRespose?> fetchSuperheroes(String name) async {
    final response = await http.get(Uri.parse('https://www.superheroapi.com/api.php/3b54fc5ff1429bcdaf4db2ad6a2249f8/search/$name'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return SuperheroRespose.fromJson(json);
    } else {
      return null;
    }
  }
}