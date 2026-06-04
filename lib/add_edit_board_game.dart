import 'package:board_game_randomizer/board_game_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'board_game_list_view_model.dart';

class AddEditBoardGame extends StatelessWidget {
  AddEditBoardGame(BoardGame? boardGame, {super.key}) {
    _titleTextFieldController.text = "";
    _minPlayerCountTextFieldController.text = "";
    _maxPlayerCountTextFieldController.text = "";
    _estimatedPlayTimeTextFieldController.text = "";
    _extrasTextFieldController.text = "";

    this.boardGame = boardGame;

    if (boardGame != null) {
      _titleTextFieldController.text = boardGame.title;
      _minPlayerCountTextFieldController.text = "${boardGame.minPlayerCount}";
      _maxPlayerCountTextFieldController.text = "${boardGame.maxPlayerCount}";
      _estimatedPlayTimeTextFieldController.text =
          "${boardGame.estimatedPlayTimeMinutes}";
      _extrasTextFieldController.text = boardGame.extras;
    }
  }

  final BoardGameListViewModel viewModel = BoardGameListViewModel(
    BoardGameListModel(),
  );

  late final BoardGame? boardGame;

  static final TextEditingController _titleTextFieldController =
      TextEditingController();

  static final TextEditingController _minPlayerCountTextFieldController =
      TextEditingController();

  static final TextEditingController _maxPlayerCountTextFieldController =
      TextEditingController();

  static final TextEditingController _estimatedPlayTimeTextFieldController =
      TextEditingController();

  static final TextEditingController _extrasTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  BoardGame saveGame = BoardGame(
                    title: _titleTextFieldController.text,
                    minPlayerCount: int.parse(
                      _minPlayerCountTextFieldController.text,
                    ),
                    maxPlayerCount: int.parse(
                      _maxPlayerCountTextFieldController.text,
                    ),
                    estimatedPlayTimeMinutes: int.parse(
                      _estimatedPlayTimeTextFieldController.text,
                    ),
                    extras: _extrasTextFieldController.text,
                    owned: true,
                  );
                  final boardGame = this.boardGame;
                  if (boardGame != null) {
                    saveGame.row = boardGame.row;
                  }

                  viewModel.saveBoardGame(saveGame).then((result) {
                    if (result) {
                      Navigator.pop(context, saveGame);
                    }
                  });
                },
                icon: Icon(Icons.save),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Game Title:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: .bold,
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: _titleTextFieldController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Text(
                "Player Count:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: .bold,
                ),
              ),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Minimum Players:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 75,
                      child: TextField(
                        keyboardType:
                            TextInputType.number, // Opens the numeric keyboard
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Limits input to only digits (0-9)
                        ],
                        controller: _minPlayerCountTextFieldController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Maximum Players:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 75,
                      child: TextField(
                        keyboardType:
                            TextInputType.number, // Opens the numeric keyboard
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Limits input to only digits (0-9)
                        ],
                        controller: _maxPlayerCountTextFieldController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Text(
                "Estimated Playtime:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: .bold,
                ),
              ),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Minutes:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 75,
                      child: TextField(
                        keyboardType:
                            TextInputType.number, // Opens the numeric keyboard
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Limits input to only digits (0-9)
                        ],
                        controller: _estimatedPlayTimeTextFieldController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Text(
                "Additional Items:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: .bold,
                ),
              ),
              Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  controller: _extrasTextFieldController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
