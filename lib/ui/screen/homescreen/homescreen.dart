import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import '../../../blocs/generator_bloc/generator_bloc.dart';
import '../../widgets/animated_counter_widget.dart';
import '../../widgets/previous_number_row_widget.dart';
//import 'components/about_page.dart';

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
        (70 + _scrollCtrl.position.maxScrollExtent).toDouble(),
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
              OutlineButton.icon(
                icon: Icon(Icons.fiber_new),
                label: Text('Generate'),
                color: Colors.green,
                textColor: Colors.green,
                onPressed: () {
                  _generatorBloc.add(GeneratorGenerateRandomEvent());
                },
              ),
              OutlineButton.icon(
                icon: Icon(Icons.refresh_outlined),
                label: Text('Reset'),
                color: Colors.red,
                textColor: Colors.red,
                onPressed: () {
                  _generatorBloc.add(GeneratorResetEvent());
                },
              ),
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

class Table extends StatelessWidget {
  const Table({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(2),
          height: constraints.maxWidth,
          alignment: Alignment.center,
          child: BlocBuilder<GeneratorBloc, GeneratorState>(
            builder: (context, state) {
              return GridView.builder(
                itemCount: 90,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  childAspectRatio: 1.14,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TableTile(
                    index: index + 1,
                    isSelected: state.generatedNumbers.contains(index + 1),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class TableTile extends StatelessWidget {
  final int index;
  final bool isSelected;

  const TableTile({
    Key key,
    @required this.index,
    this.isSelected = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      decoration: BoxDecoration(
        color:
            isSelected ? Colors.purple[50] : Colors.purple[50].withOpacity(0.3),
        border: Border.all(
          color: isSelected ? Colors.purple : Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          '$index',
          style: TextStyle(
            color: isSelected
                ? Colors.purple
                : Theme.of(context).textSelectionColor.withOpacity(0.5),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
