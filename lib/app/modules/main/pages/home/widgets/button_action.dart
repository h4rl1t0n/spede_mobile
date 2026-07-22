// import 'package:flutter/material.dart';

// class ButtonAction extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const ButtonAction({super.key, required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final secondary = colorScheme.secondary;

//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(18),
//         onTap: () {},
//         child: Column(
//           spacing: 10,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 30, color: secondary),
//             Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }
