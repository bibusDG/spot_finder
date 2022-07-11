import 'package:get/get.dart';
import '../../../models/new_spot_model.dart';

class ModelController extends GetxController{

    String insertedValue = '';
    RxString spotNameText =''.obs;
    RxString spotDescriptionText =''.obs;
    RxList spotPropertiesText =[].obs;
    RxList spotPhotosText =[].obs;
    RxDouble spotRankText = 0.0.obs;
    RxInt votesCounterText = 0.obs;
    RxInt spotRidersText = 0.obs;


    RxString countryText =''.obs;
    RxString cityText =''.obs;
    RxString postalCodeText =''.obs;
    RxString streetNameText =''.obs;
    RxString streetNumberText =''.obs;

    NewSpotModel createSpot(){
        NewSpotModel newSpot = NewSpotModel(

            spotName: spotNameText.value,
            spotDescription: spotDescriptionText.value,
            spotProperties: spotPropertiesText,
            spotPhotos: spotPhotosText,
            spotRank: spotRankText.value,
            votesCounter: votesCounterText.value,
            spotRiders: spotRidersText.value,
            spotAddress: Address(
                countryName: countryText.value,
                cityName: cityText.value,
                postalCode: postalCodeText.value,
                streetName: streetNameText.value,
                streetNumber: streetNumberText.value,
            )
        );
        return newSpot;
    }

    void buttonPressed(String buttonText){
        if(buttonText == 'Country'){
            // address.countryName = insertedValue;
            countryText.value = insertedValue;
        }
        if (buttonText == 'City'){
            // address.cityName = insertedValue;
            cityText.value = insertedValue;
        }
        if (buttonText == 'Postal code'){
            // address.postalCode = insertedValue;
            postalCodeText.value = insertedValue;
        }
        if (buttonText == 'Street name'){
            // address.streetName = insertedValue;
            streetNameText.value = insertedValue;
        }
        if (buttonText == 'Street number'){
            // address.streetNumber = insertedValue;
            streetNumberText.value = insertedValue;
        }
    }

}