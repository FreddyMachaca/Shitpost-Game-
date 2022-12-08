import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/game_settings.dart';
import 'package:flutter_memory_game/models/game_opcao.dart';
import 'package:flutter_memory_game/models/game_play.dart';
import 'package:flutter_memory_game/repositories/recordes_repository.dart';
import 'package:mobx/mobx.dart';

part 'game_controller.g.dart';

class GameController = GameControllerBase with _$GameController;

abstract class GameControllerBase with Store {
  //store es un gerenciador de estado que nos permite observar los cambios en las variables
  @observable //variable observable
  List<GameOpcion> gameCards = []; //lista de cartas
  @observable
  int score = 0; //puntaje
  @observable
  bool ganaste = false; //variable para saber si ganaste
  @observable
  bool perdiste = false; //variable para saber si perdiste

  late GamePlay _gamePlay; //variable para guardar el juego
  //late es una variable que se inicializa mas tarde
  List<GameOpcion> _escojer = []; //lista de cartas que se escogen
  List<Function> _escojaCallback = []; //lista de funciones que se ejecutan al escoger una carta
  int _aciertos = 0; //variable para guardar los aciertos
  int _numPares = 0; //variable para guardar el numero de pares
  RecordesRepository recordesRepository; //variable para guardar el repositorio de recordes

  @computed //variable computada
  bool get jugadaCompleta => (_escojer.length == 2); //variable para saber si la jugada esta completa

  GameControllerBase({required this.recordesRepository}) { //constructor
    reaction((_) => ganaste == true, (bool gano) { //reaction es una funcion que se ejecuta cuando se cumple una condicion
      if (gano) { //si gano es true
        recordesRepository.updateRecordes(gamePlay: _gamePlay, score: score); //actualiza los recordes
      }
    });
  }

  startGame({required GamePlay gamePlay}) { //funcion para iniciar el juego
    _gamePlay = gamePlay; //guarda el juego
    _aciertos = 0;  //inicializa los aciertos
    _numPares = (_gamePlay.nivel / 2).round(); //calcula el numero de pares
    ganaste = false; //inicializa la variable ganaste
    perdiste = false; //inicializa la variable perdiste
    _resetScore(); //resetea el puntaje
    _generateCards(); //genera las cartas
  }
 //_ es una variable privada
  _resetScore() { //funcion para resetear el puntaje
    _gamePlay.modo == Modo.normal ? score = 0 : score = _gamePlay.nivel;
    //si el modo es normal el puntaje es 0
  }

  _generateCards() { //funcion para generar las cartas
    List<int> cardOpciones = GameSettings.cardOpcoes.sublist(0)..shuffle(); //baraja las cartas
    //shuffle es una funcion que baraja las cartas
    cardOpciones = cardOpciones.sublist(0, _numPares); //selecciona las cartas
    gameCards = [...cardOpciones, ...cardOpciones] //duplica las cartas
        .map((opcion) => //map es una funcion que recorre la lista
            GameOpcion(opcion: opcion, matched: false, selected: false)) //crea una nueva lista
        .toList(); //toList es una funcion que convierte la lista con map
    gameCards.shuffle(); //baraja las cartas
  }

  escojer(GameOpcion opcion, Function resetCard) async { //funcion para escoger una carta
    opcion.selected = true; //selecciona la carta
    _escojer.add(opcion); //agrega la carta a la lista de cartas escogidas
    _escojaCallback.add(resetCard); //agrega la funcion a la lista de funciones
    await _compararEscolhas(); //compara las cartas escogidas
  }

  _compararEscolhas() async {
    if (jugadaCompleta) { //si la jugada esta completa
      if (_escojer[0].opcion == _escojer[1].opcion) { //si las cartas son iguales
        _aciertos++; //suma un acierto
        _escojer[0].matched = true; //marca la carta como acertada
        _escojer[1].matched = true; //marca la carta como acertada
      } else {  //si las cartas no son iguales
        await Future.delayed(const Duration(seconds: 1), () { //espera un segundo
          for (var i in [0, 1]) { //recorre la lista de cartas escogidas
            _escojer[i].selected = false; //deselecciona la carta
            _escojaCallback[i](); //ejecuta la funcion
          }
        });
      }

      _resetJugada(); //resetea la jugada
      _updateScore(); //actualiza el puntaje
      _checkGameResult(); //verifica el resultado del juego
    }
  }

  _checkGameResult() async { //funcion para verificar el resultado del juego
    bool allMatched = _aciertos == _numPares; //verifica si se acertaron todas las cartas
    if (_gamePlay.modo == Modo.normal) { //si el modo es normal
      await _checkResultModoNormal(allMatched); //verifica el resultado del modo normal
    } else { //si el modo es insano
      await _checkResultModoRound6(allMatched); //verifica el resultado del modo insano
    }
  }

  _checkResultModoNormal(bool allMatched) async { //funcion para verificar el resultado del modo normal
    await Future.delayed( //espera un segundo
        const Duration(seconds: 1), () => ganaste = allMatched);
  }

  _checkResultModoRound6(bool allMatched) async { //funcion para verificar el resultado del modo insano
    if (_chancesAcabaram()) { //si se acabaron las oportunidades
      await Future.delayed( //espera un segundo
          const Duration(milliseconds: 400), () => perdiste = true); //marca que perdiste
    }
    if (allMatched && score >= 0) { //si se acertaron todas las cartas y el puntaje es mayor o igual a 0
      await Future.delayed( //espera un segundo
          const Duration(seconds: 1), () => ganaste = allMatched); //marca que ganaste
    }
  }

  _chancesAcabaram() { //funcion para verificar si se acabaron las oportunidades
    return score < _numPares - _aciertos;
  }

  _resetJugada() { //funcion para resetear la jugada
    _escojer = []; //resetea la lista de cartas escogidas
    _escojaCallback = []; //resetea la lista de funciones
  }

  _updateScore() { //funcion para actualizar el puntaje
    _gamePlay.modo == Modo.normal ? score++ : score--; //si el modo es normal suma un punto, si no resta un punto
  }

  restartGame() { //funcion para reiniciar el juego
    startGame(gamePlay: _gamePlay); //inicia el juego
  }

  nextLevel() { //funcion para pasar al siguiente nivel
    int nivelIndex = 0; //inicializa el indice del nivel

    if (_gamePlay.nivel != GameSettings.niveles.last) { //si el nivel no es el ultimo
      nivelIndex = GameSettings.niveles.indexOf(_gamePlay.nivel) + 1; //calcula el indice del nivel
    }

    _gamePlay.nivel = GameSettings.niveles[nivelIndex]; //cambia el nivel
    startGame(gamePlay: _gamePlay); //inicia el juego
  }
}
