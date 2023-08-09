//
//  RulesViewController.swift
//  BombGame
//
//  Created by Кирилл Корнев on 08.08.2023.
//

import UIKit

final class RulesViewController: UIViewController {
    
    let moduleView = RulesView()
    
    override func loadView() {
        view = moduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
