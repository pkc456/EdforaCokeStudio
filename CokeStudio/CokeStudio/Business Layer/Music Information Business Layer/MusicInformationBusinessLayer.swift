//
//  MusicInformationBusinessLayer.swift
//  CokeStudio
//
//  Created by Pradeep Choudhary on 3/18/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation

class MusicInformationBusinessLayer: NSObject
{
    class var sharedInstance: MusicInformationBusinessLayer {
        struct Static {
            static let instance: MusicInformationBusinessLayer = MusicInformationBusinessLayer()
        }
        return Static.instance
    }
    
    func parseArrayJsonData(data: NSArray) -> [MusicInformation] {
        let modelObject = MusicInformation.modelsFromDictionaryArray(array: data)        
        return modelObject
    }
}
