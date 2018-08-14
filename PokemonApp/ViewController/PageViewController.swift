//
//  PageViewController.swift
//  ScrollAndPageView
//
//  Created by Kevin Yu on 8/13/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

import UIKit

protocol A { }
protocol B { }
protocol C { }

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, A, B, C {
    
    // our array of VC's and the index of VC that we are in
    private var characterVC = [CustomUserViewController]()
    private var currentVCIndex = 0
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the Pokemon with Pokedex Number 240
        // this should be moved elsewhere, more programmatic
        SaveDataManager.sharedInstance.getPokemon(240)
        
        // set UIPageViewController Data Source as self, mandatory
        self.dataSource = self
        
        // set up our pageView
        self.setupViewControllers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Setup Methods
    
    func setupViewControllers() {
        // if a VC is setup on a Storyboard, you can reference its storyboard like so
        let storyboard = self.storyboard!
        
        // create our three VCs that we want to show and customize them as desired
        let ashVC = storyboard.instantiateViewController(withIdentifier: "CustomUserViewController") as! CustomUserViewController
        ashVC.characterName = .Ash
        let brockVC = storyboard.instantiateViewController(withIdentifier: "CustomUserViewController") as! CustomUserViewController
        brockVC.characterName = .Brock
        let selfieVC = storyboard.instantiateViewController(withIdentifier: "CustomUserViewController") as! CustomUserViewController
        selfieVC.characterName = .Selfie
        
        // add our VCs to our controlling array
        characterVC.append(ashVC)
        characterVC.append(brockVC)
        characterVC.append(selfieVC)
        
        // finally, call UIPageViewControllerDataSource method to set the currently-visible pages
        self.setViewControllers([ashVC],    // pass in an array of a single VC, as we only need to show one at a time
            direction: .forward,
            animated: false,    // true has animation, but can cause unbalanced calls error
            completion: nil)
    }
    
    // MARK: UIPageViewController Data Source Methods
    
    // determine the previous VC to show if we scroll left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (currentVCIndex == 0) {
            return nil
        }
        
        let vc = characterVC[currentVCIndex - 1]
        currentVCIndex = currentVCIndex - 1
        return vc
    }
    
    // determine the next VC to show if we scroll right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (currentVCIndex >= characterVC.count - 1) {
            return nil
        }
        
        let vc = characterVC[currentVCIndex + 1]
        currentVCIndex = currentVCIndex + 1
        return vc
    }
    
}
