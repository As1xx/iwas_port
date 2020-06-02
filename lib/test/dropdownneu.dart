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
