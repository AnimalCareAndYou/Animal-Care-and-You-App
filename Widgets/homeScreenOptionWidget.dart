import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenOptionWidget extends StatelessWidget {
  final String optionText;
  final IconData optionIcon;
  final routeName;

  HomeScreenOptionWidget(this.optionText, this.optionIcon, this.routeName);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: make the MediaQuery object constant
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10,
      ),
      child: Card(
        elevation: 3,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                optionIcon,
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
            title: Text(optionText,
                style: GoogleFonts.nunito(
                    fontSize: 14.6,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                    ))),
            trailing: FlatButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(routeName),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                "LEARN MORE",
                style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w400),
              ),
              color: Colors.purple[200],
            ),
          ),
        ),
      ),
    );
  }
}
