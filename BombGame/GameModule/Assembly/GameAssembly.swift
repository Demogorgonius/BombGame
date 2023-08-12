import UIKit

final class GameAssembly {
    static func assemble() -> UIViewController {
        let router = GameViewRouter()
        let settingsManager = SettingsManager()
        let questionsManager = QuestionsManager()
        let presenter = GamePresenter(router: router, settingsManager: settingsManager, questionsManager: questionsManager)
        let view = GameView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
