//
//  SecondViewController.swift
//  bx24

import UIKit
import Foundation
import Alamofire

struct Contact : Decodable {
let ID: String
let NAME: String
let SECOND_NAME: String
let LAST_NAME: String
}

struct Deal : Decodable {
let ID: String
let TITLE: String
let STAGE_ID: String
let CURRENCY_ID: String
let OPPORTUNITY: String
}

struct Product : Decodable {
let ID: String
let NAME: String
let PRICE: String
let CURRENCY_ID: String
}

struct Contacts : Decodable {
    let result: [Contact]
}

struct Deals : Decodable {
    let result: [Deal]
}

struct Products : Decodable {
    let result: [Product]
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var infos: [Info] = []
    var id: Int = 0
    
    let cellIdentifier = "kCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    func load() {
       /*infos = [
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 0", subtitle: "Детально 0"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 1", subtitle: "Детально 1"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 2", subtitle: "Детально 2"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 3", subtitle: "Детально 3"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 4", subtitle: "Детально 4"),
            Info(images: ["user-male","shopping-cart","news"], title: "Какие-то данные 5", subtitle: "Детально 5"),
        ]*/
      
      let myGroup = DispatchGroup()
        myGroup.enter()
        switch self.id {
        case 0:
            Alamofire.request("https://b24-vkqv76.bitrix24.ru/rest/1/r4ynraz9cs2k6g04/crm.contact.list/").responseJSON { response in
                switch response.result {
                case .success:
                    let jsonData = response.data
                    do {
                        let root = try JSONDecoder().decode(Contacts.self, from: jsonData!)
                        
                        for it in root.result {
                            self.infos.append(Info(images: ["user-male","shopping-cart","news"], title: it.LAST_NAME+"  "+it.NAME+" "+it.SECOND_NAME, subtitle: "ID "+it.ID))
                            //print (self.infos.last?.title)
                        }
                    } catch let error {
                        print(error) }
                case .failure(let error):
                    print(error)
                }
                self.tableView.reloadData()
                myGroup.leave()
            }
        case 1:
            Alamofire.request("https://b24-vkqv76.bitrix24.ru/rest/1/r4ynraz9cs2k6g04/crm.product.list/").responseJSON { response in
                switch response.result {
                case .success:
                    let jsonData = response.data
                    do {
                        let root = try JSONDecoder().decode(Products.self, from: jsonData!)
                        for it in root.result {
                            self.infos.append(Info(images: ["user-male","shopping-cart","news"], title: it.NAME, subtitle: it.PRICE+" "+it.CURRENCY_ID))
                            //print (self.infos.last?.title)
                        }
                    } catch let error {
                        print(error) }
                case .failure(let error):
                    print(error)
                }
                self.tableView.reloadData()
                myGroup.leave()
            }
        case 2:
            Alamofire.request("https://b24-vkqv76.bitrix24.ru/rest/1/r4ynraz9cs2k6g04/crm.deal.list/").responseJSON { response in
                switch response.result {
                case .success:
                    let jsonData = response.data
                    do {
                        let root = try JSONDecoder().decode(Deals.self, from: jsonData!)
                        
                        for it in root.result {
                            self.infos.append(Info(images: ["user-male","shopping-cart","news"], title: it.TITLE, subtitle: it.OPPORTUNITY+" "+it.CURRENCY_ID))
                            //print (self.infos.last?.title)
                        }
                    } catch let error {
                        print(error) }
                case .failure(let error):
                    print(error)
                }
                self.tableView.reloadData()
                myGroup.leave()
            }
    
        default:
            break
        }
            myGroup.notify(queue: .main) {
                print("Finished all requests.")
            }


    
        
    }
    }

/*
if (selectedData==0) loadDeals().forEach {dataList.add(Data(it.ID,it.TITLE + "\n" + it.OPPORTUNITY + " " + it.CURRENCY_ID,Icon("","")))}
if (selectedData==1) loadContacts().forEach {dataList.add(Data(it.ID,it.LAST_NAME + "  " + it.NAME + " " + it.SECOND_NAME,Icon("","")))}
if (selectedData==2) loadProducts().forEach {dataList.add(Data(it.ID,it.NAME + "\n" + it.PRICE + " " + it.CURRENCY_ID,Icon("","")))}
runOnUiThread {
*/

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return infos.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell
        let info = infos[indexPath.row]
        //print (infos.count)
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
