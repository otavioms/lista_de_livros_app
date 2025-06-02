# Lista de Livros

Um aplicativo Flutter desenvolvido para gerenciar uma biblioteca pessoal de livros, oferecendo uma interface intuitiva para adicionar, editar, excluir e visualizar livros, com suporte a imagens de capas.

## Funcionalidades

- **Adicionar Livros**: Cadastre novos livros com nome, autor e imagem da capa.
- **Editar Livros**: Atualize informações de livros existentes.
- **Excluir Livros**: Remova livros da biblioteca de forma segura.
- **Visualizar Lista**: Veja todos os livros cadastrados em uma lista com imagens.
- **Persistência**: Dados salvos em um banco de dados SQLite local.

## Estrutura do Projeto

```
lib/
├── main.dart                           # Ponto de entrada do aplicativo
├── banco_dados/                        # Configurações do banco de dados:
│   ├── acesso_banco_dados.dart           # Inicialização do banco SQLite
│   ├── dicionario_dados.dart             # Definições de tabelas e colunas
├── controles/                          # Lógica de controle (CRUD):
│   ├── controle_cadastro.dart            # Classe base para operações de CRUD
│   ├── controle_cadastro_livro.dart      # Implementação para livros
├── entidades/                          # Modelos de dados:
│   ├── entidade.dart                     # Interface base para entidades
│   ├── livro.dart                        # Modelo de dados para livros
├── paginas/                            # Páginas da interface:
│   ├── pagina_principal.dart             # Página principal com navegação
│   ├── pagina_lista_livro.dart           # Lista de livros
│   ├── pagina_cadastro_livro.dart        # Cadastro e edição de livros
│   ├── pagina_configuracoes.dart         # Configurações do aplicativo
```

## Dependências

As principais dependências usadas no projeto (definidas em `pubspec.yaml`):

- `flutter`: SDK para construção do aplicativo.
- `sqflite`: Banco de dados SQLite para persistência.
- `image_picker`: Seleção de imagens da galeria.
