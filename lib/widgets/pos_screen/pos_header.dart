import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosHeader extends StatefulWidget {
  const PosHeader({Key? key}) : super(key: key);

  @override
  State<PosHeader> createState() => _PosHeaderState();
}

class _PosHeaderState extends State<PosHeader> {
  String company = "Sabsons Distribution";
  String city = "Karachi";
  String branch = "Sabsoft";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setvalues();
  }

  void setvalues() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    company = prefs.getString("company")!;
    print("company: ${company}");
    branch = prefs.getString("branch")!;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.transparent,
            child: Image.asset("assets/images/logo.png"),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${company}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Text(
                      "${city}",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    ),
                    Text("${branch}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontFamily: "Poppins",
                        )),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 80,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    "A",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
