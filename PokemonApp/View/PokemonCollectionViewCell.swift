//
//  PokemonCollectionViewCell.swift
//  PokemonApp
//
//  Created by Kevin Yu on 8/14/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

// this custom class is extremely simple, "dumb-view"
// just has a xib with an imageView and an outlet for superView to access and set images with

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
