import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void showCustomAlertBox(BuildContext context, String message, VoidCallback onYesPressed) {
  final size = MediaQuery.of(context).size;
  final width = size.width;
  final height = size.height;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding: EdgeInsets.all(width * 0.02),
        content: Text(
          message,
          style: TextStyle(fontSize: width * 0.015), // Adjust font size based on screen
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: width * 0.06,
              height: height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: width * 0.002,
                ),
                borderRadius: BorderRadius.circular(width * 0.01),
              ),
              child: Center(
                child: Text(
                  'No',
                  style: TextStyle(fontSize: width * 0.012),
                ),
              ),
            ),
          ),
          SizedBox(width: width * 0.02),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              onYesPressed();
            },
            child: Container(
              width: width * 0.06,
              height: height * 0.045,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: width * 0.002,
                ),
                borderRadius: BorderRadius.circular(width * 0.01),
              ),
              child: Center(
                child: Text(
                  'Yes',
                  style: TextStyle(fontSize: width * 0.012),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<bool?> showCustomAlertBoxss(BuildContext context, String message) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirmation'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

