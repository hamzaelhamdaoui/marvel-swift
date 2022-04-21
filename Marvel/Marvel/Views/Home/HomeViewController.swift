//
//  HomeViewController.swift
//  Marvel
//
//  Created by AvantgardeIT on 18/4/22.
//

import Bond
import PaginatedTableView
import ReactiveKit
import SnapKit
import SVProgressHUD
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var charactersTableView: PaginatedTableView!
    @IBOutlet weak var searchTextField: UITextField!

    var viewModel = HomeViewModel()
    var disposeBag = DisposeBag()

    func setupNavigationBar() {
        navigationItem.title = "Marvel"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupActions()
        setupTableView()
        getCharacters()
    }

    func setEmptyView() {
        let view = UIView()
        let label = UILabel()
        label.font = FontHelper.boldFontWithSize(size: 20)
        label.textColor = UIColor.gray
        label.text = "No results"
        label.numberOfLines = 0
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.75)
        }
        charactersTableView.backgroundView = viewModel.characters.value.isEmpty ? view: UIView()
    }

    func setupActions() {
        viewModel.searchText.bidirectionalBind(to: searchTextField.reactive.text)
        viewModel.searchText.observeNext { _ in
            self.getCharacters()
        }.dispose(in: disposeBag)
        viewModel.characters.observeNext { _ in
            self.charactersTableView.reloadData()
            self.setEmptyView()
        }.dispose(in: disposeBag)
        viewModel.isAnimating.observeNext { animating in
            if animating {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }.dispose(in: disposeBag)
        charactersTableView.reactive.selectedRowIndexPath.observeNext { index in
            let character = self.viewModel.characters.value[index.row]
            if let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController {
                detailViewController.setupViewModel(character: character)
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }.dispose(in: disposeBag)
    }

    func setupTableView() {
        charactersTableView.register(UINib(nibName: HomeCell.nibName, bundle: nil), forCellReuseIdentifier: HomeCell.reuseIdentifier)
        charactersTableView.paginatedDelegate = self
        charactersTableView.paginatedDataSource = self
        charactersTableView.separatorStyle = .none
        setEmptyView()
    }

    func getCharacters() {
        self.loadMore(1, 40, onSuccess: nil, onError: nil)
    }
}

extension HomeViewController: PaginatedTableViewDelegate {
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        if pageNumber == 1 {
            viewModel.characters.value = []
        }

        viewModel.fetchCharacters(start: pageNumber, limit: pageSize)
            .then({ results in
                if results.data?.results?.isEmpty ?? true {
                    onSuccess?(false)
                } else {
                    onSuccess?(true)
                }
            })
            .onFail { _ in
                onSuccess?(false)
            }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        HomeCell.rowHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
}

extension HomeViewController: PaginatedTableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier) as! HomeCell
        cell.selectionStyle = .none
        cell.character = viewModel.characters.value[indexPath.row]
        return cell
    }
}

extension HomeViewController {
    func showSuccess(_ message: String?) {
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
        SVProgressHUD.showSuccess(withStatus: message)
    }

    func showError(_ message: String?) {
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
        SVProgressHUD.showError(withStatus: message)
    }

    func showInfo(_ message: String?) {
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
        SVProgressHUD.showInfo(withStatus: message)
    }

    func handleError(_ block: () throws -> Void) {
        do {
            try block()
        } catch let error {
            reportError(error)
        }
    }

    func reportError(_ error: Error) {
        let description = error.localizedDescription
        print("Received error: \(error) with description \(description)")
        showError(description)
    }

    func configureLoadingView(_ animating: Bool) {
        let block = {
            SVProgressHUD.setDefaultMaskType(.clear)
            if animating {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }

        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async(execute: block)
        }
    }
}
