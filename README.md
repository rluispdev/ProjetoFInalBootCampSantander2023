
![Template rluipdev](rluispdev(1).png)

# 🌌 ElencoStarWars App

Um aplicativo iOS criado com **UIKit** que consome dados da **API SWAPI** para exibir personagens da franquia Star Wars. Ele permite visualizar detalhes dos personagens e aplicar filtros por gênero. 
App criado como resolução de desafio para o Santander Bootcamp 2023 -  Mobile iOS com Swift.


---

## 🧱 Estrutura do Projeto

### 📦 Classes Principais

#### `AppDelegate`

Gerencia o ciclo de vida do app.

#### `SceneDelegate`

Configura a janela principal e gerencia o ciclo de vida da cena.

#### `ViewController`

Tela principal que exibe a lista de personagens.

#### `DetailViewController`

Tela de detalhes do personagem selecionado.

#### `FiltersViewController`

Tela de filtro por gênero, usando um `UIPickerView`.

#### `CharacterService`

Responsável por buscar personagens da API da SWAPI.

#### `CharacterViewModel`

ViewModel que armazena os dados da tela principal e aplica filtros.

---

## 👨‍🚀 Modelos e Enumerações

### `Character`

Representa um personagem com os seguintes atributos:

- `name`, `height`, `mass`, `hair_color`, `skin_color`, `eye_color`, `birth_year`, `gender`

Conforma a: `Decodable`, `Sendable`

### `APIResponse`

Modelo da resposta da API:

- `next: String?`
- `results: [Character]`

### `Gender`

Enumeração de gêneros disponíveis:

```swift
enum Gender: String, CaseIterable {
  case all
  case female
  case hermaphrodite
  case male
  case n_a
  case none
}
```

Inclui a propriedade:

- `descricaoEmPortugues` – para exibir nomes traduzidos

---

## 🔄 Delegates e Protocolos

### `FiltersViewControllerDelegate`

Define o método:

```swift
func didChangeFilter(gender: Gender)
```

Implementado pela `ViewController` para receber os filtros escolhidos.

---

## 🧩 Relacionamento Entre Componentes

- `ViewController` → mostra lista de personagens com filtro
- `CharacterViewModel` → provê dados para `ViewController`
- `CharacterService` → busca dados da SWAPI
- `FiltersViewController` → envia novo filtro para `ViewController`
- `DetailViewController` → exibe detalhes completos de um personagem

---

## 🖥️ Funcionalidades

✅ Listagem paginada de personagens  
✅ Filtro por gênero via Picker  
✅ Visualização de detalhes do personagem  
✅ Integração com SWAPI  
✅ Arquitetura baseada em MVC + ViewModel

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Swift
- **Framework UI:** UIKit
- **Padrões:** MVC, ViewModel, Delegates
- **API:** [SWAPI.dev](https://swapi.dev/)
- **Ferramentas:** Xcode, Interface Builder

---

## 🚀 Como Rodar o Projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/rluispdev/ProjetoFInalBootCampSantander2023
   ```

2. Abra o projeto no Xcode:
   ```bash
   open StarWars.xcodeproj
   ```

3. Execute no simulador ou dispositivo real.

---

## 🧑‍💻 Contribuições

Sinta-se livre para enviar Pull Requests ou abrir issues com sugestões e bugs.

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

---

## 👨‍💻 Student
<p>
    <img 
      align=left 
      margin=10 
      width=80 
      src="https://avatars.githubusercontent.com/u/128305083?s=96&v=4"
    />
    <p>&nbsp&nbsp&nbsprluispdev<br>
    &nbsp&nbsp&nbsp
     <a href="https://rluispdev.github.io/portifolio/" target="_blank"> Portifólio</a>
&nbsp;|&nbsp;
    <a href="https://github.com/rluispdev" target="_blank">
    GitHub</a>&nbsp;|&nbsp;
     <a href="https://cursos.alura.com.br/user/rluisp" target="_blank"> Alura Profile</a>
&nbsp;|&nbsp;
       <a href="https://www.dio.me/users/rluispdev" target="_blank">DIO</a>
&nbsp;|&nbsp;      
    <a href="https://www.linkedin.com/in/rafael-luis-gonzaga-b11634186/" target="_blank">LinkedIn</a>
&nbsp;|&nbsp;
    <a href="https://www.instagram.com/rluispdevs?igsh=cnoxenpmaHY1amE0&utm_source=qr" target="_blank">
    Instagram</a>
&nbsp;|&nbsp;</p>
</p>
<br/><br/>
<p>

