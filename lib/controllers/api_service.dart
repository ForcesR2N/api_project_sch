import 'dart:convert';
import 'package:api_project/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String? _sessionToken;
  
  static String? get sessionToken => _sessionToken;
  
  static void setSessionToken(String? token) {
    _sessionToken = token;
  }
  
  static void clearSession() {
    _sessionToken = null;
  }

  Future<List<Team>> fetchPosts() async {
    final uri = Uri.https(
        'www.thesportsdb.com', '/api/v1/json/3/search_all_teams.php', {
      'l': 'English Premier League',
    });

    final headers = _sessionToken != null 
        ? {'Authorization': 'Bearer $_sessionToken'} 
        : null;

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List data = jsonData['teams'];
      return data.map((json) => Team.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      clearSession();
      throw Exception('Session expired - Please login again');
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://mediadwi.com/api/latihan/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == true && responseData['token'] != null) {
        setSessionToken(responseData['token']);
      }
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String fullName,
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('https://mediadwi.com/api/latihan/register-user'),
      body: {
        'username': username,
        'password': password,
        'full_name': fullName,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }
}