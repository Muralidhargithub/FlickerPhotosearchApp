import UIKit
import Foundation

class FlickrPhotoDetailViewController: UIViewController {
    private let photo: FlickrImage

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()

    init(photo: FlickrImage) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }

    private func setupUI() {
        view.backgroundColor = .white

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        authorLabel.font = .systemFont(ofSize: 16)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        dateLabel.font = .italicSystemFont(ofSize: 14)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, descriptionLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }

    private func configure() {
        titleLabel.text = "Title: \(photo.title ?? "N/A")"
        authorLabel.text = "Author: \(photo.author ?? "Unknown")"
        descriptionLabel.text = photo.description ?? "No Description"
        if let url = URL(string: photo.link) {
            Task {
                do {
                    let image = try await NetworkManager.shared.fetchImage(url: url.absoluteString)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        }
    }
}
