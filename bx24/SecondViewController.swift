//
//  SecondViewController.swift
//  bx24

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var infos: [Info] = []
    var id: Int = 0
    
    let cellIdentifier = "kCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        infos = [
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 0", subtitle: "Детально 0"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 1", subtitle: "Детально 1"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 2", subtitle: "Детально 2"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 3", subtitle: "Детально 3"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 4", subtitle: "Детально 4"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 5", subtitle: "Детально 5"),
        ]
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell
        let info = infos[indexPath.row]
        
        cell?.iconImageView?.image = UIImage(named: info.images[id])
        cell?.titleLabel?.text = info.title
        cell?.subtitleLabel?.text = info.subtitle//"\(info.subtitle) ₽";
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let infoViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else {
            return
        }
        
        var info = infos[indexPath.row]
        
        info.images = ["https://png.icons8.com/ios/1600/accuracy.png",
                       "https://pp.userapi.com/c834203/v834203757/11d0b0/74C4VbdqYSQ.jpg"]
        
        infoViewController.info = info
        

        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
    
}
