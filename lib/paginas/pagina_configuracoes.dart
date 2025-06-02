import 'package:flutter/material.dart';
import '../banco_dados/acesso_banco_dados.dart';
import '../banco_dados/dicionario_dados.dart';
import '../controles/controle_cadastro_livro.dart';

class PaginaConfiguracoes extends StatelessWidget {
  final ControleCadastroLivro _controle = ControleCadastroLivro();

  PaginaConfiguracoes({Key? key}) : super(key: key);

  Future<void> _limparBancoDados(BuildContext context) async {
    final db = await AcessoBancoDados().bancoDados;
    await db.delete(DicionarioDados.tabelaLivro);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Banco de dados limpo')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _limparBancoDados(context),
          child: const Text('Limpar Banco de Dados'),
        ),
      ),
    );
  }
}