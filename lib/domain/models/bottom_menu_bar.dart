import 'package:flutter_project/domain/models/item_bottom_menu_bar.dart';

class BottomMenuBar {
  int currentIndex = 0;
  List<ItemBottomMenuBar> items = [];

  BottomMenuBar(
      this.currentIndex,
      this.items
      );
}