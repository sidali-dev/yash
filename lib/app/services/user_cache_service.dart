import 'dart:convert';
import 'dart:typed_data';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yash/app/model/google_user_model.dart';

class UserCacheService {
  final GetStorage _box = GetStorage();

  /// Cache key names
  static const String _profileKey = 'google_user';

  /// Get cached user profile
  Future<UserModel?> getUserProfile(String userId) async {
    final user = _box.read<Map<String, dynamic>>("$_profileKey-$userId");
    if (user != null) {
      return UserModel.fromJson(user);
    }
    return null;
  }

  /// Save user profile to cache
  Future<void> setUserProfile(UserModel profile) async {
    await _box.write("$_profileKey-${profile.id}", profile.toJson());
  }

  /// Clear cached profile (and avatar)
  Future<void> clearUserProfile(String pictureUrl) async {
    await _box.remove(_profileKey);
    await _box.remove(pictureUrl);
  }

  /// Get avatar bytes from cache or download + cache if missing
  Future<Uint8List?> getUserAvatar(String pictureUrl) async {
    // 1. Check local cache
    final cachedBase64 = _box.read<String>(pictureUrl);
    if (cachedBase64 != null) {
      return base64Decode(cachedBase64);
    }

    // 2. Download from Google if not cached
    try {
      final res = await http.get(Uri.parse(pictureUrl));
      if (res.statusCode == 200) {
        final bytes = res.bodyBytes;
        await setUserAvatar(bytes, pictureUrl);
        return bytes;
      }
    } catch (e) {
      throw Exception("Failed to download avatar: $e");
    }

    return null;
  }

  /// Save avatar to local cache
  Future<void> setUserAvatar(Uint8List bytes, String pictureUrl) async {
    await _box.write(pictureUrl, base64Encode(bytes));
  }

  /// Save avatar from a Google picture URL
  Future<void> setAvatarFromUrl(String pictureUrl) async {
    final res = await http.get(Uri.parse(pictureUrl));
    if (res.statusCode == 200) {
      final bytes = res.bodyBytes;
      await _box.write(pictureUrl, base64Encode(bytes));
    } else {
      throw Exception("Failed to download avatar: ${res.statusCode}");
    }
  }
}
