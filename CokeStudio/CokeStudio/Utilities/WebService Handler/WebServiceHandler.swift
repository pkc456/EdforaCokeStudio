//
//  WebServiceHandler.swift
//

//MARK:- README
/*
 // I have created one generic method (apiRequest) for Api call.
 // Create individual method for each dedicated api call like I do
*/

import UIKit
import Alamofire

class WebServiceHandler: NSObject {

    class var sharedInstance: WebServiceHandler {
        struct Static {
            static let instance: WebServiceHandler = WebServiceHandler()
        }
        return Static.instance
    }
    
    // MARK: Common Request
    func apiRequest( method: Alamofire.HTTPMethod, url: String, completion:@escaping ( _ finished: Bool, _ response: AnyObject?) ->Void) {
        
        Alamofire.request(url, method: method).responseJSON { response in
            if let JSON = response.result.value {
                completion(true, JSON as AnyObject?)
            } else {
                completion(false, response.result.error as AnyObject?)
            }
        }
    }
    
    
    // MARK: Fetch music information
    func getMusicInformation(successBlock:@escaping ( _ result : [MusicInformation]) -> Void,failureBlock:@escaping (_ error:NSError)->Void)
    {
        Utility.showLoader()    //Show loader indicator. This loader indicator is created in Utility class without the use of third party
        let musicInfoUrl = BASE_URL + CokeStudio

        self.apiRequest(method: .get, url: musicInfoUrl) { (finished, response) in
            if(finished){
                if let dictionaryPlayout = response{
                    let musicInformationModelObject = MusicInformationBusinessLayer.sharedInstance.parseArrayJsonData(data: dictionaryPlayout as! NSArray)
                    successBlock(musicInformationModelObject)
                }
                Utility.hideLoader()
            }else{
                let error = response as! NSError
                failureBlock(error)
                Utility.hideLoader()
            }
        }
    }
    
}
