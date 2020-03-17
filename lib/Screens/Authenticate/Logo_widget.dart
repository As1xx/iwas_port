import 'package:flutter/material.dart';

SafeArea buildUnboxedLogo(BuildContext context) {
  return SafeArea(
      minimum: EdgeInsets.only(top: 20),
      child: Text(
        'IRGENDWAS MIT',
        style: Theme.of(context).textTheme.caption,
      ));
}

Container buildBoxedLogo(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 60,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).highlightColor,
        ),
      ),
      child: FittedBox(
          child: Text('PORT', style: Theme.of(context).textTheme.title)));
}
