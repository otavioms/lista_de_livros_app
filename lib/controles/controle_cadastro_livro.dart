import 'package:sqflite/sqflite.dart';
import '../banco_dados/acesso_banco_dados.dart';
import '../banco_dados/dicionario_dados.dart';
import '../entidades/livro.dart';

class ControleCadastroLivro {
  Future<Database> get _bancoDados => AcessoBancoDados().bancoDados;

  Future<void> inserir(Livro livro) async {
    final db = await _bancoDados;
    await db.insert(DicionarioDados.tabelaLivro, livro.toMap());
  }

  Future<void> atualizar(Livro livro) async {
    final db = await _bancoDados;
    await db.update(
      DicionarioDados.tabelaLivro,
      livro.toMap(),
      where: '${DicionarioDados.idLivro} = ?',
      whereArgs: [livro.id],
    );
  }

  Future<void> excluir(int id) async {
    final db = await _bancoDados;
    await db.delete(
      DicionarioDados.tabelaLivro,
      where: '${DicionarioDados.idLivro} = ?',
      whereArgs: [id],
    );
  }

  Future<List<Livro>> selecionarTodos() async {
    final db = await _bancoDados;
    final List<Map<String, dynamic>> mapas = await db.query(DicionarioDados.tabelaLivro);
    return List.generate(mapas.length, (i) => Livro.fromMap(mapas[i]));
  }
}