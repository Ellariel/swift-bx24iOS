//
//  FirstViewController.swift
//  bx24

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var infos: [Info] = []
    
    let cellIdentifier = "kCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        infos = [
            Info(images: ["user-male"], title: "Контакты", subtitle: "Ваши контакты в Bitrix24"),
            Info(images: ["shopping-cart"], title: "Товары", subtitle: "Ваши товары в Bitrix24"),
            Info(images: ["news"], title: "Сделки", subtitle: "Ваши сделки в Bitrix24")
        ]
    }

}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell
        let info = infos[indexPath.row]

        cell?.iconImageView?.image = UIImage(named: info.images[0])
        cell?.titleLabel?.text = info.title
        cell?.subtitleLabel?.text = info.subtitle//"\(info.subtitle) ₽";

        return cell!
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let infoViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else {
            return
        }

        let info = infos[indexPath.row]

        infoViewController.info = info

        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
*/
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        
        //let info = infos[indexPath.row]
        
        //secondViewController.infos = infos
        
        secondViewController.id = indexPath.row
            
            
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    
}
