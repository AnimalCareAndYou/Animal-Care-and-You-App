import 'package:animal_app/Models/ambulanceItem.dart';
import 'package:animal_app/Providers/ambulanceItems.dart';
import 'package:animal_app/Screens/filterAmbulanceItemsScreen.dart';
import 'package:animal_app/Widgets/ambulanceItemsGrid.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum FilterOptions { StarredItems, All }

class AmbulanceScreen extends StatefulWidget {
  static const routeName = "/chemist-screen";

  @override
  _AmbulanceScreenState createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {
  var _showOnlyStarredItems = false;
  var _selectedCity = City.All;
  // var _sortByProximity = false; // change
  var _isInit = true;
  var _isLoading = true;

  AmbulanceItems ambulanceItemsData;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      ambulanceItemsData = Provider.of<AmbulanceItems>(context, listen: false);
      ambulanceItemsData.itemsBuilder().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var ambulanceItems = _showOnlyStarredItems
        ? ambulanceItemsData.starredItems
        : ambulanceItemsData.items;
    ambulanceItems = ambulanceItems.where((ambItem) {
      if (_selectedCity == City.All || ambItem.city == _selectedCity) {
        return true;
      } else {
        return false;
      }
    }).toList();
    double _height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal Ambulances"),
        actions: [
          FlatButton.icon(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => FilterAmbulanceItemsScreen(
                          _showOnlyStarredItems,
                          _selectedCity,
                        )))
                .then((value) {
              print(value);
              setState(() {
                _showOnlyStarredItems = value[0];
                _selectedCity = value[1];
              });
            }),
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: Text("Settings", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  Container(
                    height: _height * 0.07,
                    child: FittedBox(
                      child: Text(
                        "Animal Ambulances",
                        style: GoogleFonts.oswald(
                          textStyle: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: _height * 0.915,
                    child: AmbulanceItemsGrid(
                        _selectedCity,
                        _showOnlyStarredItems, // change
                        ambulanceItemsData,
                        _height * 0.915),
                  ),
                ]),
              ),
            ),
    );
  }
}
