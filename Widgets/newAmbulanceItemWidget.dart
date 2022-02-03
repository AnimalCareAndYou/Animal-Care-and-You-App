import 'package:animal_app/Models/ambulanceItem.dart';
// import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewAmbulanceItemWidget extends StatefulWidget {
  @override
  _NewAmbulanceItemWidgetState createState() => _NewAmbulanceItemWidgetState();
}

class _NewAmbulanceItemWidgetState extends State<NewAmbulanceItemWidget> {
  _makingPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ambulanceItem = Provider.of<AmbulanceItem>(context);

    var colorOption;
    var cityText;

    if (ambulanceItem.city == City.DelhiNCR) {
      cityText = "Delhi NCR";
      colorOption = Colors.blue[800];
    } else if (ambulanceItem.city == City.Mumbai) {
      cityText = "Mumbai";
      colorOption = Colors.teal[500];
    } else if (ambulanceItem.city == City.Chennai) {
      cityText = "Chennai";
      colorOption = Colors.indigo[500];
    } else {
      cityText = "Kolkata";
      colorOption = Colors.pink[400];
    }

    return Card(
      elevation: 2.2,
      shadowColor: colorOption,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              ambulanceItem.name,
              style: GoogleFonts.oswald(
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: colorOption,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Text(
                    ambulanceItem.city == City.DelhiNCR
                        ? "Region: $cityText"
                        : "City: $cityText",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      ambulanceItem.toggleStarred();
                    });
                  },
                  icon: Icon(
                    ambulanceItem.isStarred
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: colorOption,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1.1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: colorOption,
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  children: [
                    ...ambulanceItem.phoneNumber.map((number) {
                      return Column(
                        children: [
                          InkWell(
                              onTap: () => _makingPhoneCall(number),
                              child: Text(
                                number,
                                style: TextStyle(
                                  color: colorOption,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                          ambulanceItem.phoneNumber.indexOf(number) ==
                                  ambulanceItem.phoneNumber.length - 1
                              ? Container()
                              : SizedBox(height: 5)
                        ],
                      );
                    }).toList(),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: colorOption,
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(child: Text(ambulanceItem.area))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.watch_later,
                  color: colorOption,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(ambulanceItem.timings)
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ambulanceItem.websiteLink == null
                ? Container()
                : Row(children: [
                    Icon(
                      Icons.web,
                      color: colorOption,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      child: Text(
                        "Visit their website",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () async {
                        if (!await launch(ambulanceItem.websiteLink))
                          throw 'Could not launch ${ambulanceItem.websiteLink}';
                      },
                    ),
                  ]),
            ambulanceItem.websiteLink == null
                ? Container()
                : SizedBox(
                    height: 5,
                  ),
          ],
        ),
      ),
    );
  }
}
