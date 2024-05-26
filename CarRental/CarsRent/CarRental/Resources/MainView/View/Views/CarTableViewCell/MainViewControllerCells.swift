//
//  MainViewControllerCells.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import UIKit
import SnapKit
import SDWebImage

class MainViewControllerCells: UITableViewCell {
    
    private lazy var model: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private lazy var color: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    
    private var rating: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.highlightedTextColor = .blue
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private var price: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.highlightedTextColor = .blue
        label.font = .systemFont(ofSize: 16)
        return label
    }()
  
    func configureCell(with car: MainTableCellViewModel) {
        model.text = car.model.rawValue
        color.text = car.color.rawValue.capitalized
        rating.text = car.rating + "/5"
        price.text = car.price + "/ month"
        likeButton.isSelected = car.like

        if let imageURL = URL(string: car.avatar) {
            avatar.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder")) { (_, error, _, _) in
                if let error = error {
                    print("Error loading image:", error.localizedDescription)
                }
            }
        }
    }



    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViewCell() {
        
        addSubview(price)
        addSubview(rating)
        addSubview(rating)
        addSubview(model)
        addSubview(color)
        addSubview(avatar)
        addSubview(likeButton)
        
        avatar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
            make.size.equalTo(Constant.imageSize)
            make.height.equalTo(89)
            make.width.equalTo(400)
        }
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.top).offset(4)
            make.right.equalTo(avatar.snp.right).offset(-4)
            make.size.equalTo(Constant.likeButtonSize)
        }
        model.snp.makeConstraints { make in
            make.top.equalTo(rating.snp.top).offset(-50)
            make.left.equalToSuperview().offset(9)
        }
        color.snp.makeConstraints { make in
            make.top.equalTo(rating.snp.top).offset(-26)
            make.left.equalToSuperview().offset(9)
        }
        price.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-18)
            make.right.equalToSuperview().offset(-8)
        }
        rating.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-18)
            make.left.equalToSuperview().offset(8)
        }
    }

}
private enum Constant {
    static let imageSize: CGSize = .init(width: 360, height: 180)
    static let likeButtonSize: CGSize = .init(width: 20, height: 20)

}
