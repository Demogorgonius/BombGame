import UIKit

final class GameEndAssembly {
    static func assemble() -> UIViewController {
        let router = GameEndScreenViewRouter()
        let settingsManager = SettingsManager()
        let questionsManager = QuestionsManager()
        let presenter = GameEndPresenter(router: router, settingsManager: settingsManager, questionsManager: questionsManager)
        let view = GameEndScreenView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
