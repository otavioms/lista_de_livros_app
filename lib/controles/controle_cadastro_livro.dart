import 'package:lista_de_livros/banco_dados/dicionario_dados.dart';
import 'package:lista_de_livros/entidades/entidade.dart';
import 'package:lista_de_livros/entidades/livro.dart';
import 'package:lista_de_livros/banco_dados/acesso_banco_dados.dart';
import 'controle_cadastro.dart';

class ControleCadastroLivro extends ControleCadastro {
  ControleCadastroLivro() : super(DicionarioDados.tabelaLivro, DicionarioDados.idLivro);

  @override
  Future<Entidade> criarEntidade(Map<String, dynamic> mapaEntidade) async {
    return Livro.criarDeMapa(mapaEntidade);
  }

  Future<void> inserir(Livro livro) async {
    await super.incluir(livro);
    await emitirLista();
  }

  Future<void> atualizar(Livro livro) async {
    await super.alterar(livro);
    await emitirLista();
  }

  @override
  Future<int> excluir(int id) async {
    final resultado = await super.excluir(id);
    await emitirLista();
    return resultado;
  }

  @override
  Future<List<Livro>> selecionarTodos() async {
    final entidades = await super.selecionarTodos();
    return entidades.cast<Livro>();
  }

  Future<Livro?> selecionar(int id) async {
    final entidade = await super.selecionar(id);
    return entidade as Livro?;
  }

  Future<void> limparTabela() async {
    final bancoDados = await AcessoBancoDados().bancoDados;
    await bancoDados.delete(tabela);
    await emitirLista();
  }
}