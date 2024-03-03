import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  final List<String> departments = [
    "BBQ",
    "Pizza",
    "Burgers",
    "Chinese",
    "Sidelines",
    "Drinks",
    "Ice Cream",
    "Salads"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                      const Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Wild Orchids",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "Karachi",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            Text("Desktop T1 - Inspiron 3521",
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
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: const SizedBox(
                      width: 250,
                      child: TextField(
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                            labelText: "Search Article or Code",
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero)),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.barcode_reader,
                        color: Colors.grey,
                        size: 30,
                      ),
                      Icon(
                        Icons.mic,
                        color: Colors.grey,
                        size: 30,
                      ),
                      Icon(
                        Icons.refresh,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    var name = departments[index].toString();
                    return Container(
                      padding: const EdgeInsets.all(3.0),
                      height: 10,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 240, 236, 236),
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: const Color.fromARGB(255, 240, 236, 236)),
                      child: Text(
                        '$name',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 104, 101, 101)),
                      ),
                    );
                  }),
            ),
            Divider(),
            Expanded(
                child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(height: 1),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            height: 60,
                            width: double.infinity,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 5.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              // color:
                              //     const Color.fromARGB(255, 245, 243, 243)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.green,
                                        child: const Center(
                                          child: Text(
                                            "A",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 7),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Sunmi T2 Lite Dual",
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                            Text(
                                              "Doodh Patti Description ",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2.0),
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PKR. 150,000",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      Text(
                                        "100000 Unit",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.green,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
