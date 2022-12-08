import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/pages/nivel_page.dart';
import 'package:flutter_memory_game/theme.dart';
import 'package:flutter_memory_game/widgets/logo.dart';
import 'package:flutter_memory_game/widgets/recordes.dart';
import 'package:flutter_memory_game/widgets/start_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  selecionarNivel(Modo modo, BuildContext context) async { //async es necesario para usar await
    await Navigator.push( //Navigator es un widget que administra una pila de rutas
      // y proporciona métodos para gestionar la pila, como Navigator.push y Navigator.pop.
      // Navigator.push es un método que se usa para navegar a una nueva ruta y esperar a que se complete.
      //Navigator.pop es un método que se usa para volver a la ruta anterior.
      context,
      MaterialPageRoute( //MaterialPageRoute es una clase que implementa la transición de una página a otra.
        builder: (context) => NivelPage(modo: modo), //builder es un método que se usa para construir una nueva ruta.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //Scaffold es un widget que implementa la estructura visual básica de Material Design.
      body: Padding( //Padding es un widget que inserta un borde alrededor.
        padding: const EdgeInsets.all(24.0), //EdgeInsets es un widget que representa los bordes de un rectángulo.
        child: Column( //Column es un widget que implementa una columna vertical.
          mainAxisAlignment: MainAxisAlignment.center, //alinea sus objetos en el eje principal
          crossAxisAlignment: CrossAxisAlignment.center, // alinea sus objetos en el eje transversal
          children: [ //children es una lista de widgets
            const Logo(), //Logo es un widget que muestra el logo de la app
            StartButton( //StartButton es un widget que muestra un botón de inicio
              title: 'Modo Normal', //title es el titulo del boton
              color: Colors.white, //color es el color del boton
              action: () => selecionarNivel(Modo.normal, context), //action es la accion que se ejecuta al presionar el boton
            ),
            StartButton(
              title: 'Modo Insano',
              color: ShitpostThemeColor.color, //color es el color del boton
              action: () => selecionarNivel(Modo.dificil, context), //action es la accion que se ejecuta al presionar el boton
            ),
            const SizedBox(height: 60), //SizedBox le da un tamaño fijo
            const Recordes(), //Recordes es un widget que muestra los recordes
          ],
        ),
      ),
    );
  }
}
