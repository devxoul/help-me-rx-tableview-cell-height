//
//  SimpleTableViewCell.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/24/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class MyCell: UITableViewCell {

    // MARK: Constants

    struct Font {
        static let messageLabel = UIFont.systemFontOfSize(14)
    }


    // MARK: Properties

    let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = Font.messageLabel
    }
    private var disposeBag: DisposeBag?


    // MARK: Initializing

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.messageLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Configuring

    func configure(viewModel: MyCellViewModel) {
        self.disposeBag = DisposeBag()
        guard let disposeBag = self.disposeBag else { return }
        viewModel.message
            .drive(self.messageLabel.rx_text)
            .addDisposableTo(disposeBag)
    }


    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        self.messageLabel.top = 10
        self.messageLabel.left = 10
        self.messageLabel.width = self.contentView.width - 20
        self.messageLabel.sizeToFit()
    }

}