import 'package:lista_de_livros/banco_dados/dicionario_dados.dart';

class Livro {
  int? id;
  String nome;
  String autor;
  String? caminhoImagem;

  Livro({this.id, required this.nome, required this.autor, this.caminhoImagem});

  Map<String, dynamic> toMap() {
    return {
      DicionarioDados.idLivro: id,
      DicionarioDados.nome: nome,
      DicionarioDados.autor: autor,
      DicionarioDados.caminhoImagem: caminhoImagem,
    };
  }

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      id: map[DicionarioDados.idLivro],
      nome: map[DicionarioDados.nome],
      autor: map[DicionarioDados.autor],
      caminhoImagem: map[DicionarioDados.caminhoImagem],
    );
  }
}