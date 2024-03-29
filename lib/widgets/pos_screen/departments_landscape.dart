import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';
import 'package:mobile_pos/services/database_helper.dart';
import 'package:mobile_pos/utils/colors.dart';

class DepartmentLandscape extends StatefulWidget {
  const DepartmentLandscape({super.key});

  @override
  State<DepartmentLandscape> createState() => _DepartmentLandscapeState();
}

class _DepartmentLandscapeState extends State<DepartmentLandscape> {
  late final Future futureDepartments = DatabaseHelper.getAllDepartment();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosController>(builder: (controller) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.1,
        color: Colors.black,
        child: FutureBuilder(
            future: futureDepartments,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      var deparment = snapshot.data?[index];

                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(deparment.image),
                            ),
                            Text(deparment.departmentName.toString(),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
    });
  }
}
