//
//  ViewController.swift
//  FancyClock
//
//  Created by clearence wissar on 29/4/17.
//  Copyright © 2017 ClearenceWissar. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!

    var dateFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    
    //Makes an API request
    func getPhotos(){
        guard let url = URL(string: "https://303df596.au.ngrok.io/photos/random") else{ return }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Client-ID ANYTHING", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, urlResponse, error in })
        task.resume()
    }
    
    
    //Request
    func requester(urlEndpoint: String, disableAnim: Bool = false) {
        guard let url = URL(string: urlEndpoint) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Client-ID ANYTHING", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("v1", forHTTPHeaderField: "Accept-Version")
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, urlResponse, error in
            self.parsero2(data: data!, disableAnim: disableAnim)
        })
        task.resume()
    }
    
    
    //Parse JSON
    func parsero2(data: Data, disableAnim: Bool = false){
        var jsonDictionary: [String: Any]?
        do {
            jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            guard
                let dictionary = jsonDictionary,
                let urls = dictionary["urls"] as? [String: String],
                let resourceAddress = urls["regular"]
                else {
                    print("Unexpected JSON")
                    return
            }
            
            print(resourceAddress)
            
            guard let url = URL(string: resourceAddress) else{ return }
            
            if (!disableAnim){
                self.drawImage(url:url)
                
            }else{
                self.drawImageNoAnim(url:url)
            }
            
            
        } catch {
            print("JSON parsing failed")
        }
    }
     
    
    func drawImage(url : URL){
        ImageDownloader.default.downloadImage(with: url, options: [], progressBlock: nil)
        { [weak self] image, _, _, _ in
            // Do stuff with the new image.
            let resource = ImageResource(downloadURL: url)
            //Animation
            let duration: TimeInterval = 1.0 // TimeInterval is an alias for the Double type.
            
            UIView.animate(withDuration: duration, animations: {
                self?.imageView.alpha = 0
            }, completion: { didFinish in
                self?.imageView.kf.setImage(with :resource)
                
                UIView.animate(withDuration: duration, animations: {
                    self?.imageView.alpha = 1
                })
            })
        }
    }

    func drawImageNoAnim(url : URL){
        ImageDownloader.default.downloadImage(with: url, options: [], progressBlock: nil)
        { [weak self] image, _, _, _ in
            // Do stuff with the new image.
            let resource = ImageResource(downloadURL: url)
            //Animation
            self?.imageView.kf.setImage(with :resource)
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        print("before appears")
        self.requester(urlEndpoint: "https://303df596.au.ngrok.io/photos/random", disableAnim : true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        self.requester(urlEndpoint: "https://303df596.au.ngrok.io/photos/random")
        
        
        //set Image Width & height 
        let screenSize: CGRect = UIScreen.main.bounds
        self.imageView.frame  = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.dateLabel.text = self.dateFormatter.string(from: Date())
            self.timeLabel.text = self.timeFormatter.string(from: Date())
        }
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            //Get a photo
            self.requester(urlEndpoint: "https://303df596.au.ngrok.io/photos/random")
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

