<p align="center">
<img width=300 src=https://user-images.githubusercontent.com/56546505/167316108-73d100e7-ed1d-4f11-b8f1-063f291241fc.png>
</p>

Este é um aplicativo para iOS, baseado na série de televisão Rick & Morty. Nele você consegue acessar informações sobre personagens, episódios e localidades que aparecem no programa. Todas informações usadas no app foram preenchidas com o auxílio da [Rick And Morty API](https://rickandmortyapi.com/).

<span>
<img src=https://img.shields.io/badge/iOS-14.0-blue>
<img src=https://img.shields.io/badge/Swift-5.0-orange>
</span>
  

## Índice 

* [Como rodar]()
* [Funcionalidades principais]()
* [Aspectos técnicos]()
* [Tecnologias utilizadas]()
* [Vídeo demonstrativo]()
* [Problemas a serem resolvidos]()
* [Próximas features]()


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
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) para configurar o projeto
- [SwiftGen](https://github.com/SwiftGen/SwiftGen) para gerar cores, imagens e textos
- Cache de imagens para otimizar o download
- Carregamento paginado na `UITableView`
- Técnica de [debounce](https://www.treinaweb.com.br/blog/o-que-e-debounce-e-qual-sua-importancia-para-a-performance) para as requisições de pesquisa

