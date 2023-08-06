//
//  StartScreenPresenter.swift
//  BombGame
//
//  Created by Sergey on 07.08.2023.
//

import Foundation
import UIKit

protocol StartScreenPresenterProtocol: AnyObject {
    init(router: RouterProtocol)
}

class StartScreenPresenter: StartScreenPresenterProtocol {
    
    var router: RouterProtocol?
    
    required init(router: RouterProtocol) {
        
        self.router = router
        
    }
    
}
