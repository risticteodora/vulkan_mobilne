import 'package:flutter/foundation.dart';
import 'package:moj_projekat/repositories/firebase/recently_viewed_repository.dart';

class RecentlyViewedProvider extends ChangeNotifier {
  final RecentlyViewedRepository _repo;

  RecentlyViewedProvider(this._repo);

  final List<String> _bookIds = [];
  String? _uid;

  List<String> get bookIds => List.unmodifiable(_bookIds);

  Future<void> setUser(String? uid) async {
    if (_uid == uid) return;
    _uid = uid;

    _bookIds
      ..clear()
      ..addAll(await _repo.load(_uid));

    notifyListeners();
  }

  Future<void> add(String bookId) async {
    _bookIds.remove(bookId);
    _bookIds.insert(0, bookId);
    if (_bookIds.length > 20) _bookIds.removeLast();

    notifyListeners();
    await _repo.save(_uid, _bookIds);
  }

  Future<void> clear() async {
    _bookIds.clear();
    notifyListeners();
    await _repo.clear(_uid);
  }
}
