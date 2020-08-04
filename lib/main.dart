import 'package:flutter/material.dart';
import 'package:formulario_cadastro/pages/formulario_page.dart';
import 'package:formulario_cadastro/pages/home_page.dart';
import 'package:formulario_cadastro/routes.dart';

void main() => runApp(MeuApp());

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
      routes: {
        AppRoutes.HOME_PAGE: (ctx) => HomePage(),
        AppRoutes.FORMULARIO_PAGE: (ctx) => FormularioPage(),
      },
    );
  }
}
