import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ChatReadStorage {
  SharedPreferences? _sharedPreferences;

  FutureOr<SharedPreferences> get _prefs {
    if (_sharedPreferences != null) return _sharedPreferences!;
    return SharedPreferences.getInstance();
  }

  Future<void> setChatRead(String chatId) async {
    final prefs = await _prefs;
    await prefs.setString(chatId, DateTime.now().toIso8601String());
  }

  Future<bool> isChatUnread(String chatId, DateTime? lastEditTimestamp) async {
    final prefs = await _prefs;
    final readString = prefs.getString(chatId);
    if (lastEditTimestamp == null) return readString != null;
    if (readString == null) {
      setChatRead(chatId);
      return true;
    }
    final readTime = DateTime.parse(readString);
    return readTime.isBefore(lastEditTimestamp);
  }
}
