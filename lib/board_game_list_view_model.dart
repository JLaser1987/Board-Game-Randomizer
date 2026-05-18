import 'package:board_game_randomizer/board_game_list_model.dart';
import 'package:flutter/material.dart';

class BoardGameListViewModel extends ChangeNotifier {
  final BoardGameListModel model;
  List<String> filteredBoardGames = [];

  BoardGameListViewModel(this.model) {
    filteredBoardGames = model.boardGames;
  }
}
