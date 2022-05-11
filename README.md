<p align="center">
  <img width=300 src=https://user-images.githubusercontent.com/56546505/167316108-73d100e7-ed1d-4f11-b8f1-063f291241fc.png>
</p>

<p align="center">
  Este é um aplicativo para iOS, baseado na série de televisão Rick & Morty. Nele você consegue acessar informações sobre personagens, episódios e localidades que aparecem no programa. Todas informações usadas no app foram preenchidas com o auxílio da 
<a target="_blank" href=https://rickandmortyapi.com/>Rick And Morty API</a>.
</p>
 
<p align="center">
  <span>
    <img src=https://img.shields.io/badge/iOS-14.0-blue>
    <img src=https://img.shields.io/badge/Swift-5.0-orange>
  </span>
</p>


## Índice 

* [Como rodar](#como-rodar)
* [Funcionalidades principais](#funcionalidades-principais)
* [Aspectos técnicos](#aspectos-técnicos)
* [Problemas a serem resolvidos](#Problemas-a-serem-resolvidos-)
* [Vídeo demonstrativo](#vídeo-demonstrativo)
* [Próximas features](#próximas-features-)


## Como rodar

1. Clone o repositório em sua máquina
2. No diretório do projeto, execute `make gen` (esse script vai executar os comandos do XcodeGen e SwiftGen necessários)
3. Está pronto para usar 🎉

## Funcionalidades principais

_Clique para expandir!_


<details>
  <summary>Listagem de personagens</summary>
  <table>
    <tr>
        <td><img width="290"  src="https://user-images.githubusercontent.com/56546505/167318462-e9fc479d-8cb1-4fc1-aac7-17280932d1c6.png"></td>
        <td><img width="290" src="https://user-images.githubusercontent.com/56546505/167318476-e9e8332b-b0ad-47e0-a98c-3593683c655b.png"></td>
    </tr>
</table>

 </details>

<details>
  <summary>Pesquisa de personagens por nome</summary>
  <table>
    <tr>
        <td><img width="290"  src="https://user-images.githubusercontent.com/56546505/167318681-9f446ba3-a968-491b-84a6-0dcf31c51ecd.png"></td>
        <td><img width="290" src="https://user-images.githubusercontent.com/56546505/167318669-bcd3766d-9172-41fa-b53c-3078f1559dd8.png"></td>
    </tr>
</table>
 </details>

 <details>
  <summary>Detalhes do personagem</summary>
  <table>
    <tr>
        <td><img width="290"  src="https://user-images.githubusercontent.com/56546505/167318866-b72da5ed-38f7-42ff-b971-b71ac84ecb35.png"></td>
        <td><img width="290" src="https://user-images.githubusercontent.com/56546505/167318870-87b307f3-8dc2-473b-b4dc-993b2621d841.png"></td>
    </tr>
</table>
 </details>


## Aspectos técnicos
O projeto desevolvido possui:
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) para configurar o projeto
- [SwiftGen](https://github.com/SwiftGen/SwiftGen) para gerar cores, imagens e textos
- Cache de imagens para otimizar o download
- Carregamento paginado na `UITableView`
- Técnica de [debounce](https://www.treinaweb.com.br/blog/o-que-e-debounce-e-qual-sua-importancia-para-a-performance) para as requisições de pesquisa
- Arquitetura MVVM-C
- Testes unitários

## Problemas a serem resolvidos 🛠

_Clique para expandir!_

 <details>
  <summary>Carregamento de personagem que possui apenas 1 episódio</summary>
  Quando entramos na página do personagem, é feita uma request para buscar informações dos episódios (pelo id) que ele aparece. Porém, quando o personagem possui apenas um EP, o modelo do json é de apenas um objeto, e não uma lista como nos outros casos. Dessa forma, ocorre um erro de decoding e essa seção não é exibida.</br>Exemplo:
  
<ul>
  <li> <a target="_blank" href=https://rickandmortyapi.com/api/episode/10,28>Request de vários episódios</a></li>
  <li><a target="_blank" href=https://rickandmortyapi.com/api/episode/10>Request de 1 episódio</a></li>
</ul>
 </details>

 <details>
  <summary>Bug do tema da navigation bar</summary>
  Ao entrarmos na tela do personagem, trocar de tema e voltar para a tela anterior, as cores da navigation bar da listagem ficam diferentes do que deveriam ser.
<p>
   <img width=300 src=https://user-images.githubusercontent.com/56546505/167321064-4c3056b1-0c87-405e-bf52-f0ad96bad6cc.gif>
  </p>
  
 </details>

<p>Desenvolver feedback de erro para carregamento de mais personagens</p>
<p>Desenvolver feedback de erro para carregamento de episódios</p>

## Vídeo demonstrativo

https://user-images.githubusercontent.com/56546505/167320080-47d3eded-4527-49bf-b28d-65a1297d97e9.mp4

[Figma project 🔗](https://www.figma.com/file/Pg7J1Qt96e3QCWZEQublMF/RickAndMorty?node-id=0%3A1)

## Próximas features ⏱
- Favoritar personagens
- Filtro de personagens por espécie, gênero e status
- Lista de localidades e episódios
- ... e mais!

