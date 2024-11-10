import 'package:api_project/controllers/team_controller.dart';
import 'package:api_project/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostView extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX API Example'),
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: postController.postList.length,
          itemBuilder: (context, index) {
            final post = postController.postList[index];
            return GestureDetector(
              onTap: () {
                try {
                  if (post.strBadge.isNotEmpty &&
                      post.strDescriptionEN.isNotEmpty) {
                    Get.to(() => DetailPage(post: post));
                  } else {
                    Get.snackbar(
                      'Error',
                      'Data tidak lengkap',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                } catch (e) {
                  print('Error navigating: $e');
                  Get.snackbar(
                    'Error',
                    'Terjadi kesalahan',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Card(
                child: ListTile(
                  leading: Hero(
                    tag: 'team-${post.strTeam}',
                    child: post.strBadge.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(post.strBadge,
                                width: 50, height: 50, fit: BoxFit.cover),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.sports_football_outlined),
                          ),
                  ),
                  title: Text(post.strTeam),
                  subtitle: Text(post.strStadium),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
