import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spot_finder/views/detailed_spot/controllers/detailed_spot_controller.dart';
import 'package:skate_spot_finder/views/newSpot/controllers/model_controller.dart';

class GeoLocation {

  ModelController modelController = Get.find();
  DetailedPageController detailedPageController = Get.find();

  /// GEOLOCATION SETUP
  ///
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Get.snackbar('GPS', 'GPS Activated');
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, timeLimit: Duration(seconds: 5));

  }
  get determinePosition => _determinePosition();

  void finalPosition() async{
    Position position = await determinePosition;
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    if (placemarks.length != 0){
      Get.snackbar(duration: Duration(seconds: 5), 'GPS location', 'Location saved successfully');
      modelController.latitude.value = position.latitude.toString();
      modelController.longitude.value = position.longitude.toString();

      modelController.countryText.value = placemarks[0].country.toString();
      modelController.cityText.value = placemarks[0].locality.toString();
      modelController.postalCodeText.value = placemarks[0].postalCode.toString();
      modelController.streetNameText.value = placemarks[0].street.toString();
      // modelController.streetNumberText.value = placemarks.join(',').split(',')[0].split((':'))[1];

      // modelController.countryText.value = placemarks.join(',').split(',')[3].split((':'))[1];
      // modelController.cityText.value = placemarks.join(',').split(',')[7].split((':'))[1];
      // modelController.postalCodeText.value = placemarks.join(',').split(',')[4].split((':'))[1];
      // modelController.streetNameText.value = placemarks.join(',').split(',')[9].split((':'))[1];
      // modelController.streetNumberText.value = placemarks.join(',').split(',')[0].split((':'))[1];
    }else{

    }
  }

  // get determinePosition => _determinePosition();
}

