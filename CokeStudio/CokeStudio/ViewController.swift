//
//  ViewController.swift
//  CokeStudio
//
//  Created by Pradeep Choudhary on 3/18/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMusicData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: User defined methods
    private func fetchMusicData(){
        WebServiceHandler.sharedInstance.getMusicInformation(successBlock: { (result) in
            print(result)
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
}

