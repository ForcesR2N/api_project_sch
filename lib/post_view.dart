import 'package:api_project/description_page.dart';
import 'package:api_project/post_controller.dart';
import 'package:api_project/post_model.dart';
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
            GestureDetector(
              onTap: () {
                try {
                  if (post.strBadge.isNotEmpty &&
                      post.strDescriptionEN.isNotEmpty) {
                    Get.to(() => DescriptionPage(post: post));
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
