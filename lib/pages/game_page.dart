import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/controllers/game_controller.dart';
import 'package:flutter_memory_game/game_settings.dart';
import 'package:flutter_memory_game/models/game_opcao.dart';
import 'package:flutter_memory_game/models/game_play.dart';
import 'package:flutter_memory_game/theme.dart';
import 'package:flutter_memory_game/widgets/card_game.dart';
import 'package:flutter_memory_game/widgets/feedback_game.dart';
import 'package:flutter_memory_game/widgets/game_score.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget { //clase GamePage
  final GamePlay gamePlay; //variable para guardar el juego

  const GamePage({Key? key, required this.gamePlay}) : super(key: key); //constructor

  @override
  Widget build(BuildContext context) { //funcion para construir el widget
    final controller = Provider.of<GameController>(context); //variable para guardar el controlador
    return Scaffold( //scaffold es un widget que nos permite crear una pantalla
      appBar: AppBar( //appbar es un widget que nos permite crear una barra de titulo
        automaticallyImplyLeading: false, //automaticamente no implica un boton de regreso
        title: GameScore(modo: gamePlay.modo), //titulo de la barra
      ),
      // body: const FeedbackGame(resultado: Resultado.eliminado),

      body: Observer( //observer es un widget que nos permite observar los cambios en las variables
        builder: (_) { //funcion para construir el widget
          if (controller.ganaste) { //si gano es true
            return const FeedbackGame(resultado: Resultado.aprobado); //retorna el widget FeedbackGame con el resultado aprobado
          } else if (controller.perdiste) { //si perdio es false
            return const FeedbackGame(resultado: Resultado.eliminado); //retorna el widget FeedbackGame con el resultado eliminado
          } else {
            return Center( //centra el widget
              child: GridView.count( //gridview es un widget que nos permite crear una cuadricula
                shrinkWrap: true, //shrinkwrap es un widget que nos permite ajustar el tamaño del widget
                crossAxisCount: GameSettings.gameBoardAxisCount(gamePlay.nivel), //numero de columnas
                mainAxisSpacing: 15, //espacio entre filas
                crossAxisSpacing: 15, //espacio entre columnas
                padding: const EdgeInsets.all(24), //padding es un widget que nos permite agregar un espacio alrededor del widget
                children: controller.gameCards //lista de widgets
                    .map( //map es un metodo que nos permite iterar sobre una lista
                      (GameOpcion go) =>
                          CardGame(modo: gamePlay.modo, gameOpcion: go), //retorna el widget CardGame
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
