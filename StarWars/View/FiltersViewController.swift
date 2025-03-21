
//  FiltersViewController.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//

import UIKit

// MARK: - Protocolo para comunicação entre ViewControllers

protocol FiltersViewControllerDelegate: AnyObject {
    func didChangeFilter(gender: Gender)
}

// MARK: - Classe FiltersViewController

class FiltersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Propriedades

    var genderPickerView: UIPickerView! // Componente para selecionar o gênero
    var filterButton: UIButton!         // Botão para aplicar o filtro
    var titleLabel: UILabel!            // Título da tela
    var filterImageView: UIImageView!   // Imagem a ser exibida antes do filtro
    
    var selectedGender: Gender = .all   // Filtro selecionado (padrão: "Todos")
    weak var delegate: FiltersViewControllerDelegate? // Delegate para passar o filtro de volta à tela principal

    // MARK: - Ciclo de Vida da ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Configuração da interface gráfica
    }
    
    // MARK: - Configuração da Interface

    func setupUI() {
        self.view.backgroundColor = UIColor.white // Define o fundo da tela

        // Configuração da imagem
        filterImageView = UIImageView(image: UIImage(named: "StarWarsLogo2")) // Substitua "StarWarsLogo2" pelo nome da sua imagem
        filterImageView.contentMode = .scaleAspectFit
        filterImageView.translatesAutoresizingMaskIntoConstraints = false

        // Configuração do título estilizado
        titleLabel = UILabel()
        titleLabel.text = "Filtrar por gênero:"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Configuração do UIPickerView para seleção do gênero
        genderPickerView = UIPickerView()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.backgroundColor = UIColor.systemMint
        genderPickerView.layer.cornerRadius = 10
        genderPickerView.layer.masksToBounds = true
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Seleciona o gênero atual no PickerView como opção padrão
        if let index = Gender.allCases.firstIndex(of: selectedGender) {
            genderPickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
        // Configuração do botão de aplicar filtro
        filterButton = UIButton(type: .system)
        filterButton.setTitle("Aplicar Filtro", for: .normal)
        filterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.backgroundColor = UIColor.black
        filterButton.layer.cornerRadius = 10
        filterButton.layer.shadowColor = UIColor.black.cgColor
        filterButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        filterButton.layer.shadowOpacity = 0.7
        filterButton.layer.shadowRadius = 4
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Adiciona os elementos à view
        self.view.addSubview(filterImageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(genderPickerView)
        self.view.addSubview(filterButton)
        
        // MARK: - Definição de Constraints para Layout Responsivo
        NSLayoutConstraint.activate([
            // Configuração da imagem
            filterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            filterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            filterImageView.widthAnchor.constraint(equalToConstant: 150),  // Ajuste o tamanho conforme necessário
            filterImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Configuração do título
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: filterImageView.bottomAnchor, constant: 10),
            
            // Configuração do UIPickerView
            genderPickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            genderPickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            genderPickerView.widthAnchor.constraint(equalToConstant: 300),
            genderPickerView.heightAnchor.constraint(equalToConstant: 150),
            
            // Configuração do botão
            filterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            filterButton.topAnchor.constraint(equalTo: genderPickerView.bottomAnchor, constant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 200),
            filterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - UIPickerViewDataSource (Configuração do PickerView)

    /// Define o número de colunas no PickerView (apenas 1)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    /// Define o número de opções disponíveis no PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }

    // MARK: - UIPickerViewDelegate (Delegado do PickerView)

    /// Retorna o título das opções disponíveis no PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < Gender.allCases.count else {
            return nil // Caso o índice seja inválido, retorna nil
        }
        return Gender.allCases[row].descricaoEmPortugues // Exibe a descrição em português
    }

    /// Captura a opção selecionada pelo usuário e atualiza a variável `selectedGender`
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = Gender.allCases[row]
        print("Filtro alterado para: \(selectedGender.rawValue)")
    }

    // MARK: - Aplicação do Filtro

    /// Notifica a tela principal sobre o novo filtro e volta à tela anterior
    @objc func applyFilter() {
        delegate?.didChangeFilter(gender: selectedGender) // Envia o filtro escolhido ao delegate
        navigationController?.popViewController(animated: true) // Retorna à tela anterior
    }
}

