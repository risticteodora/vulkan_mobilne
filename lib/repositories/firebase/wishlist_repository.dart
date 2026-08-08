import 'package:shared_preferences/shared_preferences.dart';

class WishlistRepository {
  String _key(String? uid) => uid == null ? 'wishlist_guest' : 'wishlist_$uid';

  Future<List<String>> load(String? uid) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(_key(uid)) ?? <String>[];
  }

  Future<void> save(String? uid, List<String> ids) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setStringList(_key(uid), ids);
  }

  Future<void> clear(String? uid) async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_key(uid));
  }
}
