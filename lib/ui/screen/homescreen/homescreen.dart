import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import '../../../blocs/generator_bloc/generator_bloc.dart';
import '../../widgets/animated_counter_widget.dart';
import '../../widgets/previous_number_row_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/natale_bg_1920x1080.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: BootstrapContainer(
            fluid: true,
            padding: const EdgeInsets.all(0),
            children: [
              BootstrapRow(
                height: MediaQuery.of(context).size.height,
                children: [
                  BootstrapCol(
                    sizes: 'col-12 col-sm-12 col-md-12 col-lg-12 col-xl-12',
                    child: Header(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  AnimationController _counterAniContrl;
  GeneratorBloc _generatorBloc;
  ScrollController _scrollCtrl;

  @override
  void initState() {
    super.initState();
    _scrollCtrl = ScrollController();
    _generatorBloc = BlocProvider.of<GeneratorBloc>(context);
    _generatorBloc.listen((state) {
      _counterAniContrl?.animateTo(state.value.toDouble());
      _scrollCtrl?.animateTo(
        (200 + _scrollCtrl.position.maxScrollExtent).toDouble(),
        duration: Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );
    });
  }

  @override
  void dispose() {
    _counterAniContrl.dispose();
    _generatorBloc.close();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          AnimatedCounterWidget(
            init: (c) => _counterAniContrl = c,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlineButton(
                onPressed: () {
                  _generatorBloc.add(GeneratorGenerateRandomEvent());
                },
                child: Icon(
                  Icons.fiber_new,
                  color: Colors.green,
                  size: 100.0,
                ),
              )
              // ,
              // OutlineButton(
              //   onPressed: () {
              //     _generatorBloc.add(GeneratorResetEvent());
              //   },
              //   child: Icon(
              //     Icons.refresh_outlined,
              //     color: Colors.red,
              //     size: 100.0,
              //   ),
              // )
            ],
          ),
          Container(
            height: 100,
            child: BlocBuilder<GeneratorBloc, GeneratorState>(
              builder: (context, state) {
                return PreviousNumbersRow(
                  generatedValues: _generatorBloc.state.generatedNumbers,
                  controller: _scrollCtrl,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
