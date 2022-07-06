//
//  DownloadModel.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import Foundation
struct DownloadModel:Codable{
    var items:[DetailsModel] = []
}
struct DetailsModel:Codable{
    var id:Int = 0
    var title:String = ""
    var description:String = ""
    var imageUrl:String = ""
}
