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

class SearchCityViewController: UIViewController, SearchCityViewProtocol {
    var presenter: SearchCityPresenterProtocol?
    
    private let searchBar = UISearchBar()
    private let searchButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search City"
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        searchBar.placeholder = "Enter city name"
        searchBar.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 50)
        view.addSubview(searchBar)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        searchButton.frame = CGRect(x: 20, y: 160, width: view.bounds.width - 40, height: 50)
        view.addSubview(searchButton)
    }
    
    @objc private func didTapSearchButton() {
        guard let cityName = searchBar.text, !cityName.isEmpty else { return }
        presenter?.searchCity(cityName)
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
