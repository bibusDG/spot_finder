import 'dart:convert';
import 'dart:ffi';

NewSpotModel newSpotModelFromJson(String str) => NewSpotModel.fromJson(json.decode(str));

String newSpotModelToJson(NewSpotModel data) => json.encode(data.toJson());

class NewSpotModel{

  String? spotName;
  String? spotDescription;
  List? spotProperties;
  Address? spotAddress;
  List? spotPhotos;
  double? spotRank;
  int? votesCounter;
  int? spotRiders;
  String? id;


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
    this.id,


  });

  factory NewSpotModel.fromJson(Map<String, dynamic> json) => NewSpotModel(

    id:json['id'],
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
      'id': id,
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
  String? lat;
  String? long;

  Address({
    this.countryName,
    this.postalCode,
    this.cityName,
    this.streetName,
    this.streetNumber,
    this.lat,
    this.long,
});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    countryName: json["countryName"],
    cityName: json["cityName"],
    postalCode: json['postalCode'],
    streetName: json['streetName'],
    streetNumber: json['streetNumber'],
    lat: json['latitude'],
    long: json['longitude']
  );

  Map<String, dynamic> toJson() {
    return {
      'countryName': countryName,
      'postalCode': postalCode,
      'cityName': cityName,
      'streetName': streetName,
      'streetNumber': streetNumber,
      'latitude': lat,
      'longitude': long,
    };
  }
}