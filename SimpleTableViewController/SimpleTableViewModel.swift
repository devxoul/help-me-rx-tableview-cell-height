//
//  SimpleTableViewModel.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/24/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import RxCocoa
import RxSwift

protocol SimpleTableViewModelType {
    var items: Driver<[MyCellViewModel]> { get }
}

class SimpleTableViewModel: SimpleTableViewModelType {

    let items: Driver<[MyCellViewModel]>

    init() {
        let dummyModels = [
            MyModel(message: "Rx is a generic abstraction of computation expressed through Observable<Element> interface."),
            MyModel(message: "This is a Swift version of Rx."),
            MyModel(message: "It tries to port as many concepts from the original version as possible, but some concepts were adapted for more pleasant and performant integration with iOS/OSX environment"),
            MyModel(message: "Cross platform documentation can be found on ReactiveX.io."),
            MyModel(message: "Like the original Rx, its intention is to enable easy composition of asynchronous operations and event/data streams."),
            MyModel(message: "KVO observing, async operations and streams are all unified under abstraction of sequence"),
            MyModel(message: "This is the reason why Rx is so simple, elegant and powerful."),
        ]
        let viewModels = dummyModels.map { MyCellViewModel(model: $0) }
        self.items = Driver.just(viewModels)
    }

}
