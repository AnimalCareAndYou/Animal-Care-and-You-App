import 'package:animal_app/Providers/vetItems.dart';
import 'package:animal_app/Screens/ngoScreen.dart';
import 'package:animal_app/Screens/vetsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Providers/newBestPracticesItems.dart';
import 'Screens/ambulancesScreen.dart';
import 'Screens/homeScreen.dart';
import './Screens/bestPracticesScreen.dart';
import './Providers/informationItems.dart';
import 'Providers/ambulanceItems.dart';
import './Providers/petStoreItems.dart';
import './Providers/ngoItems.dart';

void main(List<String> args) {
  runApp(AnimalApp());
}

class AnimalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => NewBestPracticesItems()),
        ChangeNotifierProvider(create: (ctx) => InformationItems()),
        ChangeNotifierProvider(create: (ctx) => AmbulanceItems()),
        ChangeNotifierProvider(create: (ctx) => PetStoreItems()),
        ChangeNotifierProvider(create: (ctx) => NgoItems()),
        ChangeNotifierProvider(create: (ctx) => VetItems()),
      ],
      child: MaterialApp(
        title: "AnimalApp",
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueGrey[300],
          textTheme: ThemeData.light().textTheme.copyWith(
              headline: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
              ),
              body1: GoogleFonts.nunito(
                fontSize: 13,
              ),
              body2: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              // ignore: deprecated_member_use
              title: TextStyle(
                height: 1.1,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              )),
        ),
        routes: {
          BestPracticesScreen.routeName: (ctx) => BestPracticesScreen(),
          AmbulanceScreen.routeName: (ctx) => AmbulanceScreen(),
          NgoScreen.routeName: (ctx) => NgoScreen(),
          VetsScreen.routeName: (ctx) => VetsScreen(),
        },
      ),
    );
  }
}
