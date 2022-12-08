import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/controllers/game_controller.dart';
import 'package:flutter_memory_game/models/game_opcao.dart';
import 'package:flutter_memory_game/theme.dart';
import 'package:provider/provider.dart';

class CardGame extends StatefulWidget {
  final Modo modo; // Modo de jogo
  final GameOpcion gameOpcion; // Opção de jogo

  const CardGame({ // Construtor
    Key? key,
    required this.modo,
    required this.gameOpcion,
  }) : super(key: key);

  @override
  State<CardGame> createState() => _CardGameState(); // Estado
}

class _CardGameState extends State<CardGame>
    with SingleTickerProviderStateMixin { // Animacion
  late final AnimationController animation; // Controlador de animacion

  @override
  void initState() { // Inicializar
    super.initState(); // Super
    animation = AnimationController( // Controlador de animacion
      vsync: this, // vsync
      duration: const Duration(milliseconds: 400), // Duracion
    );
  }

  @override
  void dispose() { // Dispose es para liberar recursos
    animation.dispose(); // Dispose de la animacion
    super.dispose();  // Super
  }

  AssetImage getImage(double angulo) { // Obtener imagen
    if (angulo > 0.5 * pi) { // Si el angulo es mayor a la mitad del pi
      return AssetImage('images/${widget.gameOpcion.opcion.toString()}.png'); // Retornar la imagen
    } else { // Si no
      return widget.modo == Modo.normal // Si el modo es normal
          ? const AssetImage('images/card_normal.png') // Retornar la imagen
          : const AssetImage('images/card_round.png'); // Retornar la imagen
    }
  }

  flipCard() { // Girar la carta
    final game = context.read<GameController>(); // Leer el juego

    if (!animation.isAnimating && // Si la animacion no esta animando
        !widget.gameOpcion.matched && // Si la opcion no esta emparejada
        !widget.gameOpcion.selected && // Si la opcion no esta seleccionada
        !game.jugadaCompleta) { // Si la jugada no esta completa
      animation.forward(); // Animacion hacia adelante
      game.escojer(widget.gameOpcion, resetCard); // Escojer la opcion
    }
  }

  resetCard() { // Resetear la carta
    animation.reverse(); // Animacion hacia atras
  }

  @override
  Widget build(BuildContext context) { // Construir
    return AnimatedBuilder( // Construir animacion
      animation: animation, // Animacion
      builder: (BuildContext context, _) { // Builder
        final angulo = animation.value * pi; // Obtener el angulo
        final transform = Matrix4.identity() // Matriz de identidad
          ..setEntry(3, 2, 0.002) // Entrada
          ..rotateY(angulo); // Rotar en Y

        return GestureDetector( // Detectar gestos
          onTap: () => flipCard(), // Al tocar la carta
          child: Transform( // Transformar
            transform: transform, // Transformar
            alignment: Alignment.center, // Alineacion
            child: Container( // Contenedor
              decoration: BoxDecoration( // Decoracion
                border: Border.all( // Borde
                  color: widget.modo == Modo.normal // Si el modo es normal
                      ? Colors.white // Color blanco
                      : ShitpostThemeColor.color, // Color de la tematica
                  width: 2, // Ancho
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5)), // Borde redondeado
                image: DecorationImage( // Imagen de decoracion
                  fit: BoxFit.cover, // Ajustar
                  image: getImage(angulo), // Obtener imagen
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
