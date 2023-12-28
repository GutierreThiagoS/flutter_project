
import 'package:flutter/foundation.dart';
import 'package:flutter_project/domain/models/coupon.dart';
import 'package:flutter_project/domain/repository/user_repository.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {

  final UserRepository _userRepository;

  HomeController(this._userRepository);

  ValueNotifier<List<Coupon>> cupoms = ValueNotifier<List<Coupon>>([]);
  final ValueNotifier<int> bottomMenuBar = ValueNotifier<
      int>(0);


  void setSelectedIndex(int i) {
    bottomMenuBar.value = i;
  }

  Future<bool> logout() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      bool isUserRemove = await prefs.remove('user');
      bool isPassRemove = await prefs.remove('pass');
      return isUserRemove && isPassRemove;
    } else {
      bool result = await _userRepository.deleteAll();
      return result;
    }
  }
}

final listCupons = FutureProvider<ValueNotifier<List<Coupon>>>((ref) async {
  await Future.delayed(const Duration(seconds: 3));
  ref
      .read(injectHomeController)
      .cupoms
      .value = [
    Coupon(1, "Y233BYHS12"),
    Coupon(2, "KJBB514GYG"),
    Coupon(3, "KNIUG745DJ"),
    Coupon(4, "IOA8923KMF"),
    Coupon(5, "14AJXA71BN")
  ];
  return ref
      .read(injectHomeController)
      .cupoms;
});

final getBottomMenuBar = FutureProvider<ValueNotifier<int>>((ref) async {

  return ref
      .read(injectHomeController)
      .bottomMenuBar;
});

