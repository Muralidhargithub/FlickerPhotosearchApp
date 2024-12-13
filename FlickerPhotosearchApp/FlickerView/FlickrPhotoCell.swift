import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: FlickrImage) {
        Task {
            if let fetchedImage = try? await NetworkManager.shared.fetchImage(url: image.media.m) {
                DispatchQueue.main.async {
                    self.imageView.image = fetchedImage
                }
            } else {
                self.imageView.image = UIImage(systemName: "photo")
            }
        }
    }
}
