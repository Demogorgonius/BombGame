//
//  SettingsModuleView.swift
//  BombGame
//
//  Created by Sergey on 12.08.2023.
//

import Foundation
import UIKit
import SnapKit

class SettingsModuleView: BaseViewController {
    
    var presenter: SettingsModulePresenterProtocol!
    private let baseConstants = BaseConstants()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = baseConstants.violetColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: baseConstants.violetColor]
        if #available(iOS 16.0, *) {
            let homeBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        } else {
            let homeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        }
    }
    
    @objc func homeButtonTapped() {
              presenter.backButtonTapped()
    }
    
}

extension SettingsModuleView: SettingsModuleViewProtocol {
    
    
    
}
