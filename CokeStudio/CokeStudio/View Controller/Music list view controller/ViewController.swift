//
//  ViewController.swift
//  CokeStudio
//
//  Created by Pradeep Choudhary on 3/18/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViewSongs: UITableView!
    var arrayMusic : [MusicInformation] = []

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
            self.arrayMusic = result
            self.tableViewSongs.reloadData()
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
// MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMusic.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        cell.configureCellWithData(musicInformationModelObject: arrayMusic[indexPath.row])
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

