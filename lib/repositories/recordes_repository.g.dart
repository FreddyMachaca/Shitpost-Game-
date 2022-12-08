// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordes_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecordesRepository on RecordesRepositoryBase, Store {
  final _$recordesRound6Atom =
      Atom(name: 'RecordesRepositoryBase.recordesRound6'); //variable observable

  @override
  Map<dynamic, dynamic> get recordesRound6 { //mapa de recordes
    _$recordesRound6Atom.reportRead(); //reporta la lectura
    return super.recordesRound6;
  }

  @override
  set recordesRound6(Map<dynamic, dynamic> value) {
    _$recordesRound6Atom.reportWrite(value, super.recordesRound6, () { //reporta la escritura
      super.recordesRound6 = value; //setea el mapa de recordes
    });
  }

  final _$recordesNormalAtom =
      Atom(name: 'RecordesRepositoryBase.recordesNormal'); //variable observable

  @override
  Map<dynamic, dynamic> get recordesNormal { //mapa de recordes
    _$recordesNormalAtom.reportRead(); //reporta la lectura
    return super.recordesNormal; //retorna el mapa de recordes
  }

  @override
  set recordesNormal(Map<dynamic, dynamic> value) { //setea el mapa de recordes
    _$recordesNormalAtom.reportWrite(value, super.recordesNormal, () { //reporta la escritura
      super.recordesNormal = value; //setea el mapa de recordes
    });
  }

  final _$RecordesRepositoryBaseActionController =
      ActionController(name: 'RecordesRepositoryBase'); //controlador de acciones

  @override
  dynamic loadRecordes() { //carga los recordes
    final _$actionInfo = _$RecordesRepositoryBaseActionController.startAction( //inicia la accion
        name: 'RecordesRepositoryBase.loadRecordes'); //nombre de la accion
    try { //intenta
      return super.loadRecordes(); //carga los recordes
    } finally { //finalmente
      _$RecordesRepositoryBaseActionController.endAction(_$actionInfo); //finaliza la accion
    }
  }

  @override
  String toString() { //retorna un string
    return '''
recordesRound6: ${recordesRound6},
recordesNormal: ${recordesNormal}
    ''';
  }
}
