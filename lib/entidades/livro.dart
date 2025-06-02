import 'package:lista_de_livros/entidades/entidade.dart';
import 'package:lista_de_livros/banco_dados/dicionario_dados.dart';

class Livro implements Entidade {
  @override
  late int identificador;

  String nome;
  String autor;
  String? caminhoImagem;

  Livro(int? identificador, {required this.nome, required this.autor, this.caminhoImagem}) {
    this.identificador = identificador ?? 0; // Para compatibilidade, mas não será usado no insert
  }

  Livro.criarDeMapa(Map<String, dynamic> mapaEntidade)
      : identificador = mapaEntidade[DicionarioDados.idLivro] ?? 0,
        nome = mapaEntidade[DicionarioDados.nome],
        autor = mapaEntidade[DicionarioDados.autor],
        caminhoImagem = mapaEntidade[DicionarioDados.caminhoImagem];

  @override
  Map<String, dynamic> converterParaMapa() {
    final mapa = {
      DicionarioDados.nome: nome,
      DicionarioDados.autor: autor,
      DicionarioDados.caminhoImagem: caminhoImagem,
    };
    return mapa;
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