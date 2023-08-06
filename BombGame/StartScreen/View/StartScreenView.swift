//
//  StartScreenView.swift
//  BombGame
//
//  Created by Sergey on 07.08.2023.
//

import Foundation
import UIKit

class StartScreenView: UIViewController {
    
    var presenter: StartScreenPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
    }
}
