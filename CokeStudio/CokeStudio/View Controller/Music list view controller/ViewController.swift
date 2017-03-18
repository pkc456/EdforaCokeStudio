//
//  ViewController.swift
//  CokeStudio
//
//  Created by Pradeep Choudhary on 3/18/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate  {
    @IBOutlet weak var tableViewSongs: UITableView!
    var arrayMusic : Array<MusicInformation>?
    var arrayMusicSearchResults : Array<MusicInformation>?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        fetchMusicData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: User defined methods
    private func registerTableCell(){
        //I have created separate xib of MusicTableViewCell, so that it can be re-used in search results table view
        tableViewSongs.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicTableViewCell")
        self.searchDisplayController!.searchResultsTableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicTableViewCell")
        }
    
    private func fetchMusicData(){
        WebServiceHandler.sharedInstance.getMusicInformation(successBlock: { (result) in
            self.arrayMusic = result
            self.tableViewSongs.reloadData()
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    //Seach by name functionality,
    // Filter the array using the filter method

    func filterContentForSearchText(searchText: String) {
        if self.arrayMusic == nil {
            self.arrayMusicSearchResults = nil
            return
        }
        self.arrayMusicSearchResults = self.arrayMusic!.filter({( aMusic: MusicInformation) -> Bool in
            //Using lowercaseString on both the species name and the search text makes the search case insensitive.
            return aMusic.song?.lowercased().range(of: searchText.lowercased()) != nil
        })
        
        print(self.arrayMusicSearchResults ?? "")
    }
    
// MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 0
        if tableView == tableViewSongs {
            numberOfRow = self.arrayMusic?.count ?? 0
        } else {
            numberOfRow = self.arrayMusicSearchResults?.count ?? 0
        }
        return numberOfRow
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        
        var musicArrayBasedOnTable : Array<MusicInformation>?
        
        if tableView == tableViewSongs {
            musicArrayBasedOnTable = self.arrayMusic
        } else {
            musicArrayBasedOnTable = self.arrayMusicSearchResults
        }
        
        if musicArrayBasedOnTable != nil && musicArrayBasedOnTable!.count >= indexPath.row
        {
            cell.configureCellWithData(musicInformationModelObject: (musicArrayBasedOnTable?[indexPath.row])!)
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
//MARK:- Search bar and search display delegates
    func searchDisplayController(_ shouldReloadTableForSearchcontroller: UISearchDisplayController, shouldReloadTableForSearch searchString: String!) -> Bool {
        self.filterContentForSearchText(searchText: searchString)
        return true
    }
}

