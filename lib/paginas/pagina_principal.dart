import 'package:flutter/material.dart';
import '../entidades/livro.dart';
import 'pagina_lista_livro.dart';
import 'pagina_cadastro_livro.dart';
import 'pagina_configuracoes.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _selectedIndex = 0;
  final GlobalKey<PaginaListaLivroState> _listaKey = GlobalKey<PaginaListaLivroState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onBookSaved(Livro livro) {
    if (_listaKey.currentState != null) {
      _listaKey.currentState!.carregarLivros();
    }
    // Voltar para a página inicial (Home) após salvar
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          PaginaListaLivro(key: _listaKey),
          PaginaCadastroLivro(onSave: _onBookSaved),
          PaginaConfiguracoes(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1976D2),
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto',
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}