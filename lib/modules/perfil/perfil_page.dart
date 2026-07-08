import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil'), centerTitle: true),
      body: Center(
        child: Column(crossAxisAlignment: .center, mainAxisAlignment: .center, children: [Text('Perfil')]),
      ),
    );
  }
}
