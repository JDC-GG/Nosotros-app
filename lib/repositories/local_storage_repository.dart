import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  static const _streakKey = 'streak';
  static const _loveCoinsKey = 'loveCoins';
  static const _lastCompletedDateKey = 'lastCompletedDate';

  Future<int> getStreak() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(_streakKey) ?? 0;
  }

  Future<int> getLoveCoins() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(_loveCoinsKey) ?? 0;
  }

  Future<DateTime?> getLastCompletedDate() async {
    final preferences = await SharedPreferences.getInstance();

    final value = preferences.getString(_lastCompletedDateKey);

    if (value == null) return null;

    return DateTime.tryParse(value);
  }

  Future<void> saveStreak(int streak) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(_streakKey, streak);
  }

  Future<void> saveLoveCoins(int loveCoins) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(_loveCoinsKey, loveCoins);
  }

  Future<void> saveLastCompletedDate(DateTime date) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
      _lastCompletedDateKey,
      date.toIso8601String(),
    );
  }

  Future<void> saveStats({
    required int streak,
    required int loveCoins,
    required DateTime lastCompletedDate,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(_streakKey, streak);
    await preferences.setInt(_loveCoinsKey, loveCoins);
    await preferences.setString(
      _lastCompletedDateKey,
      lastCompletedDate.toIso8601String(),
    );
  }
}