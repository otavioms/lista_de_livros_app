import 'package:flutter/material.dart';

class PaginaConfiguracoes extends StatefulWidget {
  @override
  _PaginaConfiguracoesState createState() => _PaginaConfiguracoesState();
}

class _PaginaConfiguracoesState extends State<PaginaConfiguracoes> {
  bool _darkMode = false;
  String _selectedLanguage = 'Português';
  final List<String> _languages = ['Português', 'English', 'Español'];

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
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aparência',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SwitchListTile(
                    title: const Text(
                      'Modo Escuro',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    value: _darkMode,
                    activeColor: const Color(0xFF1976D2),
                    onChanged: (bool value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Idioma',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedLanguage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: _languages.map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(
                          language,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedLanguage = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sobre',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Versão do Aplicativo',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    subtitle: const Text(
                      '0.600.3445 | 0.600.3157',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF717171),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Desenvolvedores',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    subtitle: const Text(
                      'Eduardo Esplinio | Otávio Medeiros',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF717171),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}