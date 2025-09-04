# App Meus Gastos

## Descrição

O app Meus Gastos é uma aplicação desenvolvida em Flutter para ajudar os usuários a controlar seus gastos de acordo com suas respectivas categorias. O aplicativo utiliza Firebase para gerenciamento de dados e autenticação, e faz uso dos padrões BLOC e Provider para gerenciamento de estado.

## Funcionalidades

- Adição de despesas com categorização.
- Visualização de despesas por categoria.
- Gráficos e relatórios de gastos.
- Autenticação de usuários via Firebase.
- Sincronização em tempo real dos dados.
- Interface intuitiva e fácil de usar.

## Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento de aplicativos móveis.
- **Firebase**: Plataforma de backend para autenticação, banco de dados em tempo real e armazenamento.
- **BLOC + Provider**: Pacotes padrão de gerenciamento de estado do Flutter no projeto.

## Como Rodar o Projeto

### Pré-requisitos

- Flutter SDK (versão 2.0 ou superior)
- Conta no Firebase

### Instalação

1. Clone o repositório:
    ```sh
    git clone https://github.com/samuelbaldaso/MeusGastosApp.git
    cd MeusGastosApp
    ```

2. Instale as dependências:
    ```sh
    flutter pub get
    ```

3. Configure o Firebase:
    - Crie um novo projeto no Firebase.
    - Adicione um aplicativo Android/iOS ao projeto.
    - Baixe o arquivo `google-services.json` (Android) ou `GoogleService-Info.plist` (iOS) e coloque na pasta correspondente (`android/app` ou `ios/Runner`).
    - Habilite a autenticação por email/senha no Firebase Authentication.
    - Configure o Firebase Firestore.

4. Execute o aplicativo:
    ```sh
    flutter run
    ```

### Contribuição

Se você deseja contribuir com o projeto, por favor, siga os seguintes passos:

1. Faça um fork do repositório.
2. Crie uma branch para sua feature (`git checkout -b feature/nome-da-feature`).
3. Comite suas alterações (`git commit -m 'Adiciona nova feature'`).
4. Faça um push para a branch (`git push origin feature/nome-da-feature`).
5. Abra um Pull Request.

---

Desenvolvido com ❤️ por Samuel Baldasso
