import UIKit
import SnapKit
import Then

final class TextCell: UICollectionViewCell {
  
  static let reuseIdentifier = "text-cell-reuse-identifier"
  
  // MARK: Layout Properties
  
  private let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  private let label = UILabel().then {
    $0.textAlignment = .center
    $0.font = .preferredFont(forTextStyle: .title1)
  }
  
  // MARK: init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  required init?(coder: NSCoder) {
    fatalError("not implemnted")
  }
  
  // MARK: LifeCycle
  
  // MARK: Method
  
  private func setupLayout() {
    self.layer.cornerRadius = 12
    self.clipsToBounds = true
    contentView.backgroundColor = .secondarySystemBackground
    
    contentView.addSubview(imageView)
    contentView.addSubview(label)
    
    imageView.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview()
      make.height.equalTo(self.contentView.snp.width)
    }
    label.snp.makeConstraints { make in
      make.bottom.equalTo(-30)
      make.horizontalEdges.equalToSuperview()
    }
  }
  
  func setImage(imageName: String) {
    self.imageView.tintColor = .tertiarySystemBackground
    self.imageView.image = UIImage(systemName: imageName)
  }
  
  func setTitleText(text: String) {
    self.label.text = text
  }
  
}
