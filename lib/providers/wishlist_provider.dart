import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier{
  final Set<String> _ids= {};

  bool isWished(String id)=> _ids.contains(id);

  void toggle(String id){
    if(_ids.contains(id)){
      _ids.remove(id);
    }else{
      _ids.add(id);
    }
    notifyListeners();
  }

  List<String> get ids => _ids.toList();
  void clear(){
    _ids.clear();
    notifyListeners();
  }
}