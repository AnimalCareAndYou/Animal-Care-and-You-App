import 'package:animal_app/Models/ambulanceItem.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterAmbulanceItemsScreen extends StatefulWidget {
  final showOnlyFavouriteItems;
  final city;
  FilterAmbulanceItemsScreen(this.showOnlyFavouriteItems, this.city);

  @override
  _FilterAmbulanceItemsScreenState createState() =>
      _FilterAmbulanceItemsScreenState();
}

class _FilterAmbulanceItemsScreenState
    extends State<FilterAmbulanceItemsScreen> {
  static bool onlyFavourites = false;

  String _dropDownValue = "All Cities and Regions";
  List<String> _dropDownValuesList = [
    "All Cities and Regions",
    "Delhi NCR",
    "Mumbai",
    "Chennai",
    "Kolkata"
  ];

  var _possibleSettings = [
    City.All,
    City.DelhiNCR,
    City.Mumbai,
    City.Chennai,
    City.Kolkata,
  ];

  static City selectedCity = City.All;

  @override
  void initState() {
    onlyFavourites = widget.showOnlyFavouriteItems;
    selectedCity = widget.city;
    _dropDownValue =
        _dropDownValuesList[_possibleSettings.indexOf(selectedCity)];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Filter Animal Ambulances"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text(
                "Show only favourite items",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              value: onlyFavourites,
              onChanged: (newValue) {
                setState(() {
                  onlyFavourites = newValue;
                });
              },
              activeColor: Colors.blue[400],
            ),
            Divider(
              color: Colors.blue[200],
              thickness: 1.5,
              height: 25,
              indent: 6,
              endIndent: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(
                    "Cities / Regions",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                  width: 250,
                  child: DropdownButton<String>(
                    value: _dropDownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.blue[600],
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        _dropDownValue = newValue;
                        selectedCity = _possibleSettings[
                            _dropDownValuesList.indexOf(newValue)];
                      });
                    },
                    items: _dropDownValuesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.nunito(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 1,
        backgroundColor: Colors.blue[300],
        onPressed: () {
          Navigator.of(context).pop([onlyFavourites, selectedCity]);
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text("Save Settings"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
