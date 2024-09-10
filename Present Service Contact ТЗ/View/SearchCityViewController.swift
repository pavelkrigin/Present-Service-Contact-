//
//  SearchCityViewController.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

protocol SearchCityViewProtocol: AnyObject {
    func showError(_ error: String)
}

class SearchCityViewController: UIViewController {
    var presenter: SearchCityViewProtocol?
    
    private let searchField = UITextField()
    private let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search City"
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        searchField.placeholder = "Enter city name"
        searchField.borderStyle = .roundedRect
        searchField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchField)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 200),
            
            searchButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didTapSearchButton() {
        guard let cityName = searchField.text, !cityName.isEmpty else {
            showError("City name can't be empty")
            return
        }
        presenter?.searchCity(cityName)
    }
}

extension SearchCityViewController: SearchCityViewProtocol {
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
