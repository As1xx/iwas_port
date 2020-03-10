import 'package:flutter/material.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:iwas_port/Screens/Drawer/Supplier/SupplierItem_widget.dart';
import 'package:iwas_port/Styles/background_style.dart';

class SupplierSearchBar extends SearchDelegate {
  final List<Supplier> myList;
  SupplierSearchBar({this.myList});

  List<Supplier> _showSuggestions(String searchString) {
    return myList
        .where((supplier) =>
        supplier.name.toLowerCase().contains(searchString.toLowerCase()))
        .toList();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).appBarTheme.color,
      primaryIconTheme: Theme.of(context).appBarTheme.iconTheme,
      primaryTextTheme: Theme.of(context).appBarTheme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = _showSuggestions(query);

    return Background(
      child: ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(top: 8),
                child: SupplierItem(suggestionList[index]));
          }),
    );
  }
}
