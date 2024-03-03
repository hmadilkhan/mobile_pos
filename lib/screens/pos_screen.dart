import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/widgets/pos_screen/departments.dart';
import 'package:mobile_pos/widgets/pos_screen/pos_header.dart';
import 'package:mobile_pos/widgets/pos_screen/products.dart';

class PosScreen extends StatelessWidget {
  PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PosHeader(),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          labelText: "Search Article or Code",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero)),
                    ),
                  ),
                  Row(
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
            Department(),
            Divider(),
            Product(),
          ],
        ),
      ),
    );
  }
}
