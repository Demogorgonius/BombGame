import UIKit

final class CategoryView: BaseViewController {
    
    private let presenter: CategoryViewOutput
    private let baseConstants: BaseConstants
    
    private var viewModels = [CategoryCellViewModel]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
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
        self.baseConstants = BaseConstants()
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
        navigationController?.navigationBar.tintColor = baseConstants.violetColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: baseConstants.violetColor]
        if #available(iOS 16.0, *) {
            let homeBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        } else {
            let homeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        }
    }
    
    @objc func homeButtonTapped() {
        presenter.homeButtonTapped()
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
//            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges).offset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
