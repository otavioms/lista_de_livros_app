import 'package:flutter/material.dart';
import 'paginas/pagina_principal.dart';

void main() {
  runApp(const ListaLivrosApp());
}

class ListaLivrosApp extends StatelessWidget {
  const ListaLivrosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Livros',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const PaginaPrincipal(),
    );
  }
}