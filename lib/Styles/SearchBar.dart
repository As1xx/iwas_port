import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:iwas_port/Screens/Drawer/WineItem_widget.dart';
import 'package:iwas_port/Styles/background_style.dart';
import 'package:iwas_port/Themes/DarkAppTheme.dart';

class SearchBar extends SearchDelegate {
  final List<Wine> myList;
  SearchBar({this.myList});

  List<Wine> _showSuggestions(String searchString) {
    return myList
        .where((wine) =>
    wine.manufacturer
        .toLowerCase()
        .contains(searchString.toLowerCase()) ||
        wine.type.toLowerCase().contains(searchString.toLowerCase()))
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
                child: WineItem(suggestionList[index]));
          }),
    );
  }
}
