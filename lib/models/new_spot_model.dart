import 'dart:convert';
import 'dart:ffi';

NewSpotModel newSpotModelFromJson(String str) => NewSpotModel.fromJson(json.decode(str));

String newSpotModelToJson(NewSpotModel data) => json.encode(data.toJson());

class NewSpotModel{

  String? spotName;
  String? spotDescription;
  List? spotProperties;
  Address? spotAddress;
  // Map<String, dynamic> spotAddress;
  List? spotPhotos;
  double? spotRank;
  int? votesCounter;
  int? spotRiders;


  NewSpotModel({

    this.spotName,
    this.spotDescription,
    this.spotProperties,
    this.spotAddress,
    // required this.spotAddress,
    this.spotPhotos,
    this.spotRank,
    this.votesCounter,
    this.spotRiders,


  });

  // NewSpotModel.fromJson(Map<String, dynamic> parsedJSON)
  //     : spotName = parsedJSON["spotName"],
  //       spotDescription = parsedJSON["spotDescription"],
  //       spotProperties = parsedJSON['spotProperties'],
  //       spotAddress = Address.fromJson(parsedJSON["spotAddress"]),
  //       spotPhotos = parsedJSON['spotPhotos'],
  //       spotRank= parsedJSON['spotRank'],
  //       spotRiders= parsedJSON['spotRiders'];


  factory NewSpotModel.fromJson(Map<String, dynamic> json) => NewSpotModel(

    spotName: json["spotName"],
    spotDescription: json["spotDescription"],
    spotProperties: json['spotProperties'],
    spotAddress: Address.fromJson(json["spotAddress"]),
    spotPhotos: json['spotPhotos'],
    spotRank: json['spotRank'],
    votesCounter: json['votesCounter'],
    spotRiders: json['spotRiders'],

  );

  Map<String, dynamic> toJson(){
    return{

      'spotName': spotName,
      'spotDescription': spotDescription,
      'spotProperties': spotProperties,
      'spotAddress': spotAddress?.toJson(),
      'spotPhotos': spotPhotos,
      'spotRank': spotRank,
      'votesCounter': votesCounter,
      'spotRiders': spotRiders,
    };
  }

}

class Address{
  String? countryName;
  String? postalCode;
  String? cityName;
  String? streetName;
  String? streetNumber;

  Address({
    this.countryName,
    this.postalCode,
    this.cityName,
    this.streetName,
    this.streetNumber,
});

  // Address.fromJson(Map<String, dynamic> parsedJSON)
  //     : countryName = parsedJSON["countryName"],
  //       cityName = parsedJSON["cityName"],
  //       postalCode = parsedJSON['postalCode'],
  //       streetName = parsedJSON['streetName'],
  //       streetNumber = parsedJSON['streetNumber'];


  factory Address.fromJson(Map<String, dynamic> json) => Address(
    countryName: json["countryName"],
    cityName: json["cityName"],
    postalCode: json['postalCode'],
    streetName: json['streetName'],
    streetNumber: json['streetNumber']
  );

  Map<String, dynamic> toJson() {
    return {
      'countryName': countryName,
      'postalCode': postalCode,
      'cityName': cityName,
      'streetName': streetName,
      'streetNumber': streetNumber,
    };
  }
  // Address.fromMap(Map<String, dynamic> addressMap)
  //   : countryName = addressMap['countryName'],
  //     postalCode = addressMap['postalCode'],
  //     cityName = addressMap['cityName'],
  //     streetName = addressMap['streetName'],
  //     streetNumber = addressMap['streetNumber'];


}