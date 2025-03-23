//
//  HeroCell.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import UIKit

final class HeroCell: UITableViewCell {
    static let reuseIdentifier = "HeroCell"
    static let height : CGFloat = 110
    

    
    @IBOutlet weak var avatarView: AsyncImage!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setData(name: String, photo: String) {
        nameLabel.text = name
        avatarView.setImage(photo)
    }
}

