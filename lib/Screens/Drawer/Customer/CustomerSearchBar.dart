import 'package:flutter/material.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Screens/Drawer/Customer/CustomerItem_widget.dart';
import 'package:iwas_port/Styles/background_style.dart';

class CustomerSearchBar extends SearchDelegate {
  final List<Customer> myList;
  CustomerSearchBar({this.myList});

  List<Customer> _showSuggestions(String searchString) {
    return myList
        .where((customer) =>
    customer.name.toLowerCase().contains(searchString.toLowerCase()))
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
                child: CustomerItem(suggestionList[index]));
          }),
    );
  }
}
