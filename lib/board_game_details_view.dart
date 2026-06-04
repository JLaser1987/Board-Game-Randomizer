import 'package:board_game_randomizer/add_edit_board_game.dart';
import 'package:board_game_randomizer/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'board_game_list_view_model.dart';

class BoardGameDetails extends StatefulWidget {
  BoardGameDetails({super.key, required this.boardGame});

  BoardGame boardGame;

  @override
  State<BoardGameDetails> createState() => _BoardGameDetailsState();
}

class _BoardGameDetailsState extends State<BoardGameDetails> {
  Future<void> _getEditScreenNavigate(BuildContext context) async {
    // The result will capture whatever you passed to Navigator.pop
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditBoardGame(widget.boardGame),
      ),
    );

    // Always verify the result isn't null (e.g., if the user swiped/hit the native back button)
    if (result != null) {
      setState(() {
        widget.boardGame = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents default auto-popping
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // Manually pop the screen with your custom return data
        Navigator.pop(context, widget.boardGame);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => _getEditScreenNavigate(context),
                  icon: Icon(Icons.edit),
                );
              },
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => {
                    viewModelKey.currentState?.viewModel
                        .removeBoardGame(widget.boardGame)
                        .then((result) {
                          if (result) {
                            Navigator.pop(context);
                          }
                        }),
                  },
                  icon: Icon(Icons.delete),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                widget.boardGame.title,
                textAlign: .center,
                style: TextStyle(color: Colors.black, fontSize: 25),
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
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.people),
                  Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0)),
                  Text(
                    '${widget.boardGame.minPlayerCount} - ${widget.boardGame.maxPlayerCount} players',
                    style: TextStyle(color: Colors.black, fontSize: 20),
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
              Row(
                mainAxisAlignment: .center,
                children: [
                  FaIcon(FontAwesomeIcons.clock),
                  Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0)),
                  Text(
                    '${widget.boardGame.estimatedPlayTimeMinutes} minutes',
                    style: TextStyle(color: Colors.black, fontSize: 20),
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
              Text(
                widget.boardGame.extras,
                textAlign: .center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
