import 'package:board_game_randomizer/board_game_list_model.dart';
import 'package:board_game_randomizer/board_game_list_view_model.dart';
import 'package:flutter/material.dart';

class BoardGameListView extends StatefulWidget {
  const BoardGameListView({super.key});

  @override
  State<BoardGameListView> createState() => _BoardGameListViewState();
}

class _BoardGameListViewState extends State<BoardGameListView> {
  final BoardGameListViewModel viewModel = BoardGameListViewModel(
    BoardGameListModel(),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.filteredBoardGames.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(viewModel.filteredBoardGames[index]));
      },
    );
  }
}
