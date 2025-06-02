import 'dart:io';
import 'package:flutter/material.dart';
import '../controles/controle_cadastro_livro.dart';
import '../entidades/livro.dart';
import 'pagina_cadastro_livro.dart';

class PaginaListaLivro extends StatefulWidget {
  const PaginaListaLivro({Key? key}) : super(key: key);

  @override
  PaginaListaLivroState createState() => PaginaListaLivroState();
}

class PaginaListaLivroState extends State<PaginaListaLivro> {
  final ControleCadastroLivro _controle = ControleCadastroLivro();
  List<Livro> _livros = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    carregarLivros();
  }

  Future<void> carregarLivros() async {
    try {
      debugPrint('Carregando livros...');
      setState(() {
        _isLoading = true;
      });
      _livros = await _controle.selecionarTodos();
      debugPrint('Livros carregados: ${_livros.length}');
    } catch (e) {
      debugPrint('Erro ao carregar livros: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar livros: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
        backgroundColor: const Color(0xFF1976D2),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _livros.isEmpty
          ? const Center(child: Text('Nenhum livro cadastrado'))
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _livros.length,
        itemBuilder: (context, index) {
          final livro = _livros[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey[200],
                    ),
                    child: livro.caminhoImagem != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(
                        File(livro.caminhoImagem!),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Erro ao exibir imagem: $error');
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    )
                        : Icon(Icons.book, color: Colors.grey[600], size: 40),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          livro.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          livro.autor,
                          style: const TextStyle(
                            color: Color(0xFF717171),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          debugPrint('Editando livro: ${livro.nome}');
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaginaCadastroLivro(livro: livro),
                            ),
                          );
                          carregarLivros();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmar exclusão'),
                                content: const Text('Tem certeza que deseja excluir este livro?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                                    onPressed: () async {
                                      await _controle.excluir(livro.identificador!);
                                      carregarLivros();
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Livro excluído com sucesso!')),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}