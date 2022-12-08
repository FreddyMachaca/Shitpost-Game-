import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/pages/recordes_page.dart';
import 'package:flutter_memory_game/theme.dart';

class Recordes extends StatefulWidget {
  const Recordes({Key? key}) : super(key: key);

  @override
  State<Recordes> createState() => _RecordesState(); // Estado
}

class _RecordesState extends State<Recordes> {
  showRecordes(Modo modo) async { // Mostrar recordes
    await Navigator.push( // Navegar a la pagina de recordes con el modo de juego
    //push es para navegar a otra pagina
    //pop es para regresar a la pagina anterior
      context, // Contexto
      MaterialPageRoute( // Ruta
        builder: (BuildContext context) => RecordesPage(modo: modo), // Construir
      ),
    );
  }

  @override
  Widget build(BuildContext context) { // Construir
    return Card( // Carta
      color: Colors.grey[900], // Color gris
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Padding de 12
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alineacion a la izquierda
          children: [ // Lista de widgets
            const Padding(
              padding: EdgeInsets.all(12), // Padding de 12
              child: Text(
                'Records',
                style: TextStyle(
                  color: ShitpostThemeColor.color, // Color de la tematica
                  fontSize: 22, // Tamaño de la fuente
                ),
              ),
            ),
            ListTile(
              title: const Text('Modo Normal'), // Titulo
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.normal), // Mostrar recordes
            ),
            ListTile(
              title: const Text('Modo Insano'), // Titulo
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.dificil), // Mostrar recordes
            )
          ],
        ),
      ),
    );
  }
}
