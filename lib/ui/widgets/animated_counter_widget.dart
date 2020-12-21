import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class AnimatedCounterWidget extends StatefulWidget {
  final void Function(AnimationController controller) init;
  const AnimatedCounterWidget({
    this.init,
    Key key,
  }) : super(key: key);

  @override
  _AnimatedCounterWidgetState createState() => _AnimatedCounterWidgetState();
}

class _AnimatedCounterWidgetState extends State<AnimatedCounterWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: NAMES.length.toDouble(),
      duration: const Duration(milliseconds: 1000),
    );
    if (widget.init != null) {
      widget.init(_ctrl);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 300,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromRGBO(91, 163, 141, 1),
          width: 2,
        ),
      ),
      margin: const EdgeInsets.only(top:180),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Text(
            NAMES[_ctrl.value.floor()],
            style: Theme.of(context).primaryTextTheme.headline3.copyWith(
                  fontSize: 100,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(91, 163, 141, 1)
                ),
          );
        },
      ),
    );
  }
}
