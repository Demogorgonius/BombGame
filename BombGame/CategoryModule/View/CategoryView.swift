import UIKit

final class CategoryView: BaseViewController {
    
    private let presenter: CategoryViewOutput
    
    private var viewModels = [CategoryCellViewModel]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(width: 175, height: 175)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
        )
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    init(presenter: CategoryViewOutput) {
        self.presenter = presenter
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }
}

extension CategoryView: CategoryViewInput {
    func update(with viewModels: [CategoryCellViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }
}

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath
        ) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.fill(viewModel: viewModels[indexPath.row])
        return cell
    }
}

extension CategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        viewModel.didSelect()
    }
}

private extension CategoryView {
    func addSubviews() {
        self.view.addSubview(collectionView)
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
