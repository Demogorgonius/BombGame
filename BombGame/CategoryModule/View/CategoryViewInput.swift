import Foundation

protocol CategoryViewInput: AnyObject {
    func update(with viewModels: [CategoryCellViewModel])
}
