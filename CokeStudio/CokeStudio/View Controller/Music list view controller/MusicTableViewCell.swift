//
//  MusicTableViewCell.swift
//  CokeStudio
//
//  Created by Pradeep Choudhary on 3/18/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation
import UIKit

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelMusicName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configureCellWithData(musicInformationModelObject : MusicInformation)
    {
        labelMusicName.text = musicInformationModelObject.song
    }
    
}
