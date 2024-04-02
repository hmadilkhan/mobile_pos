import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/colors.dart';
import 'package:mobile_pos/widgets/pos_screen/cart_landscape.dart';
import 'package:mobile_pos/widgets/pos_screen/departments.dart';
import 'package:mobile_pos/widgets/pos_screen/departments_landscape.dart';
import 'package:mobile_pos/widgets/pos_screen/pos_header.dart';
import 'package:mobile_pos/widgets/pos_screen/product_search.dart';
import 'package:mobile_pos/widgets/pos_screen/products.dart';
import 'package:mobile_pos/widgets/pos_screen/products_landscape.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return const Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                PosHeader(),
                ProductSearch(),
                Divider(),
                Department(),
                Divider(),
                Product(),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.charcoal,
          appBar: AppBar(
            leading: Icon(
              Icons.restaurant,
              color: AppColors.white,
            ),
            title: Text(
              "POS",
              style: TextStyle(color: AppColors.white),
            ),
            backgroundColor: AppColors.charcoal,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: AppColors.white,
                  size: 25,
                ),
                onPressed: () {
                  // do something
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 25,
                ),
                onPressed: () {
                  // do something
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person_4_outlined,
                  color: AppColors.white,
                  size: 25,
                ),
                onPressed: () {
                  // do something
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: AppColors.white,
                  size: 25,
                ),
                onPressed: () {
                  // do something
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Text(
                    "A",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Row(children: [
              DepartmentLandscape(),
              ProductsLandscape(),
              Cart(),
            ]),
          ),
        );
      }
    });
  }
}
