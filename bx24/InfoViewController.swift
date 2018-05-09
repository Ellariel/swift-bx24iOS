//
//  InfoViewController.swift
//  bx24

import UIKit

struct Info {
    var images   : [String]
    let title       : String
    let subtitle       : String
}

class InfoViewController: UIViewController {
    @IBOutlet var galleryView: GalleryView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    public var info: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func actionBuy(_ sender: UIButton) {
        
    }
    
    func setupViewController() {
        if info == nil {
            info = Info(images: [],
                              title: "some title",
                              subtitle: "some subtitle")
        }
    }

    func loadInfo() {
        guard let info = info else {
            print("<InfoViewController: loadInfo> ERROR info is nil!!!")
            return
        }
        
        title = info.title
        galleryView.loadUrls(urls: info.images)
        titleLabel.text = info.title
        subtitleLabel.text = info.subtitle//"\(info.subtitle) ₽"
    }
    
}
