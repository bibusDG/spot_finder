import 'package:get/get.dart';
import '../../../models/new_spot_model.dart';

class ModelController extends GetxController{

    RxString userNickNameText = ''.obs;
    RxString spotPINText = ''.obs;
    String id ='';
    String insertedValue = '';
    RxString spotNameText =''.obs;
    RxString spotDescriptionText =''.obs;
    RxList spotPropertiesText =[].obs;
    RxList spotPhotosText =[].obs;
    RxDouble spotRankText = 5.0.obs;
    RxInt votesCounterText = 1.obs;
    RxInt spotRidersText = 0.obs;


    RxString countryText =''.obs;
    RxString cityText =''.obs;
    RxString postalCodeText =''.obs;
    RxString streetNameText =''.obs;
    RxString streetNumberText =''.obs;
    RxString latitude = ''.obs;
    RxString longitude = ''.obs;

    NewSpotModel createSpot(){
        NewSpotModel newSpot = NewSpotModel(
            id:id,
            spotPIN: spotPINText.value,
            userNickName: userNickNameText.value.toUpperCase(),
            spotName: spotNameText.value.trim().toUpperCase(),
            spotDescription: spotDescriptionText.value.trim().toUpperCase(),
            spotProperties: spotPropertiesText,
            spotPhotos: spotPhotosText,
            spotRank: spotRankText.value,
            votesCounter: votesCounterText.value,
            spotRiders: spotRidersText.value,
            spotAddress: Address(
                countryName: countryText.value.trim().toUpperCase(),
                cityName: cityText.value.trim().toUpperCase(),
                postalCode: postalCodeText.value.trim().toUpperCase(),
                streetName: streetNameText.value.trim().toUpperCase(),
                streetNumber: streetNumberText.value.trim().toUpperCase(),
                lat: latitude.value,
                long: longitude.value
            )
        );
        return newSpot;
    }
}