import 'package:animal_app/Widgets/appDrawer.dart';
import 'package:animal_app/Widgets/customImageBox.dart';
import 'package:animal_app/Widgets/customImageBoxAsset.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  TextStyle boldTextStyle() {
    return GoogleFonts.nunito(
      color: Colors.blue[700],
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(13, 15, 13, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "About Us",
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 9.0,
              ),
              CustomImageBoxAsset(
                  radius: 5,
                  link: "assets/about_us.jpg",
                  height: 270,
                  width: double.infinity),
              SizedBox(
                height: 15,
              ),
              // Divider(
              //   color: Colors.black,
              //   indent: 20,
              //   endIndent: 20,
              //   thickness: 10,
              //   height: 30,
              // ),
              RichText(
                text: TextSpan(
                  text:
                      'Hi! My name is Abhimanyu and I am a high school student who loves animals. Like many others, I would frequently come across distressed animals on the street and while I had every intention of helping these animals, I often did not know how to respond to such situations appropriately.  This inspired me to develop the ',
                  style: GoogleFonts.nunito(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Animal Care and You',
                      style: boldTextStyle(),
                    ),
                    TextSpan(
                        text:
                            ' app – a tool that I always wished I had. \n \nAnimal Care and You presents '),
                    TextSpan(text: "relevant information"),
                    TextSpan(text: " about "),
                    TextSpan(
                      text: "animal protection and medical care",
                      style: boldTextStyle(),
                    ),
                    TextSpan(
                        text:
                            ", all the way from the best vets near you to reputed NGOs in this domain. The goal of this app is to empower you when you see an animal in need of help, taking you from being just an animal lover to a "),
                    TextSpan(
                      text: "relentless animal saviour",
                      style: boldTextStyle(),
                    ),
                    TextSpan(
                      text: ".",
                    )
                  ],
                ),
              ),
              // Text(
              //   "Hi! My name is Abhimanyu and I am a high school student who loves animals. Like many others, I would frequently come across distressed animals on the street and while I had every intention of helping these animals, I often did not know how to respond to such situations appropriately.  This inspired me to develop the Animal Care and You app – a tool that I always wished I had. \n \nAnimal Care and You presents relevant information about animal protection and medical care, all the way from the best vets near you to reputed NGOs in this domain. The goal of this app is to empower you when you see an animal in need of help, taking you from being just an animal lover to a relentless animal saviour.",
              //   textAlign: TextAlign.left,
              //   style: GoogleFonts.nunito(
              //     color: Colors.grey[800],
              //     fontWeight: FontWeight.w400,
              //     fontSize: 16,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
