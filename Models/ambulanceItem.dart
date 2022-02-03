import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum City { All, DelhiNCR, Mumbai, Kolkata, Chennai }

class AmbulanceItem with ChangeNotifier {
  final String id;
  final String name;
  final List<String> phoneNumber;
  final String timings;
  final double rating;
  final String ratingSource;
  final String area;
  final double lat;
  final double long;
  final String address;
  final String longAddress;
  bool isStarred;
  final String description;
  final City city;
  final String websiteLink;

  AmbulanceItem({
    @required this.id,
    @required this.name,
    @required this.phoneNumber,
    @required this.timings,
    @required this.area,
    this.rating,
    this.ratingSource,
    this.lat,
    this.long,
    this.address,
    this.longAddress,
    this.isStarred = false,
    this.description,
    @required this.city,
    this.websiteLink,
  });

  Future<void> toggleStarred() async {
    final orig = isStarred;
    isStarred = !isStarred;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("$id-isStarred", isStarred);
  }
}
