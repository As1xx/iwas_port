import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class TEST extends StatefulWidget {

  @override
  _TESTState createState() => _TESTState();
}

class _TESTState extends State<TEST> {
  var selectedUsState = "Connecticut";

  List<String> usStates = <String>[
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green,
      body: Container(
          child: IconButton(
            icon: Icon(Icons.vertical_align_bottom),
            onPressed: (){
              showMaterialScrollPicker(
                context: context,
                title: "Pick Your City",
                items: usStates,
                selectedItem: selectedUsState,
                onChanged: (value) => setState(() => selectedUsState = value),
              );
            },
          ),
        ),
      );
  }
}
