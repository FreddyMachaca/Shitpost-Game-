import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/game_settings.dart';
import 'package:flutter_memory_game/models/game_opcao.dart';
import 'package:flutter_memory_game/models/game_play.dart';
import 'package:flutter_memory_game/repositories/recordes_repository.dart';
import 'package:mobx/mobx.dart';

part 'game_controller.g.dart';

class GameController = GameControllerBase with _$GameController;

abstract class GameControllerBase with Store {
  @observable
  List<GameOpcion> gameCards = [];
  @observable
  int score = 0;
  @observable
  bool ganaste = false;
  @observable
  bool perdiste = false;

  late GamePlay _gamePlay;
  List<GameOpcion> _escojer = [];
  List<Function> _escojaCallback = [];
  int _aciertos = 0;
  int _numPares = 0;
  RecordesRepository recordesRepository;

  @computed
  bool get jugadaCompleta => (_escojer.length == 2);

  GameControllerBase({required this.recordesRepository}) {
    reaction((_) => ganaste == true, (bool gano) {
      if (gano) {
        recordesRepository.updateRecordes(gamePlay: _gamePlay, score: score);
      }
    });
  }

  startGame({required GamePlay gamePlay}) {
    _gamePlay = gamePlay;
    _aciertos = 0;
    _numPares = (_gamePlay.nivel / 2).round();
    ganaste = false;
    perdiste = false;
    _resetScore();
    _generateCards();
  }

  _resetScore() {
    _gamePlay.modo == Modo.normal ? score = 0 : score = _gamePlay.nivel;
  }

  _generateCards() {
    List<int> cardOpciones = GameSettings.cardOpcoes.sublist(0)..shuffle();
    cardOpciones = cardOpciones.sublist(0, _numPares);
    gameCards = [...cardOpciones, ...cardOpciones]
        .map((opcion) =>
            GameOpcion(opcion: opcion, matched: false, selected: false))
        .toList();
    gameCards.shuffle();
  }

  escojer(GameOpcion opcion, Function resetCard) async {
    opcion.selected = true;
    _escojer.add(opcion);
    _escojaCallback.add(resetCard);
    await _compararEscolhas();
  }

  _compararEscolhas() async {
    if (jugadaCompleta) {
      if (_escojer[0].opcion == _escojer[1].opcion) {
        _aciertos++;
        _escojer[0].matched = true;
        _escojer[1].matched = true;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          for (var i in [0, 1]) {
            _escojer[i].selected = false;
            _escojaCallback[i]();
          }
        });
      }

      _resetJugada();
      _updateScore();
      _checkGameResult();
    }
  }

  _checkGameResult() async {
    bool allMatched = _aciertos == _numPares;
    if (_gamePlay.modo == Modo.normal) {
      await _checkResultModoNormal(allMatched);
    } else {
      await _checkResultModoRound6(allMatched);
    }
  }

  _checkResultModoNormal(bool allMatched) async {
    await Future.delayed(
        const Duration(seconds: 1), () => ganaste = allMatched);
  }

  _checkResultModoRound6(bool allMatched) async {
    if (_chancesAcabaram()) {
      await Future.delayed(
          const Duration(milliseconds: 400), () => perdiste = true);
    }
    if (allMatched && score >= 0) {
      await Future.delayed(
          const Duration(seconds: 1), () => ganaste = allMatched);
    }
  }

  _chancesAcabaram() {
    return score < _numPares - _aciertos;
  }

  _resetJugada() {
    _escojer = [];
    _escojaCallback = [];
  }

  _updateScore() {
    _gamePlay.modo == Modo.normal ? score++ : score--;
  }

  restartGame() {
    startGame(gamePlay: _gamePlay);
  }

  nextLevel() {
    int nivelIndex = 0;

    if (_gamePlay.nivel != GameSettings.niveles.last) {
      nivelIndex = GameSettings.niveles.indexOf(_gamePlay.nivel) + 1;
    }

    _gamePlay.nivel = GameSettings.niveles[nivelIndex];
    startGame(gamePlay: _gamePlay);
  }
}
