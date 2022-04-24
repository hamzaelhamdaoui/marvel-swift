//
//  DetailViewController.swift
//  Marvel
//
//  Created by AvantgardeIT on 21/4/22.
//

import Nuke
import ReactiveKit
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resourcesTable: UITableView!
    @IBOutlet weak var comicsButton: UIButton!
    @IBOutlet weak var seriesButton: UIButton!
    @IBOutlet weak var storiesButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!

    var viewModel: DetailViewModel?
    var disposeBag = DisposeBag()
    
    @IBAction func changeResourceType(_ sender: UIButton) {
        if sender == self.comicsButton {
            viewModel?.selectedResourceType.value = .comics
        } else if sender == self.seriesButton {
            viewModel?.selectedResourceType.value = .series
        } else if sender == self.storiesButton {
            viewModel?.selectedResourceType.value = .stories
        } else if sender == self.eventsButton {
            viewModel?.selectedResourceType.value = .events
        }
    }

    func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = viewModel?.character.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureView()
        setActions()
        configureImage()
        configureTable()
        setStyles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func setupViewModel(character: Character) {
        viewModel = DetailViewModel(character: character)
    }

    func configureView() {
        descriptionLabel.text = viewModel?.character.description
        characterImage.image = UIImage(named: "ic_placeholder")
    }

    func setActions() {
        viewModel?.selectedResourceType.observeNext(with: { _ in
            self.configureResourcesStackView()
            self.resourcesTable.reloadData()
        }).dispose(in: disposeBag)
    }

    func configureImage() {
        if let imageUrl = viewModel?.character.thumbnail?.path,
           let imgExtension = viewModel?.character.thumbnail?.thExtension,
           let url = APIService.shared.getImageURL(urlString: imageUrl, imgExtension: imgExtension, imgVariant: "landscape_xlarge") {
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "ic_placeholder"),
                transition: .fadeIn(duration: 0.33)
            )
            characterImage.setupImageViewer(options: [.closeIcon(UIImage(named: "ico_close")!), .theme(.dark)], from: self)
            Nuke.loadImage(with: url, options: options, into: characterImage, progress: nil, completion: nil)
        }
    }

    func configureTable() {
        resourcesTable.register(UINib(nibName: DetailCell.nibName(), bundle: nil), forCellReuseIdentifier: DetailCell.reuseIdentifier())
        resourcesTable.delegate = self
        resourcesTable.dataSource = self
        resourcesTable.separatorStyle = .none
    }

    func setStyles() {
        descriptionLabel.font = FontHelper.regularFontWithSize(size: 16)
        descriptionTitle.font = FontHelper.semiBoldFontWithSize(size: 16)
        descriptionLabel.textColor = .gray
        descriptionTitle.textColor = .black
        comicsButton.setTitle(ResourceType.comics.resourceName, for: .normal)
        seriesButton.setTitle(ResourceType.series.resourceName, for: .normal)
        storiesButton.setTitle(ResourceType.stories.resourceName, for: .normal)
        eventsButton.setTitle(ResourceType.events.resourceName, for: .normal)
        configureResourcesStackView()
    }

    func configureResourcesStackView() {
        guard let viewModel = viewModel else { return }
        var styles = [(textColor: UIColor, backgroundColor: UIColor)]()
        let style = (UIColor.black, UIColor.lightGray)
        let selectedStyle = (UIColor.white, UIColor.darkGray)
        switch viewModel.selectedResourceType.value {
        case .comics:
            styles = [selectedStyle, style, style, style]
        case .series:
            styles = [style, selectedStyle, style, style]
        case .stories:
            styles = [style, style, selectedStyle, style]
        case .events:
            styles = [style, style, style, selectedStyle]
        }
        [comicsButton, seriesButton, storiesButton, eventsButton].enumerated().forEach { index, button in
            button?.tintColor = styles[index].backgroundColor
            button?.setTitleColor(styles[index].textColor, for: .normal)
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DetailCell.cellHeight
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getItemsByResourceType().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier(), for: indexPath) as! DetailCell
        let items = viewModel?.getItemsByResourceType()
        cell.title = items?[indexPath.row].name
        return cell
    }
}
