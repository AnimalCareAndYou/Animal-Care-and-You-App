import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/ambulanceItem.dart';

class AmbulanceItems with ChangeNotifier {
  List<AmbulanceItem> _items = [];

  Future<void> itemsBuilder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<AmbulanceItem> items = [
      AmbulanceItem(
        id: "a1",
        name: "Ravi Kumar's Animal Ambulance",
        phoneNumber: ["9971079603"],
        timings: "9AM - 3PM",
        isStarred: prefs.getBool("a1-isStarred") ?? false,
        area:
            "Mainly operates in South Delhi - will cater to urgent requests in the NCR Region",
        city: City.DelhiNCR,
      ),
      AmbulanceItem(
        id: "a2",
        name: "Gunjan's Animal Ambulance",
        phoneNumber: ["9810008633"],
        timings: "Throughout the day",
        isStarred: prefs.getBool("a2-isStarred") ?? false,
        area: "South Delhi",
        city: City.DelhiNCR,
      ),
      AmbulanceItem(
        id: "a3",
        name: "Aravind's Dog Ambulance",
        phoneNumber: ["9582204088"],
        area: "Delhi",
        timings: "Throughout the day",
        isStarred: prefs.getBool("a3-isStarred") ?? false,
        city: City.DelhiNCR,
      ),
      AmbulanceItem(
        id: "a4",
        name: "Uday's Dog Ambulance",
        phoneNumber: ["8800002030"],
        area: "Delhi",
        timings: "Throughout the day",
        isStarred: prefs.getBool("a4-isStarred") ?? false,
        city: City.DelhiNCR,
      ),
      AmbulanceItem(
        id: "a5",
        name: "Mangal's Animal Ambulance",
        phoneNumber: ["8826397928"],
        area: "South Delhi",
        timings: "Throughout the day",
        isStarred: prefs.getBool("a5-isStarred") ?? false,
        city: City.DelhiNCR,
      ),
      AmbulanceItem(
        id: "a6",
        name: "Heart 2 Heart Veterinary Hospital",
        phoneNumber: ['7947324544'],
        area: "Santhome, Chennai",
        timings: "Sunday - Saturday: 10:30AM - 7:30PM",
        city: City.Chennai,
        websiteLink: "http://www.h2hvet.in/",
        isStarred: prefs.getBool("a6-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a7",
        name: "Society For The Prevention Of Cruelty To Animals",
        phoneNumber: ['044 25611628', '044 25612160'],
        area: "Vepery, Chennai",
        timings: "Monday - Saturday: 9:30AM - 5:00PM",
        city: City.Chennai,
        websiteLink:
            "https://www.justdial.com/Chennai/Society-For-The-Prevention-Of-Cruelty-To-Animals-Madras-Society-For-The-Protection-Care-Of-Animals-Opposite-Vepery-College-Vepery/044P3005104_BZDET?xid=Q2hlbm5haSBQZXQgQW1idWxhbmNlIFNlcnZpY2Vz",
        isStarred: prefs.getBool("a7-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a8",
        name: "Kishore Pet Ambulance Service",
        phoneNumber: ['9176700299'],
        area: " Triplicane, Chennai",
        timings: "Emergency services open 24x7",
        city: City.Chennai,
        websiteLink:
            "https://www.justdial.com/Chennai/Kishore-pet-ambulance-service-Ice-House-Police-Station-Triplicane/044PXX44-XX44-140306161546-F5K8_BZDET?xid=Q2hlbm5haSBQZXQgQW1idWxhbmNlIFNlcnZpY2Vz",
        isStarred: prefs.getBool("a8-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a9",
        name: "Aarathy ALS Ambulance",
        phoneNumber: ['8122002261', '8144442444'],
        area: "Pallikaranai, Chennai",
        timings: "Emergency services open 24x7",
        city: City.Chennai,
        websiteLink:
            "https://www.justdial.com/Chennai/Aarathy-ALS-Ambulance-Near-Idhaya-Vaasal-Elders-Home-Pallikaranai/044PXX44-XX44-170208224652-K9C5_BZDET?xid=Q2hlbm5haSBQZXQgQW1idWxhbmNlIFNlcnZpY2Vz",
        isStarred: prefs.getBool("a9-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a10",
        name: "Chennai Veterinary Hospital & Shelters",
        phoneNumber: ['9884685512'],
        area: "Adyar, Chennai",
        timings: "Sunday - Saturday: 10:30AM - 1:30PM, 6:30PM - 9:00PM",
        city: City.Chennai,
        websiteLink:
            "https://www.google.com/maps/place/Chennai+Veterinary+Hospital+%26+Shelters/@12.993844,80.2509725,17z/data=!3m1!4b1!4m5!3m4!1s0x3a526f7314000001:0x7559c925a353a7c9!8m2!3d12.9938453!4d80.2531668?authuser=0&hl=en",
        isStarred: prefs.getBool("a10-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a11",
        name: "Royal Pet Resort",
        phoneNumber: ['7947184160'],
        area: "Mira Bhayandar",
        timings: "Emergency services open 24x7",
        city: City.Mumbai,
        websiteLink:
            "https://www.justdial.com/Mumbai/Royal-Pet-Resort-Opposite-D-Mart-Bhayandar-West/022PXX22-XX22-180723130643-T5X5_BZDET?xid=TXVtYmFpIFBldCBBbWJ1bGFuY2UgU2VydmljZXM=",
        isStarred: prefs.getBool("a11-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a12",
        name: "Mahesh Ambulance Services",
        phoneNumber: ['7947176132'],
        area: "Mulund West, Mumbai",
        timings: "Emergency services open 24x7",
        city: City.Mumbai,
        websiteLink:
            "https://www.justdial.com/Mumbai/Mahesh-Ambulance-Services-Opposite-Achija-Hotel-Mulund-West/022PXX22-XX22-140807170141-E2K5_BZDET?xid=TXVtYmFpIFBldCBBbWJ1bGFuY2UgU2VydmljZXM=",
        isStarred: prefs.getBool("a12-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a13",
        name: "Government Veterinary Hospital Palghar",
        phoneNumber: ['18002330418'],
        area: "Vajulsar, Phalghar",
        timings: "Emergency services open 24x7",
        city: City.Mumbai,
        websiteLink: "https://ahd.maharashtra.gov.in/",
        isStarred: prefs.getBool("a13-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a14",
        name: "Star Pet Animal Ambulance",
        phoneNumber: ['9967935100'],
        area: "Jogeshwari East, Mumbai",
        timings: "Emergency services open 24x7",
        city: City.Mumbai,
        websiteLink:
            "https://www.justdial.com/Mumbai/Star-Pet-Animal-Ambulance-Jogeshwari-East/022P1209787202A7X7Y1_BZDET?xid=TXVtYmFpIFBldCBBbWJ1bGFuY2UgU2VydmljZXM=",
        isStarred: prefs.getBool("a14-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a15",
        name: "Trimurti Pet Animal Ambulance",
        phoneNumber: ['9820521218', '9757333233'],
        area: "Sion, Mumbai",
        timings: "Emergency services open 24x7",
        city: City.Mumbai,
        websiteLink:
            "https://www.justdial.com/Mumbai/Trimurti-Pet-Animal-Ambulance-Koliwada-Mariyamma-Temple-Mahatma-Gandhi-Nagar-Sion/022PXX22-XX22-110625183722-H3F4_BZDET?xid=TXVtYmFpIFBldCBBbWJ1bGFuY2UgU2VydmljZXM=",
        isStarred: prefs.getBool("a15-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a16",
        name: "Animal Care Centre",
        phoneNumber: ['033 24805079', '9804329234'],
        area: "Jagannathpur, Kolkata",
        timings: "Sunday - Saturday: 1:00AM - 11:00PM",
        city: City.Kolkata,
        websiteLink: "http://animalcares.in/",
        isStarred: prefs.getBool("a16-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a17",
        name: "Aabi Pet Shop",
        phoneNumber: ['9831517907', '9674344454'],
        area: "Dum Dum, Kolkata",
        timings: "Monday - Saturday: 10:00AM - 9:00PM",
        city: City.Kolkata,
        websiteLink:
            "https://www.justdial.com/Kolkata/Aabi-Pet-Shop-Near-Purva-Appartment-Baguiati-Khalpar-More-Dum-Dum/033PXX33-XX33-170520150031-W2Q1_BZDET?xid=S29sa2F0YSBQZXQgQW1idWxhbmNlIFNlcnZpY2Vz",
        isStarred: prefs.getBool("a17-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a18",
        name: "Pet Plus",
        phoneNumber: ['7044333690'],
        area: "Behala, Kolkata",
        timings: "Emergency services open 24x7",
        city: City.Kolkata,
        websiteLink:
            "https://www.justdial.com/Kolkata/Pet-Plus-Near-M-P-Birla-Foundation-High-School-Behala/033PXX33-XX33-171223193048-V5H4_BZDET?xid=S29sa2F0YSBQZXQgQW1idWxhbmNlIFNlcnZpY2Vz",
        isStarred: prefs.getBool("a18-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a19",
        name: "Paws",
        phoneNumber: ['6289791429'],
        area: "Alipore, Kolkata",
        timings: "Emergency services open 24x7",
        city: City.Kolkata,
        websiteLink:
            "https://www.justdial.com/Kolkata/Paws-Alipore/033PXX33-XX33-190814165118-J4J2_BZDET?xid=S29sa2F0YSBQZXQgQW1idWxhbmNlIFNlcnZpY2Vz",
        isStarred: prefs.getBool("a19-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a20",
        name: "Pravat Ambulance",
        phoneNumber: ['9674781292'],
        area: "Narendrapur, Kolkata",
        timings: "Emergency services open 24x7",
        city: City.Kolkata,
        websiteLink:
            "https://www.justdial.com/Kolkata/Pravat-Ambulance-Shamsiya-More-Swami-Vivekananda-Hindi-School-Narendrapur/033PXX33-XX33-180831142534-I7U1_BZDET?xid=S29sa2F0YSBQZXQgQW1idWxhbmNlIFNlcnZpY2Vz",
        isStarred: prefs.getBool("a20-isStarred") ?? false,
      ),
      AmbulanceItem(
        id: "a21",
        name: "Animal Rescue And Care (ARC) - Kolkata",
        phoneNumber: ['7890535353', '7890838383'],
        area: "Thakurpukur, Kolkata",
        timings: "Monday - Saturday: 9:30AM - 1:00PM,  5:30 - 9:00PM",
        city: City.Kolkata,
        websiteLink: "https://www.arckolkata.org/",
        isStarred: prefs.getBool("a21-isStarred") ?? false,
      ),
    ];

    _items = items;
  }

  List<AmbulanceItem> get items {
    return [..._items];
  }

  List<AmbulanceItem> get starredItems {
    return _items.where((chemistItem) => chemistItem.isStarred).toList();
  }
}
