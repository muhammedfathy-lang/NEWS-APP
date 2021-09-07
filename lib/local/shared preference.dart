
import 'package:shared_preferences/shared_preferences.dart';

class cachHelper{
  static late SharedPreferences sharedPreference;
  static init()async{
    sharedPreference= await  SharedPreferences.getInstance();
  }
static Future<bool> putData ({
  required String key,
  required bool value
})async{
    return await sharedPreference.setBool(key, value);
}
  static bool? getData ({required String key}){
    return  sharedPreference.getBool(key);
  }
}