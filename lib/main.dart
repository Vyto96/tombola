import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/generator_bloc/generator_bloc.dart';
import 'ui/screen/homescreen/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GeneratorBloc>(
      create: (_) => GeneratorBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tombola',
        home: HomeScreen()
      ),
    );
  }
}
