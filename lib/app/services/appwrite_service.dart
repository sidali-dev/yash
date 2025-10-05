import 'dart:convert';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yash/app/const/enums.dart';
import 'package:http/http.dart' as http;
import 'package:yash/app/model/google_user_model.dart';

class AppwriteService {
  // Singleton pattern
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;

  // Private constructor
  AppwriteService._internal() {
    client
        .setEndpoint(dotenv.get("APPWRITE_ENDPOINT"))
        .setProject(dotenv.get("APPWRITE_PROJECT"))
        .setSelfSigned(status: true);

    _account = Account(client);
    _tablesDB = TablesDB(client);
    _storage = Storage(client);
    _function = Functions(client);
    loadUser();
  }

  Client client = Client();
  late final Account _account;
  late final TablesDB _tablesDB;
  late final Storage _storage;
  late final Functions _function;
  User? _currentUser;
  AuthStatus _status = AuthStatus.uninitialized;

  User? get currentUser => _currentUser;
  AuthStatus get authStatus => _status;

  // this is to establish a first connection with appwrite
  // keep it so you can use it in future projects directly.
  // Future ping() async {
  //   final response = await client.ping();
  //   print(response);
  // }

  Future<void> loadUser() async {
    try {
      final user = await _account.get();
      if (user.emailVerification) {
        _status = AuthStatus.emailVerified;
        _currentUser = user;
      } else {
        _status = AuthStatus.authenticated;
        _currentUser = user;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _currentUser = null;
    }
  }

  Future<String> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return user.$id;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      _currentUser = await _account.get();

      //Should add a step to check if the user is email verified
      _status = AuthStatus.authenticated;
      return session.userId;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> loginWithGoogle() async {
    try {
      await _account.createOAuth2Session(provider: OAuthProvider.google);

      await Future.delayed(Duration(milliseconds: 100));

      // After the session is created, fetch the user
      final user = await _account.get();
      _currentUser = user;

      _status = AuthStatus.emailVerified;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches the current Google user profile (name, email, avatar, etc.)
  Future<UserModel> getGoogleUserProfile() async {
    final googleSession = await _account.getSession(sessionId: "current");

    final accessToken = googleSession.providerAccessToken;

    final res = await http.get(
      Uri.parse("https://www.googleapis.com/oauth2/v2/userinfo"),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception("Failed to fetch Google user profile: ${res.body}");
    }
  }

  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      _currentUser = null;
      _status = AuthStatus.unauthenticated;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      _currentUser = await _account.get();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<RowList?> getAllBooks() async {
    try {
      final userPersonalInfo = await _tablesDB.listRows(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        tableId: dotenv.get("APPWRITE_DB_STORE"),
        queries: [
          Query.select(["*", "author.*", "category.*"]),
        ],
      );

      return userPersonalInfo;
    } catch (e) {
      return null;
    }
  }

  Future<RowList?> getBooks({
    int? limit,
    int? offset,
    String? categoryId,
  }) async {
    try {
      final queries = <String>[
        Query.select(["*", "author.*", "category.*"]),
        Query.orderDesc("\$createdAt"),
      ];

      if (categoryId != null) {
        queries.add(Query.equal("category", categoryId));
      }

      if (offset != null) {
        queries.add(Query.offset(offset));
      }

      if (limit != null) {
        queries.add(Query.limit(limit));
      }

      final books = await _tablesDB.listRows(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        tableId: dotenv.get("APPWRITE_DB_STORE"),
        queries: queries,
      );

      return books;
    } catch (e) {
      return null;
    }
  }

  Future<RowList?> getCategories() async {
    try {
      final books = await _tablesDB.listRows(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        tableId: dotenv.get("APPWRITE_DB_CATEGORIES"),
      );

      return books;
    } catch (e) {
      return null;
    }
  }

  Future<Row?> getUserLibrary() async {
    try {
      final result = await _tablesDB.getRow(
        databaseId: dotenv.get("APPWRITE_DB_ID"),
        tableId: dotenv.get("APPWRITE_DB_USER_LIBRARY"),
        rowId: _currentUser!.$id,
        queries: [
          Query.select(["*", "books.*", "books.author.*", "books.category.*"]),
        ],
      );

      return result;
    } catch (e) {
      return null;
    }
  }

  //-------------------------STORAGE-------------------------
  Future<Uint8List?> getBookCover(String id) async {
    try {
      final result = await _storage.getFileDownload(
        bucketId: dotenv.get("APPWRITE_BUCKET_BOOKS_COVERS"),
        fileId: id,
      );
      return result;
    } catch (e) {
      return null;
    }
  }

  //-------------------------FUNCTION-------------------------
  Future<Execution?> createUserLibrary() async {
    try {
      final Execution result = await _function.createExecution(
        functionId: dotenv.get("APPWRITE_FUNCTION_CREATE_USER_LIBRARY"),
      );

      if (result.responseBody == "USER_EXISTS") {
        return null;
      }

      return result;
    } catch (e) {
      return null;
    }
  }

  Future<Execution?> createChargilyInvoice(
    List<String> library,
    List<String> booksId,
    int total,
  ) async {
    try {
      final Execution result = await _function.createExecution(
        functionId: dotenv.get("APPWRITE_FUNCTION_CREATE_CHARGILY_INVOICE"),
        body: jsonEncode({
          "total": total,
          "library": library,
          "books": booksId,
        }),
      );

      return result;
    } catch (e) {
      return null;
    }
  }

  Future<Execution?> getBook(String bookId, String fileId) async {
    try {
      // create user-scoped JWT and await it
      final jwt = await _account.createJWT();

      final result = await _function.createExecution(
        functionId: dotenv.get("APPWRITE_FUNCTION_GET_BOOK"),
        body: jsonEncode({
          "book_id": bookId,
          "file_id": fileId,
          'jwt': jwt.jwt,
        }),
      );

      return result;
    } catch (e) {
      return null;
    }
  }
}
