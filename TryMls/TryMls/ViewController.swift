//
//  ViewController.swift
//  TryMls
//
//  Created by My Computer on 2018-11-23.
//  Copyright © 2018 Kish. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
     let gitUrl = URL(string: "http://kng:8888/wp-json/wp/v2/const/")
    
    URLSession.shared.dataTask(with: gitUrl) { (data, response
    , error) in
    
    guard let data = data else { return }
    do {
    
    let decoder = JSONDecoder()
    let gitData = try decoder.decode(MyGitHub.self, from: data)
    
    
    
    DispatchQueue.main.sync {
    if let gimage = gitData.avatarUrl {
    let data = try? Data(contentsOf: gimage)
    
    
    }
    
    
    if let gname = gitData.name {
    self.name.text = gname
    }

    self.setLabelStatus(value: false)
    }
    
    } catch let err {
    print("Err", err)
    }
    }.resume()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

