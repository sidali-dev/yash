import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:yash/app/model/user_library_model.dart';
import 'package:yash/app/services/appwrite_service.dart';

class UserLibraryRepository {
  static final UserLibraryRepository _instance =
      UserLibraryRepository._internal();

  factory UserLibraryRepository() => _instance;

  UserLibraryRepository._internal();

  final GetStorage _box = GetStorage();
  final AppwriteService appwriteService = AppwriteService();

  /// Load from cache if available, else fetch from Appwrite
  Future<UserLibraryModel?> loadLibrary({required String userId}) async {
    final cached = _box.read<String>("library_$userId");
    if (cached != null) {
      final Map<String, dynamic> json = jsonDecode(cached);
      return UserLibraryModel.fromJson(json);
    }

    // No cache, fetch from remote
    final row = await appwriteService.getUserLibrary();
    if (row == null) return null;

    final library = UserLibraryModel.fromJson(row.data);
    await saveToCache(library);
    return library;
  }

  /// fetch new library and cache it
  Future<UserLibraryModel?> updateLibrary({required String userId}) async {
    final row = await appwriteService.getUserLibrary();
    if (row == null) return null;

    final library = UserLibraryModel.fromJson(row.data);
    await saveToCache(library);
    return library;
  }

  /// Internal save to cache
  Future<void> saveToCache(UserLibraryModel library) async {
    final jsonString = jsonEncode(library.toJson());
    await _box.write("library_${library.userId}", jsonString);
  }
}
