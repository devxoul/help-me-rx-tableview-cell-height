//
//  ViewController.swift
//  SimpleTableViewController
//
//  Created by Suyeol Jeon on 6/24/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

class SimpleTableViewController: UIViewController {

    let tableView = UITableView().then {
        $0.registerClass(MyCell.self, forCellReuseIdentifier: "MyCell")
    }

    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, MyCellViewModel>>()
    private let disposeBag = DisposeBag()


    // MARK: Initializing

    init(viewModel: SimpleTableViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Help me!"

        self.tableView.rx_setDelegate(self)
        self.dataSource.configureCell = { _, tableView, indexPath, viewModel in
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as! MyCell
            cell.configure(viewModel)
            return cell
        }

        viewModel.items
            .map { [SectionModel(model: "", items: $0)] }
            .drive(self.tableView.rx_itemsWithDataSource(self.dataSource))
            .addDisposableTo(self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
    }

}


// MARK: - UITableViewDelegate

extension SimpleTableViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellViewModel = self.dataSource.itemAtIndexPath(indexPath)

        // Help me!
        // 1) We have to return the actual `CGFloat` value here.
        // 2) We can only access `MyCellViewModel.message`, which is `Driver<String>`.
        // 3) What should I do?

        // Possible workarounds (maybe code smell) and my opinions:
        //
        // 1) Define `MyCellViewModel.message` as a `Variable<String>`
        //      => I'm trying to not use `Subject` as much as possible.
        //
        // 2) Provide a calculating method such as `MyCellViewModel.messageHeightThatFitsWidth(_:, font:) -> CGFloat`
        //      => This makes `ViewModel` have UI responsibility.
        //
        // 3) Please give me an advice!

        /*return*/ cellViewModel.message // This is `Driver<String>`
            .map { message -> CGFloat in
                let size = CGSize(width: tableView.width - 20, height: .max)
                let options: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
                let attributes = [NSFontAttributeName: MyCell.Font.messageLabel]
                let rect = message.boundingRectWithSize(size, options: options, attributes: attributes, context: nil)
                return rect.height + 20 // I want to return this value
            }

        return 40 // But we have to return actual value here :(
    }

}
