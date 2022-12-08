import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/models/game_play.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'recordes_repository.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;
//que es mobx y como funciona?
//https://pub.dev/packages/mobx
//MobX es una biblioteca para gestionar de forma reactiva el estado de sus aplicaciones.
// Usa el poder de los observables, las acciones y
// las reacciones para potenciar tus aplicaciones Dart y Flutter

//que son los observables?
//Los observables representan el estado reactivo de su aplicación.
// Cuando un observable cambia, MobX notifica a todos los observadores que dependen de él.
// Los observables son simples clases Dart que extienden de la clase Store.

abstract class RecordesRepositoryBase with Store { //Store es una clase de mobx
  late final Box _recordes; //variable para guardar los recordes
  late final GamePlay gamePlay; //variable para guardar el juego
  @observable
  Map recordesRound6 = {}; //variable para guardar los recordes del modo Insano
  @observable
  Map recordesNormal = {}; //variable para guardar los recordes del modo normal

  RecordesRepositoryBase() { //constructor
    _initRepository(); //inicializa el repositorio
  }

  _initRepository() async { //funcion para inicializar el repositorio
    await _initDatabase(); //inicializa la base de datos
    await loadRecordes(); //carga los recordes
  }

  _initDatabase() async { //funcion para inicializar la base de datos
    _recordes = await Hive.openBox('gameRecordes3'); //abre la base de datos
  }

  @action
  loadRecordes() {
    recordesNormal = _recordes.get(Modo.normal.toString()) ?? {}; //carga los recordes del modo normal
    recordesRound6 = _recordes.get(Modo.dificil.toString()) ?? {}; //carga los recordes del modo dificil
  }

  updateRecordes({required GamePlay gamePlay, required int score}) { //funcion para actualizar los recordes
    final key = gamePlay.modo.toString(); //variable para guardar el modo
    //final es una palabra reservada que nos permite declarar una variable constante
    if (gamePlay.modo == Modo.normal && //si el modo es normal
        (recordesNormal[gamePlay.nivel] == null || //y no hay recordes
            score < recordesNormal[gamePlay.nivel])) { //o el puntaje es menor al record
      recordesNormal[gamePlay.nivel] = score; //guarda el puntaje
      _recordes.put(key, recordesNormal); //guarda los recordes
    } else if (gamePlay.modo == Modo.dificil && //si el modo es dificil
        (recordesRound6[gamePlay.nivel] == null || //y no hay recordes
            score > recordesRound6[gamePlay.nivel])) { //o el puntaje es mayor al record
      recordesRound6[gamePlay.nivel] = score; //guarda el puntaje
      _recordes.put(key, recordesRound6); //guarda los recordes
    }
  }
}
