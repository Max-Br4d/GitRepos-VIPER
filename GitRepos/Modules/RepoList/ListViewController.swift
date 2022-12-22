//
//  ListViewController.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import UIKit

import UIKit

protocol ListViewInputs: AnyObject {
    func configure(entities: ListEntities)
    func reloadTableView(tableViewDataSource: ListTableViewDataSource)
    func indicatorView(animate: Bool)
}

protocol ListViewOutputs: AnyObject {
    var entities: ListEntities { get }
    var dependencies: ListPresenterDependencies { get }
    func viewDidLoad()
    func onReachBottom()
}

final class ListViewController: UIViewController {

    internal var presenter: ListViewOutputs?
    internal var tableViewDataSource: TableViewItemDataSource?

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension ListViewController: ListViewInputs {

    func configure(entities: ListEntities) {
        navigationItem.title = "\(entities.entryEntity.language) Repositories"
    }

    func reloadTableView(tableViewDataSource: ListTableViewDataSource) {
        self.tableViewDataSource = tableViewDataSource
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }

    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: animate ? 50 : 0, right: 0)
            _ = animate ? self?.indicatorView?.startAnimating() : self?.indicatorView?.stopAnimating()
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfItems ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleLastIndexPath = tableView.visibleCells.compactMap { [weak self] in
            self?.tableView.indexPath(for: $0)
        }.last
        guard let last = visibleLastIndexPath, last.row > (tableViewDataSource?.numberOfItems ?? 0) - 2 else { return }
        presenter?.onReachBottom()
    }
}

extension ListViewController: Viewable {}
