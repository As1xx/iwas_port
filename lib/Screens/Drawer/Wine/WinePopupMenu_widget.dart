import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:popup_menu/popup_menu.dart';


void buildPopupMenu(BuildContext context, GlobalKey widgetKey,List<Wine> wineList,Function sortScreen){

  void _sortManufacturerAscending() {
   wineList.sort((a, b) => a.manufacturer.compareTo(b.manufacturer));
  }

  void _sortManufacturerDescending() {
    wineList.sort((a, b) => b.manufacturer.compareTo(a.manufacturer));
  }

  void onClickMenu(MenuItemProvider item) {
    if(item.menuTitle == 'Sortiere (A-Z)'){
      _sortManufacturerAscending();
    }else if (item.menuTitle == 'Sortiere (Z-A)'){
      _sortManufacturerDescending();
    }
    sortScreen(wineList);
  }

  PopupMenu menu = PopupMenu(
    context: context,
    maxColumn: 1,
    highlightColor: Theme.of(context).accentColor,
    items: [
      MenuItem(
          title:'Sortiere (A-Z)',
      image: Icon(
        FontAwesomeIcons.sortAlphaDown,
      )),
      MenuItem(
        title: 'Sortiere (Z-A)',
        image:Icon(
          FontAwesomeIcons.sortAlphaUp
        ),
      ),
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

