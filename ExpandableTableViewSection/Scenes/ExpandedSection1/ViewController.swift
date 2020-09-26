//
//  ViewController.swift
//  ExpandableTableViewSection
//
//  Created by gody on 9/10/20.
//  Copyright © 2020 gody. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
@IBOutlet weak var expandedTableView:UITableView!
    
 var dataSourceArray = [sectionDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSourceArray = [
            sectionDataModel(headerName: "Man", cellTitles: ["Mohamed","Ahmed","Ali"], isExpandable: false),
            sectionDataModel(headerName: "Women", cellTitles: ["Eman","Amira"], isExpandable: false),
            sectionDataModel(headerName: "Childern", cellTitles: ["Joudy","Habiba","Audi"], isExpandable: false)]
        
     //       expandedTableView.tableFooterView = UIView()

    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = headerView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        header.delegate = self
        header.btn.setTitle(dataSourceArray[section].headerName, for: .normal)
        header.secIndex = section
        return header
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        return dataSourceArray.count
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isExpanded = dataSourceArray[section].isExpandable
        let count = isExpanded ?  dataSourceArray[section].cellTitles.count :  0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSourceArray[indexPath.section].cellTitles[indexPath.row]
      //  cell?.textLabel?.tintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        return cell
    }
    
    
}
extension ViewController:headerViewProtcol {
func headerViewPressed(atSection: Int) {
    dataSourceArray[atSection].isExpandable.toggle()
    expandedTableView.reloadData()
}
}

