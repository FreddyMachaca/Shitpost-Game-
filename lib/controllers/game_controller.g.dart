// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameController on GameControllerBase, Store {
  Computed<bool>? _$jogadaCompletaComputed; //variable computada

  @override
  bool get jugadaCompleta => //variable para saber si la jugada esta completa
      (_$jogadaCompletaComputed ??= Computed<bool>(() => super.jugadaCompleta, //variable computada
              name: 'GameControllerBase.jogadaCompleta')) //nombre de la variable
          .value; //valor de la variable

  final _$gameCardsAtom = Atom(name: 'GameControllerBase.gameCards'); //variable observable

  @override
  List<GameOpcion> get gameCards { //lista de cartas
    _$gameCardsAtom.reportRead(); //reporta la lectura
    return super.gameCards; //retorna la lista de cartas
  }

  @override
  set gameCards(List<GameOpcion> value) { //setea la lista de cartas
    _$gameCardsAtom.reportWrite(value, super.gameCards, () { //reporta la escritura
      super.gameCards = value; //setea la lista de cartas
    });
  }

  final _$scoreAtom = Atom(name: 'GameControllerBase.score'); //variable observable

  @override
  int get score { //puntaje
    _$scoreAtom.reportRead();//reporta la lectura
    return super.score;//retorna el puntaje
  }

  @override
  set score(int value) { //setea el puntaje
    _$scoreAtom.reportWrite(value, super.score, () { //reporta la escritura
      super.score = value;//setea el puntaje
    });
  }

  final _$venceuAtom = Atom(name: 'GameControllerBase.venceu'); //variable observable

  @override
  bool get ganaste { //variable para saber si gano
    _$venceuAtom.reportRead(); //reporta la lectura
    return super.ganaste; //retorna la variable
  }

  @override
  set ganaste(bool value) { //setea la variable
    _$venceuAtom.reportWrite(value, super.ganaste, () { //reporta la escritura
      super.ganaste = value; //setea la variable
    });
  }

  final _$perdeuAtom = Atom(name: 'GameControllerBase.perdeu'); //variable observable

  @override
  bool get perdiste { //variable para saber si perdio
    _$perdeuAtom.reportRead(); //reporta la lectura
    return super.perdiste; //retorna la variable
  }

  @override
  set perdiste(bool value) { //setea la variable
    _$perdeuAtom.reportWrite(value, super.perdiste, () { //reporta la escritura
      super.perdiste = value; //setea la variable
    });
  }

  @override
  String toString() { //metodo toString es para mostrar el valor de las variables
    return '''
gameCards: ${gameCards}, //lista de cartas
score: ${score}, //puntaje
venceu: ${ganaste}, //variable para saber si gano
perdeu: ${perdiste}, //variable para saber si perdio
jogadaCompleta: ${jugadaCompleta} //variable para saber si la jugada esta completa
    ''';
  }
}
