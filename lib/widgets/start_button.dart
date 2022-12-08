import 'package:flutter/material.dart';
import 'package:flutter_memory_game/theme.dart';

class StartButton extends StatelessWidget {
  final String title; // Titulo
  final Color color; // Color
  final Function action; // Accion

  const StartButton({ // Constructor
    Key? key,
    required this.title,
    required this.color,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { // Construir
    return Padding( // Padding
      padding: const EdgeInsets.only(top: 24), // Espacio de 24
      child: OutlinedButton( // Boton
        style: ShitpostThemeColor.outlineButtonStyle(color: color), // Estilo
        onPressed: () => action(), // Accion
        child: Row( // Fila
          mainAxisAlignment: MainAxisAlignment.center, // Alineacion al centro
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20), // Estilo
            )
          ],
        ),
      ),
    );
  }
}
