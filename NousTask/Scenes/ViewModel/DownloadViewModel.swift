//
//  DownloadViewModel.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import Foundation
import Combine
class DownloadViewModel:ObservableObject{
    
    private var cancellableBag = Set<AnyCancellable>()
    
    // publish observed variables
    @Published var downloadData:[DetailsModel] = []
    @Published var errorResponse:String = ""
    private var downloadCache:[DetailsModel] = []
    
    func getDownload(){
        NetworkRequest.shared.getDownload().sink { error in
            // check if error happen or completion finished successfully
            switch error {
            case .failure(let error):
                print("Error \(error)")
                self.errorResponse = "\(error)"
            case .finished:
                print("Publisher is finished")
            }
        } receiveValue: { response in
            // on receive response emit it to the pusblished var
            print(response)
            self.downloadData = response.items
            self.downloadCache = response.items
        }.store(in: &cancellableBag)
        
    }
    func searchDownloads(_ txt:String){
        //if search txt greater than 3 characters do search
        if txt.count >= 3 {
            // filter data by title
            let filterByTitle = downloadData.filter { $0.title.lowercased().contains(txt.lowercased()) }
            print("filter title\(filterByTitle)")
            // update download data array
            downloadData = filterByTitle
            // filter data by title

            if filterByTitle.isEmpty{
                // filter data by description
                let filterByDescription = downloadData.filter {$0.description.lowercased().contains(txt.lowercased()) }
                print("filter description\(filterByDescription)")
                // update download data array
                downloadData = filterByTitle
            }
        }else{
            //if search txt less than 3 characters return the cached downloads
            downloadData = downloadCache
        }
        
    }
    
}
