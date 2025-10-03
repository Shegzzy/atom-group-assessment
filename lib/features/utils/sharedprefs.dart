import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._privateConstructor();
  static final SharedPrefs instance = SharedPrefs._privateConstructor();
  SharedPreferences? myPrefs;

  Future<void> initializePreference() async{
    myPrefs = await SharedPreferences.getInstance();
  }


  Future<bool> deleteData(String key) async{
    return myPrefs!.remove(key);
  }

  Future<List<String>> retrieveString (String? key) async{
    return myPrefs!.getStringList(key!) ?? [];
  }

  saveString(String key, List<String> value) async{
    myPrefs!.setStringList(key, value);
  }

}