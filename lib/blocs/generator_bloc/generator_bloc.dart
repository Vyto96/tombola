library blocs.generator_bloc;

import 'dart:math';

import 'package:bloc/bloc.dart';
import '../../constants/constants.dart';

part 'generator_state.dart';
part 'generator_event.dart';

class GeneratorBloc extends Bloc<GeneratorEvent, GeneratorState> {
  GeneratorBloc() : super(GeneratorState.inital());

  Set<int> _generatedNumbers = <int>{};

  @override
  Stream<GeneratorState> mapEventToState(GeneratorEvent event) async* {
    if (event is GeneratorGenerateRandomEvent) {
      yield* _mapGenerateEventToState();
    } else if (event is GeneratorResetEvent) {
      yield* _mapGenerateResetToState();
    }
  }

  Stream<GeneratorState> _mapGenerateEventToState() async* {
    try {
      if (_generatedNumbers.length >= NAMES.length) return;
      int randomValue = _generateRandom();
      while (_generatedNumbers.contains(randomValue) &&
          _generatedNumbers.length < NAMES.length) {
        randomValue = _generateRandom();
      }
      _generatedNumbers.add(randomValue);
      yield GeneratorState.generated(randomValue, _generatedNumbers);
    } catch (e) {
      print(e);
    }
  }

  Stream<GeneratorState> _mapGenerateResetToState() async* {
    try {
      _generatedNumbers = <int>{};
      yield GeneratorState.reset();
    } catch (e) {
      print(e);
    }
  }

  int _generateRandom() {
    // Generatos random value between 1 to NAMES.length
    // both min and max values are inclusive
    // logic obtained from https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random#Examples
    return (Random().nextDouble() * (NAMES.length)).floor();
  }
}
