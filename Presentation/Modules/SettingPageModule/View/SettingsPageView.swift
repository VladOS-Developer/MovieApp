//
//  SettingsPageView.swift
//  MovieApp
//
//  Created by VladOS on 13.10.2025.
//

import UIKit

protocol SettingsPageViewProtocol: AnyObject {
    func openPasscodeModule(isSetting: Bool)
    func showAlert(title: String, message: String)
}

class SettingsPageView: UIViewController, SettingsPageViewProtocol {
    
    var presenter: SettingsPresenterProtocol!
    
    lazy var tabelView: UITableView = {
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = .appBGTop
        $0.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        return $0
    }(UITableView(frame: view.bounds, style: .insetGrouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabelView)
        view.backgroundColor = .appBGTop
        
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
        
        navigationController?.navigationBar.barTintColor = .appBGBottom
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(false)
    }
    
    func openPasscodeModule(isSetting: Bool) {
        
        let passcodeVC = Builder.getPasscodeController(sceneDelegate: nil, isSetting: isSetting)
        navigationController?.pushViewController(passcodeVC, animated: true)
    }

    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
        
}

extension SettingsPageView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        
        let cellItems = SettingItems.allCases[indexPath.row]
        
        cell.configureSettingsCell(cellType: cellItems)
        
        cell.completion = { [weak self] in
            
            guard let self else { return }
            
            switch SettingItems.allCases[indexPath.row] {
            case .changePassword:
                presenter.didSelectChangePassword()
            case .deletePassword:
                presenter.didSelectDeletePassword()
            }
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
}
