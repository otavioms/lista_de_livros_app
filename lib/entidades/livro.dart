import 'package:lista_de_livros/entidades/entidade.dart';
import 'package:lista_de_livros/banco_dados/dicionario_dados.dart';

class Livro implements Entidade {
  @override
  int identificador;

  String nome;
  String autor;
  String? caminhoImagem;

  Livro(this.identificador, {required this.nome, required this.autor, this.caminhoImagem});

  Livro.criarDeMapa(Map<String, dynamic> mapaEntidade)
      : identificador = mapaEntidade[DicionarioDados.idLivro],
        nome = mapaEntidade[DicionarioDados.nome],
        autor = mapaEntidade[DicionarioDados.autor],
        caminhoImagem = mapaEntidade[DicionarioDados.caminhoImagem];

  @override
  Map<String, dynamic> converterParaMapa() {
    return {
      DicionarioDados.idLivro: identificador,
      DicionarioDados.nome: nome,
      DicionarioDados.autor: autor,
      DicionarioDados.caminhoImagem: caminhoImagem,
    };
  }

  @override
  Entidade criarEntidade(Map<String, dynamic> mapaEntidade) {
    return Livro.criarDeMapa(mapaEntidade);
  }

  @override
  Entidade criarCopia() {
    return criarEntidade(converterParaMapa());
  }
}