import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';


class MyWidget extends StatelessWidget {
  const MyWidget({
    Key? key,
    required this.modelController, required this.helperText, required this.finalText
  }) : super(key: key);

  final ModelController modelController;
  final String helperText;
  final String finalText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: (String value){

          modelController.insertedValue = value;
          modelController.buttonPressed(helperText);
        },
        minLines: 1,
        maxLines: 1,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            helperText: helperText,
            helperStyle: TextStyle(fontSize: 15.0),
            hintText: finalText,
            hintStyle: TextStyle(
                color: Colors.grey
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
      ),
    );
  }
}
