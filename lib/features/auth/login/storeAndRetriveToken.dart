
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreAndRetriveToken{
   static final storage = FlutterSecureStorage();
  static Future<void> storetokenInLocal(Map<String, dynamic> body) async {

    final token = body['token'];
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'school_id', value: body['user']['school_id']);
  }

 static Future<String?> getAuthToken() async {
    // Retrieve the token from storage
   print(await storage.read(key: 'token'));
    return await storage.read(key: 'token');
  }
   static Future<String?> getschool_id() async {
     // Retrieve the token from storage
     print(await storage.read(key: 'school_id'));
     return await storage.read(key: 'school_id');
   }
}