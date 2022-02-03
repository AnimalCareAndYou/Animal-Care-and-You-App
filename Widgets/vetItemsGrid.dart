import 'dart:ui';

import 'package:animal_app/Models/ambulanceItem.dart';
import 'package:app_settings/app_settings.dart';
import 'package:animal_app/Models/ngoItem.dart';
import 'package:animal_app/Models/vetItem.dart';
import 'package:animal_app/Providers/vetItems.dart';
import 'package:animal_app/Widgets/vetItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class VetItemsGrid extends StatefulWidget {
  final bool showOnlyFavouriteItems;
  final animalSettings;
  final citySettings;
  final sortByProximity;
  final VetItems vetItemsData;
  final double height;
  VetItemsGrid(this.showOnlyFavouriteItems, this.animalSettings,
      this.citySettings, this.sortByProximity, this.vetItemsData, this.height);
  @override
  _VetItemsGridState createState() => _VetItemsGridState();
}

class _VetItemsGridState extends State<VetItemsGrid> {
  // var _isInit = true;
  // var _isLoading = true;

  VetItems vetItemsData;

  @override
  void didChangeDependencies() {
    // if (_isInit) {
    //   vetItemsData = Provider.of<VetItems>(context, listen: false);
    //   vetItemsData.itemsBuilder().then((_) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // }
    // _isInit = false;
    vetItemsData = widget.vetItemsData;

    super.didChangeDependencies();
  }

  double calcDistance(double lat1, double long1, Position positionOfDevice) {
    double lat2 = positionOfDevice.latitude;
    double long2 = positionOfDevice.longitude;
    double distance = Geolocator.distanceBetween(lat1, long1, lat2, long2);

    return distance;
  }

  List<double> sortAscending(List<double> nums) {
    int numIterations = nums.length;
    List<double> sortedVals = [];

    for (var i = 0; i < numIterations; i++) {
      double min = nums[0];
      for (var i = 0; i < nums.length; i++) {
        if (nums[i] < min) {
          min = nums[i];
        }
      }
      sortedVals.add(min);
      nums.remove(min);
    }
    return sortedVals;
  }

  Position getCurrentPos() {
    Position pos;
    Geolocator.getCurrentPosition().then((value) {
      pos = value;
      print(pos);
      return pos;
    });
  }

  List<VetItem> sortedVetItems;

  Future<List<VetItem>> sortedItems(List<VetItem> vetItems) async {
    var listOfDistancesAndIndexes = [];

    List<VetItem> listOfVetItems = vetItems;

    List<VetItem> newListOfVetItems = [];

    Position positionOfDevice = await Geolocator.getCurrentPosition();

    print(positionOfDevice.latitude);
    print(positionOfDevice.longitude);
    for (var i = 0; i < listOfVetItems.length; i++) {
      double distFromCurrentPos = calcDistance(
          listOfVetItems[i].lat, listOfVetItems[i].long, positionOfDevice);
      listOfDistancesAndIndexes.add([distFromCurrentPos, i]);
    }

    List<double> listOfDistances = [];

    for (var i = 0; i < listOfVetItems.length; i++) {
      listOfDistances.add(listOfDistancesAndIndexes[i][0]);
    }

    listOfDistances = sortAscending(listOfDistances);

    List sortedListOfDistances = [];

    listOfDistances.forEach((dist) {
      sortedListOfDistances.add(listOfDistancesAndIndexes
          .firstWhere((distanceAndIndex) => distanceAndIndex[0] == dist));
    });

    print(sortedListOfDistances);

    for (var i = 0; i < listOfVetItems.length; i++) {
      int index = sortedListOfDistances[i][1];
      newListOfVetItems.add(listOfVetItems[index]);
    }

    return newListOfVetItems;
  }

  Future<LocationPermission> locationStatus() async {
    // bool isLocationOn = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    return permission;
  }

  RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    side: BorderSide(color: Colors.blue[300], width: 1),
    borderRadius: BorderRadius.circular(10),
  );

  TextStyle style = GoogleFonts.nunito();

  @override
  Widget build(BuildContext context) {
    print(widget.sortByProximity);
    List<VetItem> vetItems = widget.showOnlyFavouriteItems
        ? vetItemsData.favourite
        : vetItemsData.items;

    if (widget.animalSettings == AnimalSettings.All) {
      print("all");
    } else {
      vetItems = vetItems.where((vetItem) {
        return vetItem.animalSettings.contains(AnimalSettings.All) ||
            vetItem.animalSettings.contains(widget.animalSettings);
      }).toList();
    }

    vetItems = vetItems.where((vetItem) {
      if (widget.citySettings == City.All ||
          widget.citySettings == vetItem.city) {
        return true;
      } else {
        return false;
      }
    }).toList();

    if (widget.sortByProximity) {
      return FutureBuilder(
        future: locationStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // location prefs obtained
            LocationPermission locStatus = snapshot.data;
            if (locStatus == LocationPermission.always ||
                locStatus == LocationPermission.whileInUse) {
              // gps can be used
              return FutureBuilder(
                  future: sortedItems(vetItems),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      // sorted items received
                      vetItems = snapshot.data;
                      return vetItems.length == 0
                          ? Container(
                              height: widget.height,
                              child: Center(
                                  child: Text("No items match your settings",
                                      style: TextStyle(fontSize: 18))))
                          : Container(
                              margin: EdgeInsets.all(5),
                              height: widget.height,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: vetItems.length,
                                itemBuilder: (ctx, index) {
                                  return Column(children: [
                                    VetItemWidget(vetItems[index]),
                                    index == (vetItems.length - 1)
                                        ? SizedBox(
                                            height: 8,
                                          )
                                        : SizedBox(
                                            height: 16,
                                          ),
                                  ]);
                                },
                              ),
                            );
                    } else {
                      // sorted items not received
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            } else if (locStatus == LocationPermission.deniedForever) {
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: FlatButton(
                    shape: buttonShape,
                    onPressed: () {
                      AppSettings.openAppSettings().then((value) {
                        print("answer");
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "Location services have been permanently disabled. To give the Animal Care and You app access to your device's location, you will have to alter the app's location settings. This can be done by tapping on this box.",
                        textAlign: TextAlign.center,
                        style: style,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // gps cannot be used
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: FlatButton(
                      shape: buttonShape,
                      onPressed: () {
                        Geolocator.requestPermission().then((value) {
                          setState(() {
                            print("hello");
                          });
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "To sort the vets by their closeness to you, the Animal Care and You app requires access to your device's current location. Tap here to change your location preferences.",
                          textAlign: TextAlign.center,
                          style: style,
                        ),
                      )),
                ),
              );
            }
          } else {
            // waiting for locations prefs
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      return vetItems.length == 0
          ? Container(
              height: widget.height,
              child: Center(
                  child: Text(
                "No items match your settings",
                style: TextStyle(fontSize: 18),
              )))
          : Container(
              height: widget.height,
              width: double.infinity,
              margin: EdgeInsets.all(5),
              child: ListView.builder(
                itemCount: vetItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      VetItemWidget(vetItems[index]),
                      index == (vetItems.length - 1)
                          ? SizedBox(
                              height: 8,
                            )
                          : SizedBox(
                              height: 16,
                            )
                    ],
                  );
                },
              ),
            );
    }
  }
}
