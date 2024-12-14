import 'dart:convert'; // To decode JSON responses
import 'package:http/http.dart' as http; // For making HTTP requests

// Function to fetch currencies from Open Exchange Rates API
Future<Map<String, String>> fetchCurrencies() async {
  const String apiKey = '6d76ddf269fc448eb5c52b025b00c099';
  final String url =
      'https://openexchangerates.org/api/currencies.json?app_id=$apiKey'; //$ is used for string interpolation-allows you to insert the value of a variable directly into a string

  // Make the GET request
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the API call is successful, decode the JSON response
    return Map<String, String>.from(json.decode(response.body));
  } else {
    // If the API call fails, throw an exception
    throw Exception('Failed to load currencies');
  }
}
