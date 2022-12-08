import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/controllers/game_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class GameScore extends StatelessWidget {
  final Modo modo;
  const GameScore({Key? key, required this.modo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context); // Leer el controlador

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alineacion entre espacios
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Alineacion al inicio
          children: [
            Icon(modo == Modo.dificil // Si el modo es dificil
                ? Icons.my_location
                : Icons.touch_app_rounded),
            const SizedBox(width: 10), // Espacio de 10
            Observer( // Observador
                builder: (_) => Text(controller.score.toString(),
                    style: const TextStyle(fontSize: 25))),
          ],
        ),
        Image.asset('images/host.png', width: 38, height: 60), // Imagen
        TextButton(
          child: const Text('Salir', style: TextStyle(fontSize: 18)), // Texto
          onPressed: () => Navigator.pop(context), // Salir
        ),
      ],
    );
  }
}
