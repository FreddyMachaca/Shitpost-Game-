import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/controllers/game_controller.dart';
import 'package:flutter_memory_game/widgets/start_button.dart';
import 'package:provider/provider.dart';

class FeedbackGame extends StatelessWidget {
  final Resultado resultado;

  const FeedbackGame({Key? key, required this.resultado}) : super(key: key);

  String getResultado() {
    return resultado == Resultado.aprobado ? 'aprovado' : 'eliminado';
    // Si el resultado es aprobado retornar aprovado, si no retornar eliminado
  }

  @override
  Widget build(BuildContext context) { // Construir
    final controller = context.read<GameController>(); // Leer el controlador
    return Padding( // Padding
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12), // Vertical 60, horizontal 12
      child: Column( // Columna
        mainAxisAlignment: MainAxisAlignment.start,// Alineacion al inicio
        children: [
          Text(
            '${getResultado().toUpperCase()}!', // Texto
            style: const TextStyle(fontSize: 30), // Estilo
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30), // Vertical 30
            child: Image.asset('images/${getResultado()}.png'), // Imagen
          ),
          resultado == Resultado.eliminado // Si el resultado es eliminado
              ? StartButton( // Boton de inicio
                  title: 'Intente de nuevo', // Titulo
                  color: Colors.white, // Color blanco
                  action: () => controller.restartGame(), // Reiniciar juego
                )
              : StartButton( // Boton de inicio
                  title: 'Próximo Nível', // Titulo
                  color: Colors.white, // Color blanco
                  action: () => controller.nextLevel(), // Siguiente nivel
                ),
        ],
      ),
    );
  }
}
