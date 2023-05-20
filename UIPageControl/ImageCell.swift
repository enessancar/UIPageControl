//
//  ImageCell.swift
//  UIPageControl
//
//  Created by Enes Sancar on 19.05.2023.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    
    //MARK: - Properties
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
      
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        configureImageView()
    }
    
    private func configureImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with image: UIImage) {
        imageView.image = image
    }
}
