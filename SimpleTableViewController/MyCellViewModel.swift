//
//  MyCellViewModel.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/24/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import RxCocoa
import RxSwift

protocol MyCellViewModelType {
    var message: Driver<String> { get }
}

class MyCellViewModel: MyCellViewModelType {

    let message: Driver<String>

    init(model: MyModel) {
        self.message = Driver.just(model.message) // Let's be simple here
    }

}
