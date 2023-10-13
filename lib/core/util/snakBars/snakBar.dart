import 'package:flutter/material.dart';

buildSnakBar(
    bool addedOrRemove, BuildContext context, void Function() onpress) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1200),
      elevation: 6.0,
      dismissDirection: DismissDirection.startToEnd,
      behavior: SnackBarBehavior.floating,
      backgroundColor: addedOrRemove ? Colors.green : Colors.red,
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          onpress();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              padding: const EdgeInsets.symmetric(vertical: 10),
              content: Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Changes Was Undo",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 900),
              elevation: 6.0,
              dismissDirection: DismissDirection.horizontal,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.blueGrey.shade900,
            ),
          );
        },
        backgroundColor: Colors.white,
        textColor: Colors.black,
      ),
      content: Container(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          snakMessage[addedOrRemove]!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Map<bool, String> snakMessage = {
  true: "Song Has Successfuly Added To Favoraite",
  false: "Song Has Successfuly Removed From Favoraite"
};
