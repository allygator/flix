//
//  MovieTrailerViewController.swift
//  flix
//
//  Created by Alyssa Davis on 9/19/21.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {
    @IBOutlet var videoView: WKWebView!
    var movieURL: URL!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        videoView = WKWebView(frame: .zero, configuration: webConfiguration)
        videoView.uiDelegate = self
        view = videoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let request = URLRequest(url: movieURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = dataDictionary["results"] as! [[String:Any]]
                let key = results[0]["key"]!
                let myURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
                let myRequest = URLRequest(url: myURL!)
                self.videoView.load(myRequest)

             }
        }
        task.resume()
    }

}
