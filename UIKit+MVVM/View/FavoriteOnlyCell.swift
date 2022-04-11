//
//  FavoriteOnlyCell.swift
//  MVPProduct
//
//  Created by tomoyo_kageyama on 2022/04/07.
//

import Foundation
import UIKit

protocol FavoriteOnlyCellDelegate: NSObjectProtocol {
    func favoriteOnlyCellSwitch(toggle: UISwitch)
}

final class FavoriteOnlyCell: UITableViewCell {
    private let toggle = UISwitch()
    var delegate: FavoriteOnlyCellDelegate?
    
    init(showFavoritesOnly: Bool) {
        super.init(style: .default, reuseIdentifier: nil)
        accessoryType = .none
        selectionStyle = .none
        
        accessoryView = toggle
        toggle.isOn = showFavoritesOnly
        toggle.addTarget(self, action: #selector(switchTriggered), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        toggle.frame.origin = CGPoint(x: frame.width - toggle.frame.width, y: 0)
        super.layoutSubviews()
    }
    
    @objc func switchTriggered(sender: UISwitch) {
        delegate?.favoriteOnlyCellSwitch(toggle: sender)
    }
}
