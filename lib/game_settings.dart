class GameSettings {
  static const niveles = [6, 8, 10, 12, 16, 18, 20, 24, 28]; // Niveles

  static const cardOpcoes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]; // Opciones de cartas

  static gameBoardAxisCount(int nivel) { // Eje de tablero de juego
    if (nivel < 10) { // Si el nivel es menor a 10
      return 2; // Retornar 2
    } else if (nivel == 10 || nivel == 12 || nivel == 18) { // Si el nivel es 10, 12 o 18
      return 3; // Retornar 3
    } else { // Si no
      return 4; // Retornar 4
    }
  }
}
