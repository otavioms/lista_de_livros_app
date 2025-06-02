import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controles/controle_cadastro_livro.dart';
import '../entidades/livro.dart';

class PaginaCadastroLivro extends StatefulWidget {
  final Livro? livro;
  final Function(Livro)? onSave;

  const PaginaCadastroLivro({Key? key, this.livro, this.onSave}) : super(key: key);

  @override
  _PaginaCadastroLivroState createState() => _PaginaCadastroLivroState();
}

class _PaginaCadastroLivroState extends State<PaginaCadastroLivro> {
  final _controle = ControleCadastroLivro();
  final _nomeController = TextEditingController();
  final _autorController = TextEditingController();
  File? _imagem;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _nomeController.text = widget.livro!.nome;
      _autorController.text = widget.livro!.autor;
      if (widget.livro!.caminhoImagem != null) {
        try {
          _imagem = File(widget.livro!.caminhoImagem!);
          if (!_imagem!.existsSync()) {
            _imagem = null;
            debugPrint('Imagem do livro não encontrada: ${widget.livro!.caminhoImagem}');
          }
        } catch (e) {
          debugPrint('Erro ao carregar imagem: $e');
          _imagem = null;
        }
      }
    }
  }

  Future<void> _selecionarImagem() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagem = File(pickedFile.path);
        });
        debugPrint('Imagem selecionada: ${pickedFile.path}');
      } else {
        debugPrint('Nenhuma imagem selecionada');
      }
    } catch (e) {
      debugPrint('Erro ao selecionar imagem: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao selecionar imagem')),
      );
    }
  }

  Future<void> _salvar() async {
    if (_nomeController.text.isEmpty || _autorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    try {
      final livro = Livro(
        id: widget.livro?.id,
        nome: _nomeController.text,
        autor: _autorController.text,
        caminhoImagem: _imagem?.path,
      );

      if (widget.livro == null) {
        await _controle.inserir(livro);
        debugPrint('Livro inserido: ${livro.nome}');
      } else {
        await _controle.atualizar(livro);
        debugPrint('Livro atualizado: ${livro.nome}');
      }

      if (widget.onSave != null) {
        widget.onSave!(livro);
      }

      // Limpar o estado do formulário
      setState(() {
        _nomeController.clear();
        _autorController.clear();
        _imagem = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Livro salvo com sucesso!')),
      );

      // Não usamos Navigator.pop(), pois a página está no IndexedStack
    } catch (e) {
      debugPrint('Erro ao salvar livro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar livro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? 'Adicionar Livro' : 'Editar Livro'),
        backgroundColor: const Color(0xFF1976D2),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _selecionarImagem,
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _imagem != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _imagem!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Erro ao exibir imagem: $error');
                          return const Center(child: Text('Erro ao carregar imagem'));
                        },
                      ),
                    )
                        : const Center(
                      child: Text(
                        'Clique para adicionar a imagem da capa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do Livro',
                  prefixIcon: const Icon(Icons.book),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _autorController,
                decoration: InputDecoration(
                  labelText: 'Autor',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _autorController.dispose();
    super.dispose();
  }
}