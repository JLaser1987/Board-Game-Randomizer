import 'package:board_game_randomizer/board_game_list_view.dart';
import 'package:board_game_randomizer/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MainApp());
}

final GlobalKey<BoardGameListViewState> _childKey = GlobalKey();

final TextEditingController _playerCountFilterTextFieldController =
    TextEditingController();
final TextEditingController _playTimeFilterTextFieldController =
    TextEditingController();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<void> _openListFilter(BuildContext context) async {
    (int?, int?) filterResults = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(
          playerCountTextFieldController: _playerCountFilterTextFieldController,
          playTimeTextFieldController: _playTimeFilterTextFieldController,
          title: 'Filter Game List',
        );
      },
    );

    _childKey.currentState?.viewModel.filterBoardGames(
      filterResults.$1,
      filterResults.$2,
    );
  }

  Future<void> _getRandomGame(BuildContext context) async {
    (int?, int?) filterResults = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(
          playerCountTextFieldController: _playerCountFilterTextFieldController,
          playTimeTextFieldController: _playTimeFilterTextFieldController,
          title: 'Random Game Limits',
        );
      },
    );

    var boardGame = await _childKey.currentState?.viewModel
        .getRandomGameWithFilter(filterResults.$1, filterResults.$2);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (boardGame == null) {
          return AlertDialog(
            title: Center(child: Text('No games match criteria')),
          );
        } else {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    boardGame.title,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "${boardGame.minPlayerCount} - ${boardGame.maxPlayerCount} players | ${boardGame.estimatedPlayTimeMinutes} minutes",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 73, 73, 73),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Board Games')),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    _openListFilter(context);
                  },
                  icon: FaIcon(FontAwesomeIcons.sliders),
                );
              },
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    _getRandomGame(context);
                  },
                  icon: FaIcon(FontAwesomeIcons.dice),
                );
              },
            ),
          ],
        ),
        body: Center(child: BoardGameListView(key: _childKey)),
      ),
    );
  }
}
