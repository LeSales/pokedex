<p align="center">
  <img src="https://static.wikia.nocookie.net/pokepediabr/images/3/38/Pok%C3%A9dex_Kanto.png/revision/latest?cb=20131224014121&path-prefix=pt-br" height="400">
</p>

<p align="center">
  <img src="https://cdn2.bulbagarden.net/upload/4/4b/Pok%C3%A9dex_logo.png">
</p>

<h3 align="center">
Pokédex é um aplicativo para consultar todos os Pokémons existentes, registrar os Pokémons avistados e gerenciar todos os Pokémons capturados 
</h3></br>

## Pré requisitos
Para rodar um projeto em flutter você terá de ter instalado em seu computador:
  - <a href="https://developer.android.com/studio">Android Studio</a>
  - <a href="https://dart.dev/get-dart">Dart SDK</a>
  - <a href="https://flutter.dev/docs/get-started/install">Flutter SDK</a>
  - <a href="https://code.visualstudio.com/">Visual Studio Code</a> (opcional)

## Executando o projeto

O primeiro passo após baixar ou clonar o repositório é adicionar os pacotes necessários. Para isso basta executar no diretório do projeto o comando
```sh
  flutter pub get
```
> Obs: É necessário a configuração do banco de dados <a href="https://firebase.google.com/?hl=pt">Firebase</a>. Para isso basta seguir os <a href="https://firebase.google.com/docs/guides?hl=pt-br">Primeiros passos no Firebase"</a> antes de proseguir com a execução do projeto.

Após os pacotes instalados e Firebase adicionado ao projeto, é necessário ter um dispositivo virtual ou físico para iniciar a execução do projeto com o comando `Ctrl + f5`

<h4>Deseja instalar a última versão diretamente no seu dispositivo? Baixe o <a href="https://drive.google.com/file/d/1agRAEXdlPrCr-kn29GEWEu1tHq-TOkQV/view?usp=sharing">APK</a></h4>

## Preview
<p align="center">
<img src="https://github.com/LeSales/pokedex/blob/main/img_readme/poke5.PNG?raw=true" height="400">
<img src="https://raw.githubusercontent.com/LeSales/pokedex/main/img_readme/poke1.PNG?token=AD2PLQKXDCJVEHBPKLEKHMDBFUXMM" height="400">
<img src="https://raw.githubusercontent.com/LeSales/pokedex/main/img_readme/poke4.PNG?token=AD2PLQOMSLMKDX645FQGYNDBFUXPA" height="400">
<img src="https://raw.githubusercontent.com/LeSales/pokedex/main/img_readme/poke3.PNG?token=AD2PLQI7NGMDBJRMT2Y42UDBFUXQG" height="400">
<img src="https://raw.githubusercontent.com/LeSales/pokedex/main/img_readme/poke2.PNG?token=AD2PLQJJRAKAOJ7RCXPIQGTBFUXU2" height="400">
</p>

## Funcionalidades

- Registro e contador de Pokémons capturados
- Registro e contador de Pokémons vistos
- Registro e contador de Pokémons favoritos
- Autenticação, possibilitando acessar sua pokedéx de multiplos dispositivos, compartilhando um mesmo conjunto de Pokémons 

## Desenvolvimento
Durante o desenvolvimento foram utilizados as seguintes tecnologias: </br>
- <a href="https://dart.dev/">Dart</a> como linguagem base e framework <a href="https://flutter.dev/">Flutter</a>
- <a href="https://pub.dev/packages/provider">Provider</a> para o gerenciamento de estados
- <a href="https://firebase.google.com/?hl=pt">Firebase</a> para autenticação do usuário.
- <a href="https://firebase.google.com/?hl=pt">Cloud Firestore</a> para armazenar os dados do usuário na nuvem.
- <a href="https://pub.dev/packages/graphql_flutter">GraphQL<a/> para consumir os dados da <a href="https://pokeapi.co/">API</a> oficial do <a href="https://www.pokemon.com/br/">Pokémon<a/> (<a href="https://graphql-pokeapi.vercel.app/">API</a> alternativa)
