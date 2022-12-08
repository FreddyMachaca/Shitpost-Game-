import 'package:flutter/material.dart';
import 'package:flutter_memory_game/theme.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20), // Espacio de 20
          child: Image.asset('images/host.png', width: 200, height: 125), // detalles de la Imagen
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40), // Espacio de 40
          child: RichText( // Texto enriquecido
            text: TextSpan( // Texto enriquecido
              text: 'SHITPOST ', // Texto
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30), // Estilo
              children: const [
                TextSpan(
                  text: 'Memory', // Texto
                  style: TextStyle(color: ShitpostThemeColor.color), // Estilo
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
