import 'package:api_project/component/my_colors.dart';
import 'package:api_project/controllers/team_controller.dart';
import 'package:api_project/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final TeamController teamController = Get.put(TeamController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: const Text(
          'Premier League Teams',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => teamController.fetchTeams(),
          ),
        ],
      ),
      body: Obx(
        () {
          if (teamController.isLoading.value) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading teams...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => teamController.fetchTeams(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: teamController.teamList.length,
              itemBuilder: (context, index) {
                final team = teamController.teamList[index];
                return Card(
                  color: AppColor.primaryBlue,
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      try {
                        if (team.strBadge.isNotEmpty &&
                            team.strDescriptionEN.isNotEmpty) {
                          Get.to(
                            () => DetailPage(
                              post: team,
                              team: null,
                            ),
                            transition: Transition.rightToLeft,
                          );
                        } else {
                          Get.snackbar(
                            'Error',
                            'Team data incomplete',
                            backgroundColor: Colors.red[100],
                            colorText: Colors.red[900],
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 8,
                          );
                        }
                      } catch (e) {
                        print('Error navigating: $e');
                        Get.snackbar(
                          'Error',
                          'An error occurred',
                          backgroundColor: Colors.red[100],
                          colorText: Colors.red[900],
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 8,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'team-${team.strTeam}',
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColor.primaryBlue,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: team.strBadge.isNotEmpty
                                    ? ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          AppColor.primaryBlue,
                                          BlendMode.dstATop,
                                        ),
                                        child: Image.network(
                                          team.strBadge,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                            Icons.sports_soccer,
                                            size: 30,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.sports_soccer,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  team.strTeam,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.stadium,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        team.strStadium,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
