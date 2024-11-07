import 'dart:convert';
import 'package:api_project/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Team>> fetchPosts() async {
    final uri = Uri.https('www.thesportsdb.com', '/api/v1/json/3/search_all_teams.php', {
      'l': 'English Premier League',
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List data = jsonData['teams']; 
      return data.map((json) => Team.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
