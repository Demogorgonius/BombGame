import UIKit
import SnapKit

extension CategoryCollectionViewCell {
    struct Constants {
        let radius: CGFloat = 50.0
        let imageSize: CGFloat = 100.0
        let titleSidePadding: CGFloat = 8.0
        let titleTopPadding: CGFloat = 10
        
        let titleColor: UIColor = BombColor.yellow.color
        let backgroundColor: UIColor = BombColor.violet.color
    }
}

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let constants: Constants
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = constants.titleColor
        label.font = .bold32
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        self.constants = Constants()
        super.init(frame: frame)
        setupCell()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 3.5
    }
    
    func fill(viewModel: CategoryCellViewModel) {
        self.imageView.image = UIImage(named: viewModel.imageName)
        self.titleLabel.text = viewModel.title
    }
}

private extension CategoryCollectionViewCell {
    func setupCell() {
        self.clipsToBounds = true
        self.backgroundColor = constants.backgroundColor
    }
    
    func addSubviews() {
        [imageView, titleLabel].forEach({ self.addSubview($0) })
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.equalTo(constants.imageSize)
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.titleSidePadding)
            make.top.equalTo(imageView.snp.bottom).inset(constants.titleTopPadding)
        }
    }
}
