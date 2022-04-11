//
//  LandmarksViewModel.swift
//  UIKit+MVVM
//
//  Created by tomoyo_kageyama on 2022/04/11.
//

import Foundation
import Combine

protocol LandmarksViewModelInput {
    var showFavoritesOnly: Bool { get }
    var numberOfRowsInSection: Int { get }
    var filteredLandmarks: [Landmark] { get }
    func additionalCell(forRow row: Int) -> Addition?
    func landmark(forRow row: Int) -> Landmark?
    func tappedToggle(isOn: Bool)
}

protocol LandmarksViewModelOutput {
    var reloadDataPublisher: AnyPublisher<Bool, Never> { get }
}

protocol LandmarksViewModelTypes {
    var input: LandmarksViewModelInput { get }
    var output: LandmarksViewModelOutput { get }
}

enum Addition: String, CaseIterable, Codable {
    case favorite = "Favorites only"
}

final class LandmarksViewModel: LandmarksViewModelInput, LandmarksViewModelTypes, LandmarksViewModelOutput {
    private let modelData = ModelData()
    private let reloadDataSubject = PassthroughSubject<Bool, Never>()
    private var subscription = Set<AnyCancellable>()
    var showFavoritesOnly = false
    let numberOfSections = 1
    
    var input: LandmarksViewModelInput { self }
    var output: LandmarksViewModelOutput { self }
    
    var reloadDataPublisher: AnyPublisher<Bool, Never> {
        return reloadDataSubject.eraseToAnyPublisher()
    }

    var numberOfRowsInSection: Int {
        return Addition.allCases.count + filteredLandmarks.count
    }

    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter({ landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        })
    }

    func additionalCell(forRow row: Int) -> Addition? {
        guard row < Addition.allCases.count else { return nil }
        return Addition.allCases[row]
    }
    
    func landmark(forRow row: Int) -> Landmark? {
        let index = row - Addition.allCases.count
        guard index < filteredLandmarks.count else { return nil }
        return filteredLandmarks[index]
    }
    
    func tappedToggle(isOn: Bool) {
        showFavoritesOnly = isOn
        reloadDataSubject.send(isOn)
    }
}
