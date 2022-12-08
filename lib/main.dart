import 'package:flutter/material.dart';
import 'package:flutter_memory_game/controllers/game_controller.dart';
import 'package:flutter_memory_game/pages/home_page.dart';
import 'package:flutter_memory_game/repositories/recordes_repository.dart';
import 'package:flutter_memory_game/theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

/// Inicializa Hive, luego ejecuta la aplicación con un MultiProvider que proporciona un
/// RecordesRepository y GameController
void main() async { //async es necesario para usar await
  await Hive.initFlutter(); // Inicializa Hive
  //await es necesario para esperar a que Hive se inicialice antes de continuar
  runApp(MultiProvider( // MultiProvider proporciona varios objetos a la vez
    providers: [
      Provider<RecordesRepository>(create: (_) => RecordesRepository()),
      // El GameController se inicializa con el RecordesRepository
      ProxyProvider<RecordesRepository, GameController>( // ProxyProvider proporciona un objeto a otro
        update: (_, repo, __) => GameController(recordesRepository: repo),// __ es el GameController y _ es el RecordesRepository
      ),
    ],
    child: const App(), // El App es el widget principal
  ));
}

/// `App` es un `StatelessWidget` que devuelve un `MaterialApp` con un `título`,
/// Un stateless es un widget que se usa para mostrar información en la pantalla.
/// Un statelesswidget No se puede cambiar su estado.
/// A widget that does not require mutable state.
///
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key); //key es un identificador único para un widget

  @override //override es una palabra clave que se usa para sobrescribir un método de la clase padre
  Widget build(BuildContext context) {
    return MaterialApp(   //MaterialApp es un widget que implementa la mayoría de los componentes de Material Design.
      title: 'Shitpost Memory',
      /// `debugShowCheckedModeBanner` establecido en `falso`, un `tema` y una página de `inicio`
      debugShowCheckedModeBanner: false, //debugShowCheckedModeBanner es un booleano que indica si aun esta en desarrollo
      theme: ShitpostThemeColor.theme, //el tema de la app
      home: const HomePage(), //la pagina de inicio
    );
  }
}
