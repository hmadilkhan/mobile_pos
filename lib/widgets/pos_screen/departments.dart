import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/models/department_model.dart';
import 'package:mobile_pos/models/user_model.dart';
import 'package:mobile_pos/services/database_helper.dart';
import 'package:mobile_pos/services/pos_service.dart';
import 'package:mobile_pos/utils/api-list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Department extends StatefulWidget {
  const Department({super.key,PosController? controller});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {

  late final Future futureDepartments = DatabaseHelper.getAllDepartment();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosController>(
      builder: (controller) {
        return SizedBox(
          height: 50,
          width: double.infinity,
          child: FutureBuilder(
            future: futureDepartments,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      var deparment = snapshot.data?[index];
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          height: 10,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: index == controller.selectedIndex.value ? Colors.green : Color.fromARGB(255, 240, 236, 236),
                                width: 5.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              color:  index == controller.selectedIndex.value ? Colors.green :Color.fromARGB(255, 240, 236, 236)),
                          child: Text(
                            deparment.departmentName.toString(),
                            style:  TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: index == controller.selectedIndex.value ? Colors.white :Color.fromARGB(255, 104, 101, 101)),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            controller.changeDepartment(deparment.departmentName.toString());
                            controller.selectedIndex.value = index;
                            // controller.departmentName.value = deparment.departmentName.toString();
                            // print(controller.departmentName.value);
                            // selectedIndex = index;
                          });
                        },
                      );

                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      }
    );
  }
}
