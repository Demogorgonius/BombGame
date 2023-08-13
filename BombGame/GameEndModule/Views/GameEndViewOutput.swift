
protocol GameEndViewOutput {
    func restartButtonTapped()
    func punishmentButtonTapped()
    func homeButtonTapped()
    func getPunishment() -> String
    func getSettings()
    var settings: GameSettings? { get }
}
