import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/game_settings.dart';
import 'package:flutter_memory_game/models/game_play.dart';
import 'package:flutter_memory_game/widgets/card_nivel.dart';

class NivelPage extends StatelessWidget {
  final Modo modo;

  const NivelPage({Key? key, required this.modo}) : super(key: key);//constructor

  @override
  Widget build(BuildContext context) { //funcion para construir el widget
    final niveis = GameSettings.niveles//variable para guardar los niveles
        .map((n) => CardNivel(gamePlay: GamePlay(modo: modo, nivel: n)))//map es un metodo que nos permite iterar sobre una lista
        .toList();
    return Scaffold(//scaffold es un widget que nos permite crear una pantalla
      appBar: AppBar(//appbar es un widget que nos permite crear una barra de titulo
        title: const Text('Nível del Juego'),//titulo de la barra
      ),
      body: Padding(//padding es un widget que nos permite agregar un espacio alrededor del widget
        padding: const EdgeInsets.only(top: 48),
        child: GridView.count(//gridview es un widget que nos permite crear una cuadricula
          crossAxisCount: 3,
          mainAxisSpacing: 20, //espacio entre filas
          crossAxisSpacing: 20, //espacio entre columnas
          padding: const EdgeInsets.all(24),
          children: niveis, //lista de widgets
        ),
      ),
    );
  }
}
