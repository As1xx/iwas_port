import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:popup_menu/popup_menu.dart';

void buildPopupMenu(
    BuildContext context, GlobalKey widgetKey, Function setMethod) {
  void onClickMenu(MenuItemProvider item) {
    setMethod(item.menuTitle);
  }

  PopupMenu menu = PopupMenu(
    context: context,
    maxColumn: 1,
    highlightColor: Theme.of(context).accentColor,
    items: [
      MenuItem(
          title: 'Kaufen', textStyle: Theme.of(context).textTheme.headline4),
      MenuItem(
          title: 'Verkaufen', textStyle: Theme.of(context).textTheme.headline4),
      MenuItem(
          title: 'Transfer', textStyle: Theme.of(context).textTheme.headline4),
    ],
    onClickMenu: onClickMenu,
    onDismiss: onDismiss,
    stateChanged: stateChanged,
  );

  menu.show(widgetKey: widgetKey);
}

void stateChanged(bool isShow) {
  // print('menu is ${isShow ? 'showing' : 'closed'}');
}

void onDismiss() {
  // print('Menu is dismiss');
}
