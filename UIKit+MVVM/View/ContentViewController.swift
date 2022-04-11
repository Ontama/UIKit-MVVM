//
//  ContentViewController.swift
//  MVP+UIKit
//
//  Created by tomoyo_kageyama on 2022/04/05.
//

import UIKit
import Combine
import CombineCocoa

final class ContentViewController: UIViewController {
    private let tableView = UITableView()
    private var viewModel: LandmarksViewModelTypes!
    private var subscription = Set<AnyCancellable>()
    private var showFavoritesOnly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        viewModel = LandmarksViewModel()
        tableView.didSelectRowPublisher.sink(receiveValue: { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
            // TODO:画面遷移を実装
        }).store(in: &subscription)
        
        viewModel.output.reloadDataPublisher.sink(receiveValue: { [weak self] isOn in
            guard let self = self else { return }
            self.tableView.reloadData()
        }).store(in: &subscription)
        
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame.size = UIScreen.main.bounds.size
        super.viewWillLayoutSubviews()
    }
}

extension ContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.input.numberOfRowsInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0 else {
            return UITableViewCell()
        }
        
        if let additionalCell = viewModel.input.additionalCell(forRow: indexPath.row) {
            let cell = FavoriteOnlyCell(showFavoritesOnly: viewModel.input.showFavoritesOnly)
            cell.delegate = self
            cell.textLabel?.text = additionalCell.rawValue
            return cell
        }
        
        guard let landmark = viewModel.input.landmark(forRow: indexPath.row) else { return UITableViewCell() }
        let cell = LandmarkCell(landmark: landmark)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ContentViewController: FavoriteOnlyCellDelegate {
    func favoriteOnlyCellSwitch(toggle: UISwitch) {
        viewModel.input.tappedToggle(isOn: toggle.isOn)
    }
}
