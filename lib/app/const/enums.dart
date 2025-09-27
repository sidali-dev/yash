import 'package:yash/app/const/images.dart';

enum AuthStatus { uninitialized, unauthenticated, authenticated, emailVerified }

enum Language { en, fr, ar }

extension LanguageExtension on Language {
  String get displayName {
    switch (this) {
      case Language.en:
        return 'English';
      case Language.fr:
        return 'Francais';
      case Language.ar:
        return 'العربية';
    }
  }

  String get flag {
    switch (this) {
      case Language.en:
        return Images.uk;
      case Language.fr:
        return Images.france;
      case Language.ar:
        return Images.algeria;
    }
  }
}
