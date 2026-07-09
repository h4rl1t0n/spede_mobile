import 'package:flutter/material.dart';

import 'drawer_content.dart';
import 'drawer_head.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,

      child: Column(
        children: [
          DrawerHead(),
          Expanded(child: DrawerContent()),
          Text('v2.10.30'),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
