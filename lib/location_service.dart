import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LocationService {
  final String key = "AIzaSyBysW6YnQt-dPBg9a_18N24q-nQgYF42Eo";

  Future<String> getPlaceId(String input) async {
    final String url = 'https://maps.googleapis.com/maps/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    
    var reponse = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(reponse.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = getPlaceId(input);
    final String url = 'https://maps.googleapis.com/maps/place/details/json?place_id=$placeId&key=$key';

    var reponse = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(reponse.body);
    var results = json['result'] as Map<String, dynamic>;

    return results;
  }
}