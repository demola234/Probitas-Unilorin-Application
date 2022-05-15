import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/remote/posts/post_service.dart';
import '../../../../injection_container.dart';

class PostNotifier extends StateNotifier {
  var postService = getIt<PostService>();
  var cache = getIt<Cache>();
  bool? loading;
  PostNotifier(this.postService, loading) : super(loading);

  Future<void> createPost(String text, List<File>? images) async {
    loading = true;
    try {
      await postService.createPost(text: text, images: images);
      NavigationService().goBack();
      Toasts.showSuccessToast("Post Have been uploaded successfully");
      print(loading);
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }
}
