import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:yash/app/services/appwrite_service.dart';
import 'package:yash/generated/l10n.dart';

class HelperFunctions {
  static final _box = GetStorage();
  static final AppwriteService _appwriteService = AppwriteService();

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Future<Uint8List?> getImage({
    required BuildContext context,
    required String imageId,
    required String title,
  }) async {
    // check cache first
    final cachedBase64 = _box.read<String>(imageId);
    if (cachedBase64 != null) {
      final bytes = base64Decode(cachedBase64);
      return bytes;
    }

    // placeholder for fetching from Appwrite (replace with real fetch)
    final Uint8List? fetchedImage = await _appwriteService.getBookCover(
      imageId,
    );

    if (fetchedImage == null) {
      if (context.mounted) {
        S s = S.of(context);
        Get.snackbar(
          s.error,
          "${s.cant_find_cover_for} $title",
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      } else {
        return null;
      }
    }

    // save to cache
    _box.write(imageId, base64Encode(fetchedImage));

    return fetchedImage;
  }

  static Uint8List? getImageFromCache({
    required String imageId,
    required String title,
  }) {
    // check cache first
    final cachedBase64 = _box.read<String>(imageId);
    if (cachedBase64 != null) {
      final bytes = base64Decode(cachedBase64);
      return bytes;
    }
    return null;
  }

  static bool isRtl() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
