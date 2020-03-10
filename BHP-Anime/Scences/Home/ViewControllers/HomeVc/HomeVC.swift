//
//  HomeVC.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import PullToRefreshKit

import JGProgressHUD

class HomeVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var page = 1
    var type = 1
    var listItem : [Popular] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    func configUI() {
        self.title = "Anime"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "ic_search"), style: .plain, target: self, action: #selector(searchButton))
        self.navigationController?.navigationBar.tintColor = UIColor.init("#0C0E41")
        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init("#0C0E41"), NSAttributedString.Key.font: AppFonts.Verdana(30)]
        
        
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        getlistItems(false, type: type)
        
        
        self.tableview.registerCell(ScaledCell.className)
        self.tableview.registerCell(SimpleCell.className)
        self.tableview.registerCell(MenuCell.className)
        self.tableview.dataSource = self
        self.tableview.separatorStyle = .none
        self.tableview.delegate = self
        
        
        self.tableview.configRefreshFooter(container: self) {
            self.getlistItems(true, type: self.type)
            self.tableview.switchRefreshFooter(to: .normal)
        }
        
        self.tableview.configRefreshHeader(container: self) {
            self.getlistItems(false, type: self.type)
            self.tableview.switchRefreshHeader(to: .normal(.success, 0.5))
        }
    }
    
    func getlistItems(_ loadmore: Bool, type: Int) {
        if loadmore{
            self.page += 1
        }else{
            self.page = 1
        }
        var sortBy: String = ""
        
        if type == 1{
            sortBy = "popularity.desc"
        }else if type == 2{
            sortBy = "vote_count.desc"
        }else{
            sortBy = "release_date.desc"
        }

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        AnimeAPIManager.sharedInstance.listPopular(sortBy: sortBy, withGenres: "16", page: String(self.page), success: { (listItems) in
            

            if loadmore{
                self.listItem.append(contentsOf: listItems)
            }else{
                self.listItem = listItems
            }

            hud.dismiss()
            self.tableview.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    @objc func searchButton(){
        print("aaaaa")
    }
}

extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listItem.count > 4{
            return listItem.count - 4
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let scaledCell = tableView.dequeueReusableCell(withIdentifier: ScaledCell.className, for: indexPath) as! ScaledCell
            
            scaledCell.selectionStyle = UITableViewCell.SelectionStyle.none
            let listItemsScaled = self.listItem[0..<5]
            scaledCell.listItems = Array(listItemsScaled)
            scaledCell.collectionView.reloadData()
            return scaledCell
        }else if indexPath.row == 1{
            let menuCell = tableView.dequeueReusableCell(withIdentifier: MenuCell.className, for: indexPath) as! MenuCell
            menuCell.configCell(self.type)

            menuCell.selectionStyle = UITableViewCell.SelectionStyle.none

            menuCell.doneAction = {[weak self](type) in
                self?.type = type
                self?.getlistItems(false, type: type)
            }
            return menuCell
        } else{
            let simpleCell = tableView.dequeueReusableCell(withIdentifier: SimpleCell.className, for: indexPath) as! SimpleCell

            simpleCell.selectionStyle = UITableViewCell.SelectionStyle.none

            simpleCell.configCell(listItem[indexPath.row + 3 ])
            return simpleCell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 280
        }else if indexPath.row == 1{
            return 40
        }else{
            return 110
        }
        
    }
    
}


extension HomeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAnimeVC = DetailAnimeVC.loadFromNib()

        detailAnimeVC.id = String(listItem[indexPath.row + 3].id ?? 0)

        guard let topVC = UIApplication.topViewController() else {
            return
        }
        
        topVC.navigationController?.present(detailAnimeVC, animated: true, completion: {

            return

        
        })
    }
    
}
