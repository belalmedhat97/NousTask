//
//  ViewController.swift
//  NousTask
//
//  Created by belal medhat on 06/07/2022.
//

import UIKit
import Combine
import SDWebImage
import MessageUI
class ViewController: UIViewController {
    var DownloadVM:DownloadViewModel = DownloadViewModel()
    // cancellablebag variable to add observer to it to release
    private var cancellableBag = Set<AnyCancellable>()
    private var dataSource:[DetailsModel] = []
    private var getLastCell:Bool = false
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var loadIdnticator: UIActivityIndicatorView!
    @IBOutlet weak var searchField: UISearchBar! {
        didSet{
            searchField.delegate = self
        }
    }
    @IBOutlet weak var downloadTableView: UITableView! {
        didSet {
            downloadTableView.delegate = self
            downloadTableView.dataSource = self
            downloadTableView.register(UINib(nibName: "DownloadCellView", bundle: nibBundle), forCellReuseIdentifier: "DownloadCellView")
            
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    //    @IBOutlet weak var Img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIdnticator.hidesWhenStopped = true
        loadIdnticator.startAnimating()
        innerView.clipsToBounds = true
        innerView.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
        DownloadVM.getDownload()
        bindTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        downloadTableView.setNeedsLayout()
//        downloadTableView.layoutIfNeeded()





    }
    func bindTableView(){
        DownloadVM.$downloadData.dropFirst().sink(receiveCompletion: { _ in }) { (data) in
            self.dataSource = data
            self.downloadTableView.reloadData()
            self.loadIdnticator.stopAnimating()
           // store the observer in the cancellable bag to release it from memory
        }.store(in: &cancellableBag)

    }
    func showEmailDialog(title:String,body:String){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["HR@NousDigital.com"])
            mail.setSubject(title)
            mail.setMessageBody("<p>\(body)</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("email not defined or using simulator")
            // show failure alert
        }
    }

    
}
// MARK: - confirm to tableView DS & DE protocols

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = downloadTableView.dequeueReusableCell(withIdentifier: "DownloadCellView", for: indexPath) as! DownloadCellView
        cell.RImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.RImg.sd_setImage(with: URL(string: dataSource[indexPath.row].imageUrl), placeholderImage: UIImage(systemName: "photo"))
        cell.title.text = dataSource[indexPath.row].title


        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEmailDialog(title: dataSource[indexPath.row].title, body: dataSource[indexPath.row].description)
    }
    ///
    /// found error when adding placeholder with sdwebimage as the image takes the size of placeholder
    /// even the url image is downloaded and you have to (redraw or scroll) so that the cell image (RImg) take the real size
    /// found issue in that thread https://github.com/SDWebImage/SDWebImage/issues/9
    ///
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && getLastCell == false{
                // do here...
                // create a variable to detect if it was loaded when will display the cells so that the app won't go through loop of loading the images
                getLastCell = true
                downloadTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


}
// MARK: - confirm to email searchBar delegate

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        DownloadVM.searchDownloads(searchText)
        
    }


}
// MARK: - confirm to email protocols delegate
extension ViewController:MFMailComposeViewControllerDelegate{
    
}
