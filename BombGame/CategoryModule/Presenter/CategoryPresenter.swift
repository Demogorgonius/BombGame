import Foundation

final class CategoryPresenter {
    
    weak var view: CategoryViewInput?
    private let router: CategoryRouterInput
    
    init(router: CategoryRouterInput) {
        self.router = router
    }
    
}

extension CategoryPresenter: CategoryViewOutput {
    
    func viewDidLoad() {
        let cellModel: [CategoryCellViewModel] = [.init(title: Categories.geography.rawValue, imageName: "georgraphy", isSelected: self.isSelectedCategory(category: .geography), didSelect: {
            self.togleCategory(category: .geography) }),
         .init(title: Categories.other.rawValue, imageName: "sport", isSelected: self.isSelectedCategory(category: .other), didSelect: {
             self.togleCategory(category: .other)}),
         .init(title: Categories.food.rawValue, imageName: "food", isSelected: self.isSelectedCategory(category: .food), didSelect: {
             self.togleCategory(category: .food)}),
         .init(title: Categories.literature.rawValue, imageName: "literature", isSelected: self.isSelectedCategory(category: .literature), didSelect: {
             self.togleCategory(category: .literature)}),
         .init(title: Categories.music.rawValue, imageName: "music", isSelected: self.isSelectedCategory(category: .music), didSelect: {
             self.togleCategory(category: .music)}),
         .init(title: Categories.internet.rawValue, imageName: "internet", isSelected: self.isSelectedCategory(category: .internet), didSelect: {
             self.togleCategory(category: .internet)})]
        
        DispatchQueue.main.async {
            self.view?.update(with: cellModel)
        }
    }
    
    func togleCategory(category: Categories) {
        
        for (key, _) in SelectedCategories.categories {
            if key == category {
                SelectedCategories.categories.removeValue(forKey: key)
                print("\(key.rawValue): is deselected")
                viewDidLoad()
                return
            }
            
        }
        
        SelectedCategories.categories[category] = true
        print("\(category.rawValue): is selected")
        viewDidLoad()
    }
    
    func isSelectedCategory(category: Categories) -> Bool{
        
        for (key, _) in SelectedCategories.categories {
            
            if key == category {
                
                return true
            }
            
        }
        return false
    }
    
    func homeButtonTapped() {
        router.routeToStartScreen()
    }
}
