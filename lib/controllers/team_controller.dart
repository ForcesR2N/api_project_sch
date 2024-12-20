import 'package:api_project/controllers/api_service.dart';
import 'package:api_project/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = true.obs;
  var teamList = <Team>[].obs;

  @override
  void onInit() {
    fetchTeams();
    super.onInit();
  }

  Future<void> fetchTeams() async {
    try {
      isLoading(true);
      var teams = await _apiService.fetchPosts(); 
      teamList.assignAll(teams);
    } catch (e) {
      print('Error fetching teams: $e');
      Get.snackbar(
        'Error',
        'Failed to load teams',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isLoading(false);
    }
  }
}