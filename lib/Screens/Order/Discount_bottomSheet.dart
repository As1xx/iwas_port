import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:iwas_port/Screens/Authenticate/TextInputForm_decoration.dart';

class DiscountScreen extends StatefulWidget {
  final double orderAmount;
  final Function setDiscount;
  DiscountScreen(this.orderAmount, this.setDiscount);

  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  bool percentageSwitchState = false;
  bool absoluteSwitchState = true;
  MoneyMaskedTextController discountTextController;
  double controllerValue = 0;
  final formKey = GlobalKey<FormState>();

  String _checkEmpty(String text) {
    if (text.isEmpty) {
      return 'Please specify Field';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    // Switch Symbol depending on SwitchState
    if (percentageSwitchState == true) {
      discountTextController = MoneyMaskedTextController(
          rightSymbol: '%', precision: 2, decimalSeparator: ',');
      discountTextController.updateValue(controllerValue);
    } else {
      discountTextController = MoneyMaskedTextController(
          rightSymbol: '€', precision: 2, decimalSeparator: ',');
      discountTextController.updateValue(controllerValue);
    }

    // Convert Discount Value to absolute Value
    double checkDiscountValue() {
      return percentageSwitchState == true
          ? discountTextController.numberValue / 100 * widget.orderAmount
          : discountTextController.numberValue;
    }

    // validate Form and update Parent
    void _validateDiscount() {
      if (formKey.currentState.validate()) {
        final discountValue = checkDiscountValue();
        widget.setDiscount(discountValue);
        Navigator.of(context).pop();
      }
    }

    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Discount',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Percentage',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Spacer(),
                        Switch(
                          value: percentageSwitchState,
                          onChanged: (state) {
                            setState(() {
                              percentageSwitchState = state;
                              absoluteSwitchState = !absoluteSwitchState;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Absolute',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Spacer(),
                        Switch(
                          value: absoluteSwitchState,
                          onChanged: (state) {
                            setState(() {
                              absoluteSwitchState = state;
                              percentageSwitchState = !percentageSwitchState;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    onChanged: (text) =>
                        controllerValue = discountTextController.numberValue,
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
                    validator: _checkEmpty,
                    controller: discountTextController,
                    keyboardType: TextInputType.number,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.focusColor,
                    decoration: textFormDecoration(context).copyWith(
                      labelText: 'Discount',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      onPressed: () => _validateDiscount(),
                      color: Theme.of(context).accentColor,
                      child: Text('OK',style: Theme.of(context).textTheme.button,),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
