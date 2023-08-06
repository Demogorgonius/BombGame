//
//  ModuleBuilder.swift
//  BombGame
//
//  Created by Sergey on 07.08.2023.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol: AnyObject {
    
    func createStartScreenModule(router: RouterProtocol) -> UIViewController
    
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    func createStartScreenModule(router: RouterProtocol) -> UIViewController {
        
        let presenter = StartScreenPresenter(router: router)
        let view = StartScreenView()
        view.presenter = presenter
        return view
        
    }
    
}
