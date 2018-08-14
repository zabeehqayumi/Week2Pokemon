//
//  SaveDataManager.swift
//  ScrollAndPageView
//
//  Created by Kevin Yu on 8/13/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

// our save manager
// in the future, we can use this to set up persistent storage

import UIKit

class SaveDataManager {
    // create a singleton by setting up a static let
    // cannot be changed (let), and persists through class (static)
    // private initializer ensures we cannot create an additional instance of this class
    // "sharedInstance", or "shared", is commonly used notation for singleton instances
    static let sharedInstance = SaveDataManager()
    
    private init() { }
    
    // MARK: Properties
    
    lazy var pokemon = [String: Pokemon]()
    
    var isLoading = false
    
    // MARK: Webservice Request Methods
    
    // get information about a Pokemon
    func getPokemon(_ id: Int) {
        
        // URLSession is the framework we use to perform webservice requests
        // can be set up with URLSessionConfiguration
        // alternatively, we can use shared singleton for most requests if we don't have specific requirements
        let session = URLSession.shared
        
        // set up a URL to call the data from
        // URL constructor can return nil, be sure to handle appropriately
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)/"
        guard let url = URL.init(string: urlString) else {
            print("invalid URL: \(urlString)")
            return
        }
        
        // SaveDataManager manager can have a property to determine when it is/isn't performing a request
        SaveDataManager.sharedInstance.isLoading = true
        
        // set up a URLSessionDataTask
        // the actual task that performs an HTTP request
        // also available alternatives are URLSessionDownloadTask and URLSessionUploadTask
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            // in completion block, task is done, so, unset property
            SaveDataManager.sharedInstance.isLoading = false
            
            // check if error exists
            if error != nil {
                print("there was an error")
                return
            }

            // check if data was returned
            guard let responseData = data else {
                print("data was empty")
                return
            }
            
            // if we get this far, there is data to serialize
            do {
               // let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves)
                //  print(jsonData)
                let pokemon = try JSONDecoder.init().decode(Pokemon.self, from: responseData)
                self.pokemon[pokemon.name] = pokemon
            }
            catch {
                print("error serializing data: \(error)")
            }
            
        }
        dataTask.resume()   // tasks are always instantiated suspended, call resume() to perform the task
    }
    
    // get a sprite from a Pokemon
    func getImage(_ pokemon: Pokemon, _ completion: @escaping (UIImage) -> Void) {
        
        guard let urlString = pokemon.sprites.front_shiny else {
            return
        }
        
        guard let url = URL.init(string: urlString) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let imageData = data {
                // call UIImage constructor with data to create an image with image data
                if let image = UIImage.init(data: imageData) {
                    // pass it into the completion block
                    completion(image)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    func suspendActivity() {
        // stop current URLRequests while user is in background
        // dataTask.suspend()
    }
    
    func continueActivity() {
        // continue queued URLRequests when user returns to app
        // dataTask.resume()
    }
    
    func endActivity() {
        // stops all queued URLRequests
        // dataTask.cancel()
    }
    
}
