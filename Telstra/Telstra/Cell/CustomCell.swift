//
//  CustomCell.swift
//  Telstra
//
//  Created by Siavash on 17/4/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import SnapKit

final class CustomCell: UITableViewCell {
    
    private lazy var dataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constant.fontSize)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.fontSize)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        // cleanup 
        _ = contentView.subviews.map({ $0.removeFromSuperview() })
        contentView.addSubview(dataImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    private func remakeConstraints() {
        dataImageView.snp.remakeConstraints { (make) in
            make.size.equalTo(dataImageView.image == nil ? 0:30)
            make.left.top.equalTo(Constant.defaultMargin)
            make.bottom.lessThanOrEqualTo(subtitleLabel).priority(500)

        }

        titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(dataImageView)
            make.height.greaterThanOrEqualTo(22).priority(500)
            make.left.equalTo(dataImageView.snp.right).offset(8)
            make.right.equalTo(-Constant.defaultMargin)
        }
        subtitleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(-Constant.defaultMargin)
        }
    }
    
    func config(with data: RowViewModel) {
        // only gets downloaded and cached as they appeared on the screen
        dataImageView.sd_setImage(with: data.imageHref) { (img, r, SDImageCacheTypeNone, imageHref) in
            DispatchQueue.main.async {
                self.remakeConstraints() // update constraints 
            }
        }
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.description
        remakeConstraints()
    }
}
