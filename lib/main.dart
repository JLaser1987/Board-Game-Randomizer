import 'package:board_game_randomizer/board_game_list_view.dart';
import 'package:board_game_randomizer/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MainApp());
}

final GlobalKey<BoardGameListViewState> _childKey = GlobalKey();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<void> _openListFilter(BuildContext context) async {
    (int?, int?) filterResults = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog();
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
        return FilterDialog();
      },
    );

    var gameTitle = await _childKey.currentState?.viewModel
        .getRandomGameWithFilter(filterResults.$1, filterResults.$2);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(gameTitle!));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Board Games'),
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
