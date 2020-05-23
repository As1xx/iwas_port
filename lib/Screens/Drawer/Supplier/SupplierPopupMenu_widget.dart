import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:popup_menu/popup_menu.dart';


void buildPopupMenu(BuildContext context, GlobalKey widgetKey,List<Supplier> supplierList,Function sortScreen){

  void _sortNameAscending() {
    supplierList.sort((a, b) => a.name.compareTo(b.name));
  }

  void _sortNameDescending() {
    supplierList.sort((a, b) => b.name.compareTo(a.name));
  }

  void onClickMenu(MenuItemProvider item) {
    if(item.menuTitle == 'Sortiere (A-Z)'){
      _sortNameAscending();
    }else if (item.menuTitle == 'Sortiere (Z-A)'){
      _sortNameDescending();
    }
    sortScreen(supplierList);
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

