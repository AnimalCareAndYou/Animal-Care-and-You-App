import 'dart:async';

import 'package:animal_app/Models/ambulanceItem.dart';
import 'package:animal_app/Widgets/ambulanceItemWidget.dart';
import 'package:animal_app/Widgets/newAmbulanceItemWidget.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Providers/ambulanceItems.dart';

class AmbulanceItemsGrid extends StatefulWidget {
  final bool showOnlyStarredItems;
  final City selectedCity;
  // final bool sortByProximity; // change
  final AmbulanceItems ambulanceItemsData;

  final double height;

  AmbulanceItemsGrid(this.selectedCity, this.showOnlyStarredItems,
      this.ambulanceItemsData, this.height);

  @override
  _AmbulanceItemsGridState createState() => _AmbulanceItemsGridState();
}

class _AmbulanceItemsGridState extends State<AmbulanceItemsGrid> {
  // var _isInit = true;
  // var _isLoading = true;

  AmbulanceItems ambulanceItemsData;

  _makingPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void didChangeDependencies() {
    // if (_isInit) {
    //   chemistItemsData = Provider.of<ChemistItems>(context, listen: false);
    //   chemistItemsData.itemsBuilder().then((value) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // }
    // _isInit = false;

    ambulanceItemsData = widget.ambulanceItemsData;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var ambulanceItems = widget.showOnlyStarredItems
        ? ambulanceItemsData.starredItems
        : ambulanceItemsData.items;

    ambulanceItems = ambulanceItems.where((ambItem) {
      if (widget.selectedCity == City.All ||
          widget.selectedCity == ambItem.city) {
        return true;
      } else {
        return false;
      }
    }).toList();

    return ambulanceItems.length == 0
        ? Container(
            height: widget.height,
            child: Center(
                child: Text(
              "No items match your settings",
              style: TextStyle(fontSize: 18),
            )))
        : Container(
            margin: EdgeInsets.all(5),
            height: widget.height,
            width: double.infinity,
            child: ListView.builder(
              itemCount: ambulanceItems.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: ambulanceItems[index],
                  child: Column(
                    children: [
                      NewAmbulanceItemWidget(),
                      index == ambulanceItems.length - 1
                          ? Container()
                          : Divider(
                              thickness: 2,
                              indent: 10,
                              endIndent: 10,
                            ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
