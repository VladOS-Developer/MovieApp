//
//  SettingsPageView.swift
//  MovieApp
//
//  Created by VladOS on 13.10.2025.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
}

class SettingsPageView: UIViewController, SettingsViewProtocol {
    
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
        cell.cellSetup(cellType: cellItems)
        
        cell.completion = {
            print(indexPath.row)
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
}
