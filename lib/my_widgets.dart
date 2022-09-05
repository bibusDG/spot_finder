import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/findSpot/controllers/findSpot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';

class MyHomeIcon extends StatelessWidget {
  const MyHomeIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/mainPage');
        Get.deleteAll();
      },
      child: Icon(
        Icons.home_outlined,
        size: 35.0,
      ),
    );
  }
}

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({
    Key? key,
    required this.modelController, required this.helperText, required this.infoText,
  }) : super(key: key);

  final ModelController modelController;
  final String helperText;
  final String infoText;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        onChanged: (String value) {
          modelController.insertedValue = value;
          buttonPressed(helperText);
        },
        minLines: 1,
        maxLines: 1,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(onTap:(){
            Get.defaultDialog(title: 'INFO', content: Text(infoText));
          },child: Icon(Icons.info_outline)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.black, width: 4.0),),
            helperText: helperText,
            helperStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w200, color: Colors.black),
            // hintText: finalText,
            hintStyle: TextStyle(
                color: Colors.white
            ),

        ),
      ),
    );
  }

  void buttonPressed(String buttonText) {
    if (buttonText == 'Your nick name') {
      modelController.userNickNameText.value = modelController.insertedValue;
    }
    if (buttonText == 'Country') {
      modelController.countryText.value = modelController.insertedValue;
    }
    if (buttonText == 'City') {
      modelController.cityText.value = modelController.insertedValue;
    }
    if (buttonText == 'Postal code') {
      modelController.postalCodeText.value = modelController.insertedValue;
    }
    if (buttonText == 'Street name') {
      modelController.streetNameText.value = modelController.insertedValue;
    }
    if (buttonText == 'Street number') {
      modelController.streetNumberText.value = modelController.insertedValue;
    }
    if (buttonText == 'Spot name') {
      modelController.spotNameText.value = modelController.insertedValue;
    }
    if (buttonText == 'Spot description') {
      modelController.spotDescriptionText.value = modelController.insertedValue;
    }
  }
}

class MyCancelButton extends StatelessWidget {
  const MyCancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: 250.0,
      child: OutlinedButton(
        onPressed: () {
          Get.toNamed('/mainPage');
          Get.deleteAll();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: StadiumBorder(),
          // side: BorderSide(color: Colors.teal, width: 5.0),
        ),
        child: Text(
          'CANCEL',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}

class MyNextOutlinedButton extends StatelessWidget {
  const MyNextOutlinedButton({
    Key? key, required this.onPressedValid, required this.goTo,
  }) : super(key: key);
  final bool onPressedValid;
  final String goTo;

  @override
  Widget build(BuildContext context) {
    if (onPressedValid == false) {
      return SizedBox(
        height: 60.0,
        width: 250.0,
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: Colors.black
          ),
          child: Text(
            'NEXT',
            style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 60.0,
        width: 250.0,
        child: OutlinedButton(
          onPressed: () {
            goToPage();
          },
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: Colors.black
          ),
          child: Text(
            'NEXT',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      );
    }
  }

  void goToPage() {
    if (goTo == 'photoPage') {
      Get.toNamed('/photoPage');
    }
    if (goTo == 'gpsPage') {
      Get.toNamed('/gpsPage');
    }
  }
}

class MyDetailCard extends StatelessWidget {
  const MyDetailCard({
    Key? key,
    required this.detailedPageController, required this.cardText,
  }) : super(key: key);

  final DetailedPageController detailedPageController;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      height: 130.0,
      width: 320.0,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cardText,
                style: TextStyle(
                    color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
              )),
          Builder(
            builder: (controller) {
              if (cardText == 'ADDRESS') {
                return Text(
                  ' ${detailedPageController.data['spotAddress']['countryName']
                      ?.toUpperCase()}\n '
                      '${detailedPageController.data['spotAddress']['postalCode']
                      ?.toUpperCase()} '
                      '${detailedPageController.data['spotAddress']['cityName']
                      ?.toUpperCase()}\n '
                      '${detailedPageController.data['spotAddress']['streetName']
                      ?.toUpperCase()} '
                      '${detailedPageController.data['spotAddress']['streetNumber']
                      ?.toUpperCase()}',
                  style: TextStyle(
                      fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w800),
                );
              }
              if (cardText == 'DESCRIPTION'){
                return Text(
                    '${detailedPageController.data['spotDescription']
                        .toUpperCase()}',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800));
              }
              else {
                return Text(
                    '${detailedPageController.data['spotProperties']
                        .join(', ')
                        .toUpperCase()}',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800));

              }
            },
          ),
        ],
      ),
    );
  }
}

class MyDropDownMenu extends StatelessWidget {
  const MyDropDownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FindSpotController findSpotController = Get.find();

    final List<String> dropMenu = ['Search', 'All'];

    return GetX<FindSpotController>(
      builder: (controller) {
        return DropdownButton(
            value: controller.dropDownItem.value,
            icon: Icon(Icons.search),
            items: dropMenu.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              controller.dropDownItem.value = newValue!;
              if(newValue == 'Search'){
                Get.defaultDialog();
              }
            }


        );
      },
    );
  }
}