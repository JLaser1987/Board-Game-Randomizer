import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    super.key,
    required this.playerCountTextFieldController,
    required this.playTimeTextFieldController,
  });

  final TextEditingController playerCountTextFieldController;
  final TextEditingController playTimeTextFieldController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text('test', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Number of players:'),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType:
                          TextInputType.number, // Opens the numeric keyboard
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Limits input to only digits (0-9)
                      ],
                      controller: playerCountTextFieldController,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Playtime:'),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType:
                          TextInputType.number, // Opens the numeric keyboard
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Limits input to only digits (0-9)
                      ],
                      controller: playTimeTextFieldController,
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
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () {}, child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            Navigator.pop(context, (
              int.tryParse(playerCountTextFieldController.text),
              int.tryParse(playTimeTextFieldController.text),
            ));
          },
          child: const Text('Okay'),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 8.0,
    );
  }
}
