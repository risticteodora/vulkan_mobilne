import 'package:flutter/foundation.dart';
import 'package:moj_projekat/repositories/firebase/wishlist_repository.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistRepository _repo;
  WishlistProvider(this._repo);

  final Set<String> _ids = {};
  String? _uid;

  List<String> get ids => _ids.toList();
  bool isWished(String id) => _ids.contains(id);

  Future<void> setUser(String? uid) async {
    if (_uid == uid) return;

    final current = _ids.toList();

    _uid = uid;
    _ids
      ..clear()
      ..addAll(await _repo.load(_uid));
      
    if (_ids.isEmpty && current.isNotEmpty) {
      _ids.addAll(current);
      await _repo.save(_uid, _ids.toList());
    }

    notifyListeners();
  }

  Future<void> toggle(String id) async {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
    }
    notifyListeners();
    await _repo.save(_uid, _ids.toList());
  }

  Future<void> clear() async {
    _ids.clear();
    notifyListeners();
    await _repo.clear(_uid);
  }
}
