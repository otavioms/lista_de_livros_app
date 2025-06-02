import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dicionario_dados.dart';

class AcessoBancoDados {
  static final AcessoBancoDados _instancia = AcessoBancoDados._criarInstancia();
  factory AcessoBancoDados() => _instancia;
  AcessoBancoDados._criarInstancia();

  Database? _bancoDados;

  Future<Database> get bancoDados async {
    _bancoDados ??= await _iniciarBancoDados();
    return _bancoDados!;
  }

  Future<Database> _iniciarBancoDados() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String caminho = join(diretorio.path, DicionarioDados.arquivoBancoDados);
    debugPrint('Caminho do banco de dados: $caminho');
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarTabelas,
    );
  }

  Future<void> _criarTabelas(Database bancoDados, int versao) async {
    await bancoDados.execute('''
      CREATE TABLE ${DicionarioDados.tabelaLivro} (
        ${DicionarioDados.idLivro} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DicionarioDados.nome} TEXT NOT NULL,
        ${DicionarioDados.autor} TEXT NOT NULL,
        ${DicionarioDados.caminhoImagem} TEXT
      )
    ''');
  }
}