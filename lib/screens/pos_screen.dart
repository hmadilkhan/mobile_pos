import 'package:flutter/material.dart';
import 'package:mobile_pos/widgets/pos_screen/departments.dart';
import 'package:mobile_pos/widgets/pos_screen/pos_header.dart';
import 'package:mobile_pos/widgets/pos_screen/product_search.dart';
import 'package:mobile_pos/widgets/pos_screen/products.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
