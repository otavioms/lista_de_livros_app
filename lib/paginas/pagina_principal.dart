import 'package:flutter/material.dart';
import 'pagina_lista_livro.dart';
import 'pagina_cadastro_livro.dart';
import 'pagina_configuracoes.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    const PaginaListaLivro(),
    const PaginaCadastroLivro(),
    PaginaConfiguracoes(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      debugPrint('Navegando para índice: $index');
      _indiceAtual = index;
    });
    // Forçar rebuild da tela de lista se voltar para ela
    if (index == 0 && _telas[0] is PaginaListaLivro) {
      (_telas[0] as PaginaListaLivro).createState().setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indiceAtual,
        children: _telas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Livros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}