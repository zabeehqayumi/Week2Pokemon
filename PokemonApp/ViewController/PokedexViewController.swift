//
//  PokedexViewController.swift
//  PokemonApp
//
//  Created by Kevin Yu on 8/14/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let pokemonCellIdentifier = "pokemonCollectionCell"

class PokedexViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Storyboard Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Properties
    
    var pokemonArray = [Pokemon]()  // array of Pokemon to display
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // for Custom Cells with an XIB file (not on Storyboard), register their xib as a nib
        let nib = UINib.init(nibName: "PokemonCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: pokemonCellIdentifier)
        
        // for collectionViews, register custom views for header and footer
        self.collectionView!.register(UICollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                      withReuseIdentifier: "reuse")
        self.collectionView!.register(UICollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                      withReuseIdentifier: "reuse")
    }

    // MARK: UICollectionView Data Source Methods

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // dequeue a reusable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pokemonCellIdentifier,
                                                      for: indexPath) as! PokemonCollectionViewCell
        
        // customize the cell
        
        // check if there is a pokemon in our data
        if let pokemon = SaveDataManager.sharedInstance.pokemon["magby"] {
            // perform an API call to get that pokemon's image
            SaveDataManager.sharedInstance.getImage(pokemon) { (image) in
                // then, set the image on completion, on the main thread to properly update
                DispatchQueue.main.async {
                    cell.imageView.image = image
                    // print("updated image")
                }
            }
        }
    
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout Delegate Methods
    
    // mandatory for header, set up Size for header
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: self.view.frame.size.width, height: 30.0)
    }
    
    // mandatory for footer, set up Size for footer
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: self.view.frame.size.width, height: 30.0)
    }
 
    // mandatory for header and footer, customize+return a header/footer
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: "reuse",
                                                                   for: indexPath) as! UICollectionReusableView
        // create a label and customize it to appear on our UICollectionReusableView
        let label = UILabel.init(frame: CGRect.init(x: 0,
                                                    y: 0,
                                                    width: self.view.frame.size.width,
                                                    height: 30.0))
        
        switch (kind) {
        case UICollectionElementKindSectionHeader:
            if (indexPath.section == 0) {
                label.text = "Pokemons"
            }
            else {
                label.text = "Urlogh"
            }
        case UICollectionElementKindSectionFooter:
            label.text = (indexPath.section == 0) ? "Foot" : "Claw"   // ternary operator
        default:
            label.text = ""
        }
        
        // access each subview and remove all the subviews
        // eliminates having a reusable cell accidentally containing several UILabels inside
        // (would be better to set this up as a custom UICollectionReusableView
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        
        // add our label to the UICollectionReusableView
        view.addSubview(label)
        
        return view
    }
    
    // customize size
    // it is possible to have each object in our collectionView to have different sizes from one another
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: 150, height: 150)
        return size
    }
    
    // MARK: Custom Action Methods
    
    @IBAction func buttonAction(_ sender: Any) {
            // do something here, perhaps perform an API call?
    }
    
}
