import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_pos/widgets/pos_screen/pop_over_item.dart';
import 'package:popover/popover.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosHeader extends StatefulWidget {
  const PosHeader({super.key});

  @override
  State<PosHeader> createState() => _PosHeaderState();
}

class _PosHeaderState extends State<PosHeader> {
  String company = "Sabsons Distribution";
  String city = "Karachi";
  String branch = "Sabsoft";

  @override
  void initState() {
    super.initState();
    // setvalues();
  }

  void setvalues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    company = prefs.getString("company")!;
    branch = prefs.getString("branch")!;
    setState(() {});
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
                padding: const EdgeInsets.only(right: 2.0),
                child: SizedBox(
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        company,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        city,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                        ),
                      ),
                      Text(branch,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                            fontFamily: "Poppins",
                          )),
                    ],
                  ),
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
