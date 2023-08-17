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

