import 'package:api_project/api_service.dart';
import 'package:api_project/post_model.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <Team>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await ApiService().fetchPosts();
      postList.assignAll(posts);
    } finally {
      isLoading(false);
    }
  }
}
