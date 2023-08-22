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

        DispatchQueue.main.async {
            self.view?.update(with: self.createModel())
        }
    }
    
    func createModel() -> [CategoryCellViewModel] {
        var model: [CategoryCellViewModel] = []
        let catArray = Categories.allCases
    
        for cat in catArray {
            model.append(CategoryCellViewModel(title: cat.rawValue, imageName: "\(cat)", isSelected: self.isSelectedCategory(category: cat), didSelect: {
                self.togleCategory(category: cat)
            }))
            print(cat)
        }
        return model
        
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
