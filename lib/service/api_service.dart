import 'dart:convert';

import 'package:gluteno/models/general_info.dart';
import 'package:gluteno/models/pharmacy.dart';
import 'package:gluteno/models/recipe.dart';
import 'package:gluteno/models/stores.dart';
import 'package:http/http.dart' as http;
import 'package:gluteno/models/restaurant.dart';

class ApiService {
  static const String baseUrl = 'https://graduationprojectbackend.onrender.com';

  static Future<List<Restaurant>> fetchRestaurants() async {
    final uri = Uri.parse('$baseUrl/api/service-provider/restaurants');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Restaurant.listFromJson(response.body);
    } else {
      throw Exception('failed: ${response.statusCode}');
    }
  }

  static Future<List<Pharmacy>> fetchPharmacies() async {
    final uri = Uri.parse('$baseUrl/api/service-provider/pharmacies');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Pharmacy.listFromJson(response.body);
    } else {
      throw Exception('Failed to load pharmacies: ${response.statusCode}');
    }
  }

  static Future<List<Recipe>> fetchRecipes() async {
    final uri = Uri.parse('$baseUrl/api/recipes');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Recipe.listFromJson(response.body);
    } else {
      throw Exception('Failed to load recipes: ${response.statusCode}');
    }
  }

  static Future<List<Market>> fetchMarkets() async {
    final uri = Uri.parse('$baseUrl/api/service-provider/markets');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Market.listFromJson(response.body);
    } else {
      throw Exception('Failed to load markets: ${response.statusCode}');
    }
  }
    static Future<List<GeneralInformation>> fetchGeneralInformation() async {
    final uri = Uri.parse('$baseUrl/api/general-information');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => GeneralInformation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load general information: ${response.statusCode}');
    }
  }

}
