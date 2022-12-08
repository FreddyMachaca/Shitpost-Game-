import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/controllers/game_controller.dart';
import 'package:flutter_memory_game/models/game_play.dart';
import 'package:flutter_memory_game/pages/game_page.dart';
import 'package:flutter_memory_game/theme.dart';
import 'package:provider/provider.dart';

class CardNivel extends StatelessWidget { // Carta de nivel
  final GamePlay gamePlay; // Juego

  const CardNivel({Key? key, required this.gamePlay}) : super(key: key); // Constructor

  startGame(BuildContext context) { // Iniciar juego
    context.read<GameController>().startGame(gamePlay: gamePlay); // Leer el juego

    Navigator.push( // Navegacion
      context, // Contexto
      MaterialPageRoute( // Ruta
        fullscreenDialog: true, // Dialogo a pantalla completa
        builder: (BuildContext context) => GamePage(gamePlay: gamePlay), // Construir
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell( // Boton
      onTap: () => startGame(context), // Iniciar juego
      borderRadius: const BorderRadius.all(Radius.circular(10)), // Borde redondeado
      child: Container( // Contenedor
        width: 90, // Ancho
        height: 90, // Alto
        padding: const EdgeInsets.all(8), // Padding de 8
        decoration: BoxDecoration( // Decoracion
          border: Border.all( // Borde
            color: gamePlay.modo == Modo.normal // Si el modo es normal
                ? Colors.white // Color blanco
                : ShitpostThemeColor.color, // Color de la tematica
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)), // Borde redondeado
          color: gamePlay.modo == Modo.normal // Si el modo es normal
              ? Colors.transparent // Color transparente
              : ShitpostThemeColor.color.withOpacity(.6), // Color de la tematica con opacidad
        ),
        child: Center( // Centrar
          child: Text(gamePlay.nivel.toString(), // Texto
              style: const TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
