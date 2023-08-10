import Foundation

struct CategoryCellViewModel {
    let title: String
    let imageName: String
    var isSelected: Bool
    let didSelect: () -> ()
}
