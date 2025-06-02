import 'package:flutter/material.dart';
import '../controles/controle_cadastro_livro.dart';
import 'pagina_principal.dart';

class PaginaConfiguracoes extends StatefulWidget {
  const PaginaConfiguracoes({Key? key}) : super(key: key);

  @override
  _PaginaConfiguracoesState createState() => _PaginaConfiguracoesState();
}

class _PaginaConfiguracoesState extends State<PaginaConfiguracoes> {
  bool _isDarkMode = false;
  String _idiomaSelecionado = 'Português';
  final List<String> _idiomas = ['Português', 'Inglês', 'Espanhol'];
  final ControleCadastroLivro _controle = ControleCadastroLivro();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tema',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            SwitchListTile(
              title: const Text('Modo Escuro'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              activeColor: const Color(0xFF1976D2),
            ),
            const SizedBox(height: 16),
            const Text(
              'Idioma',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            DropdownButton<String>(
              value: _idiomaSelecionado,
              isExpanded: true,
              items: _idiomas.map((String idioma) {
                return DropdownMenuItem<String>(
                  value: idioma,
                  child: Text(idioma),
                );
              }).toList(),
              onChanged: (String? novoValor) {
                setState(() {
                  _idiomaSelecionado = novoValor!;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Ações',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Limpar Banco de Dados'),
                        content: const Text('Tem certeza que deseja limpar todos os livros? Esta ação não pode ser desfeita.'),
                        actions: [
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Limpar', style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              try {
                                await _controle.limparTabela();
                                Navigator.of(context).pop(); // Fecha o diálogo
                                // Volta para a PaginaPrincipal e define a aba da lista
                                Navigator.popUntil(
                                  context,
                                      (route) => route.isFirst, // Retorna até a primeira rota (PaginaPrincipal)
                                );
                                // Define a aba da lista como ativa
                                final paginaPrincipalState = context.findAncestorStateOfType<PaginaPrincipalState>();
                                if (paginaPrincipalState != null) {
                                  paginaPrincipalState.setState(() {
                                    paginaPrincipalState.currentIndex = 0; // Aba da lista
                                  });
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Banco de dados limpo com sucesso!')),
                                );
                              } catch (e) {
                                debugPrint('Erro ao limpar banco: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Erro ao limpar banco: $e')),
                                );
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Limpar Banco de Dados',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Desenvolvido por:\nEduardo Esplinio e Otávio Medeiros\nVersão: 0.600.3445 | 0.600.3157',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}