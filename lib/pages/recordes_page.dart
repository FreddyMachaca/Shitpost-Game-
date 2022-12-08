import 'package:flutter/material.dart';
import 'package:flutter_memory_game/constants.dart';
import 'package:flutter_memory_game/repositories/recordes_repository.dart';
import 'package:flutter_memory_game/theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class RecordesPage extends StatelessWidget {
  final Modo modo;

  const RecordesPage({Key? key, required this.modo}) : super(key: key);

  getModo() {
    return modo == Modo.normal ? 'Normal' : 'Dificil'; //retorna el modo
  }

  List<Widget> getRecordesList(Map recordes) { //funcion para crear la lista de recordes
    final List<Widget> widgets = [];

    recordes.forEach((nivel, score) { //itera sobre la lista de recordes
      widgets.add(ListTile( //agrega un widget a la lista
        title: Text('Nível $nivel'), //titulo del widget
        trailing: Text(score.toString()), //texto al final del widget
        tileColor: Colors.grey[900],//color del widget
        shape: const RoundedRectangleBorder( //forma del widget
          borderRadius: BorderRadius.all(Radius.circular(15)),//radio de la forma
        ),
      ));

      widgets.add(const Divider(color: Colors.transparent)); //agrega un widget a la lista
    });

    if (widgets.isEmpty) { //si la lista esta vacia
      widgets.add( //agrega un widget a la lista
        const Center( //centra el widget
          child: Text('AUN NO AHI RECORDS!'), //texto del widget
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<RecordesRepository>(context);

    return Scaffold( //scaffold es un widget que nos permite crear una pantalla
      appBar: AppBar( //appbar es un widget que nos permite crear una barra de titulo
        title: const Text('Recordes'), //titulo de la barra
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0), //espacio alrededor del widget
        child: Observer( //observer es un widget que nos permite observar cambios en el estado
          builder: (context) => Column( //column es un widget que nos permite crear una columna
            mainAxisAlignment: MainAxisAlignment.start, //alinea los widgets al inicio
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 24), //espacio alrededor del widget
                child: Center( //centra el widget
                  child: Text( //texto del widget
                    'Modo ${getModo()}', //$ es para concatenar
                    style: const TextStyle( //estilo del texto
                        fontSize: 28, color: ShitpostThemeColor.color),
                  ),
                ),
              ),
              ...getRecordesList(modo == Modo.normal //si el modo es normal
                  ? repository.recordesNormal //retorna los recordes normales
                  : repository.recordesRound6), //retorna los recordes dificiles
            ],
          ),
        ),
      ),
    );
  }
}
