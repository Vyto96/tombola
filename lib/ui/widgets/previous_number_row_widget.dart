import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class PreviousNumbersRow extends StatelessWidget {
  final Set<int> generatedValues;
  final ScrollController controller;

  const PreviousNumbersRow({
    Key key,
    this.generatedValues,
    this.controller,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: generatedValues.length,
      controller: controller,
      scrollDirection: Axis.horizontal,
      reverse: false,
      itemBuilder: (context, index) {
        return PreviousItem(
          value: NAMES[generatedValues.elementAt(index)] ,
        );
      },
    );
  }
}

class PreviousItem extends StatelessWidget {
  final String value;

  const PreviousItem({Key key, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromRGBO(91, 163, 141, 1),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        '$value',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(91, 163, 141, 1)
        ),
      ),
    );
  }
}
