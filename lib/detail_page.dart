import 'package:api_project/component/my_colors.dart';
import 'package:api_project/models/post_model.dart';
import 'package:api_project/widgets/expandable_description.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Team post;
  const DetailPage({super.key, required this.post, required team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Detail",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.strBadge.isNotEmpty)
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColor.backgroundColor,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: AppColor.backgroundColor,
                    ),
                    Hero(
                      tag: 'team-${post.strTeam}',
                      child: Container(
                        width: 200,
                        height: 200,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            AppColor.backgroundColor,
                            BlendMode.dstATop,
                          ),
                          child: Image.network(
                            post.strBadge,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.strTeam,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (post.strStadium.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stadium, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Stadium: ${post.strStadium}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  if (post.strDescriptionEN.isNotEmpty)
                    ExpandableDescription(description: post.strDescriptionEN),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
