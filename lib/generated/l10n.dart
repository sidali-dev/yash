// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Yash`
  String get yash {
    return Intl.message('Yash', name: 'yash', desc: '', args: []);
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message('Sign up', name: 'sign_up', desc: '', args: []);
  }

  /// `Welcome back`
  String get welcome_back {
    return Intl.message(
      'Welcome back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Sign up today and start\nbuilding your personal library.`
  String get sign_up_desc {
    return Intl.message(
      'Sign up today and start\nbuilding your personal library.',
      name: 'sign_up_desc',
      desc: '',
      args: [],
    );
  }

  /// `Sign in and continue your\nreading journey.`
  String get welcome_back_desc {
    return Intl.message(
      'Sign in and continue your\nreading journey.',
      name: 'welcome_back_desc',
      desc: '',
      args: [],
    );
  }

  /// `Continue with google`
  String get continue_with_google {
    return Intl.message(
      'Continue with google',
      name: 'continue_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message('Sign in', name: 'sign_in', desc: '', args: []);
  }

  /// `Book info`
  String get book_info {
    return Intl.message('Book info', name: 'book_info', desc: '', args: []);
  }

  /// `DZD`
  String get da {
    return Intl.message('DZD', name: 'da', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Start over`
  String get start_over {
    return Intl.message('Start over', name: 'start_over', desc: '', args: []);
  }

  /// `Go to cart`
  String get go_to_cart {
    return Intl.message('Go to cart', name: 'go_to_cart', desc: '', args: []);
  }

  /// `Add to cart`
  String get add_to_cart {
    return Intl.message('Add to cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `Continue Reading`
  String get continue_reading {
    return Intl.message(
      'Continue Reading',
      name: 'continue_reading',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buy_now {
    return Intl.message('Buy Now', name: 'buy_now', desc: '', args: []);
  }

  /// `pages`
  String get pages {
    return Intl.message('pages', name: 'pages', desc: '', args: []);
  }

  /// `My Bookshelf`
  String get my_bookshlef {
    return Intl.message(
      'My Bookshelf',
      name: 'my_bookshlef',
      desc: '',
      args: [],
    );
  }

  /// `You have`
  String get you_have {
    return Intl.message('You have', name: 'you_have', desc: '', args: []);
  }

  /// `books`
  String get books {
    return Intl.message('books', name: 'books', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Order Info`
  String get order_info {
    return Intl.message('Order Info', name: 'order_info', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Books found`
  String get books_found {
    return Intl.message('Books found', name: 'books_found', desc: '', args: []);
  }

  /// `Congratulations`
  String get congratulations {
    return Intl.message(
      'Congratulations',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Your purchase has been finalised, enjoy your new books`
  String get purchase_success {
    return Intl.message(
      'Your purchase has been finalised, enjoy your new books',
      name: 'purchase_success',
      desc: '',
      args: [],
    );
  }

  /// `Your purchase has been canceled, try again!`
  String get purchase_failure {
    return Intl.message(
      'Your purchase has been canceled, try again!',
      name: 'purchase_failure',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message('Continue', name: 'continue_', desc: '', args: []);
  }

  /// `Go back`
  String get go_back {
    return Intl.message('Go back', name: 'go_back', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Dark mode`
  String get dark_mode {
    return Intl.message('Dark mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `Light mode`
  String get light_mode {
    return Intl.message('Light mode', name: 'light_mode', desc: '', args: []);
  }

  /// `Select a language`
  String get select_language {
    return Intl.message(
      'Select a language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Sign out`
  String get sign_out {
    return Intl.message('Sign out', name: 'sign_out', desc: '', args: []);
  }

  /// `Are you sure you want to sign out?`
  String get sign_out_confirmation {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'sign_out_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message('cancel', name: 'cancel', desc: '', args: []);
  }

  /// `SIGN OUT`
  String get sign_out_caps {
    return Intl.message('SIGN OUT', name: 'sign_out_caps', desc: '', args: []);
  }

  /// `see all`
  String get see_all {
    return Intl.message('see all', name: 'see_all', desc: '', args: []);
  }

  /// `Recently Added`
  String get recently_added {
    return Intl.message(
      'Recently Added',
      name: 'recently_added',
      desc: '',
      args: [],
    );
  }

  /// `you might like some these book!`
  String get you_might_like_this_books {
    return Intl.message(
      'you might like some these book!',
      name: 'you_might_like_this_books',
      desc: '',
      args: [],
    );
  }

  /// `No books added yet`
  String get no_books_added {
    return Intl.message(
      'No books added yet',
      name: 'no_books_added',
      desc: '',
      args: [],
    );
  }

  /// `ERROR`
  String get error_caps {
    return Intl.message('ERROR', name: 'error_caps', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Added to cart`
  String get added_to_cart {
    return Intl.message(
      'Added to cart',
      name: 'added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Book already in cart`
  String get book_already_in_cart {
    return Intl.message(
      'Book already in cart',
      name: 'book_already_in_cart',
      desc: '',
      args: [],
    );
  }

  /// `Removed from cart`
  String get removed_from_cart {
    return Intl.message(
      'Removed from cart',
      name: 'removed_from_cart',
      desc: '',
      args: [],
    );
  }

  /// `Book isn't in cart`
  String get book_isnt_in_cart {
    return Intl.message(
      'Book isn\'t in cart',
      name: 'book_isnt_in_cart',
      desc: '',
      args: [],
    );
  }

  /// `Cart cleared`
  String get cart_cleared {
    return Intl.message(
      'Cart cleared',
      name: 'cart_cleared',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get cart_is_empty {
    return Intl.message(
      'Your cart is empty',
      name: 'cart_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Book already in your bookshelf`
  String get book_already_in_bookshelf {
    return Intl.message(
      'Book already in your bookshelf',
      name: 'book_already_in_bookshelf',
      desc: '',
      args: [],
    );
  }

  /// `Payment canceled`
  String get payment_canceled {
    return Intl.message(
      'Payment canceled',
      name: 'payment_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Can't find cover for`
  String get cant_find_cover_for {
    return Intl.message(
      'Can\'t find cover for',
      name: 'cant_find_cover_for',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
