import 'package:flutter/material.dart';

import '../../../../core/extensions/size_extension.dart';
import '../../home_controller.dart';
import 'drawer_content.dart';
import 'drawer_head.dart';

class CustomDrawer extends StatelessWidget {
  final HomeController controller;

  const CustomDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.screenWidth,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHead(controller: controller),
          Expanded(child: DrawerContent(controller: controller)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'v2.10.30',
              style: TextStyle(color: Colors.grey, fontWeight: .w600),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
