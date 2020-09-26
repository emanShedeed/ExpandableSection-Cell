//
//  FilterResultVC.swift
//  Ataba
//
//  Created by eman shedeed on 12/5/19.
//  Copyright © 2019 eman shedeed. All rights reserved.
//

import UIKit

final class FilterResultVC: UIViewController {
    
    @IBOutlet var filterTableView: UITableView!
   // @IBOutlet weak var typeSegment: UISegmentedControl!

    var dataSourceArray: Array<CustomHeaderSection> = .init()
         var storesInfo : [(storeName: String, storeID: String , isSelected:Bool)] = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
     dataSourceArray.append(.init(value: [(storeName: "Move", storeID: "0", isSelected: false),(storeName: "Purchase", storeID: "1", isSelected: false)]))
        dataSourceArray.append(.init(value: [(storeName: "Store 1", storeID: "0", isSelected: false),(storeName: "Store 2", storeID: "1", isSelected: false)]))
        dataSourceArray.append(.init(value: [(storeName: "", storeID: "", isSelected: false)]))
      /*typeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        
        typeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(rgb: 0xEA961E)] , for: .normal )*/
       
    }
    
    private func createHeader(with title: String) -> UIView? {
        let container: UIView = .init()
        //container.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35)
        container.isUserInteractionEnabled = true
        let stack: UIStackView = .init()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let label: UILabel = .init()
        #warning("set label attributes")
        label.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        label.text = title
        let imageView: UIImageView = .init()
        imageView.image = UIImage(named: "down")
        imageView.contentMode = .scaleAspectFit
        #warning("set image view attributes")
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(imageView)
        
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -17),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 17)
        ])
        
       // container.backgroundColor = .white
        return container
    }
    
    @objc private func setHeaderStateOnTap(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            let indexPaths = dataSourceArray[tag].value.indices.map { IndexPath(row: $0, section: tag) }
            print (dataSourceArray[tag].value.indices)
            dataSourceArray[tag].isExpandable.toggle()
            let isExpanded = dataSourceArray[tag].isExpandable
            //   sender.setTitle(isExpanded ? localize(Localizations.hide) : localize(Localizations.show), for: .normal)
            if let imageView = (sender.view?.subviews.first as? UIStackView)?.arrangedSubviews.last as? UIImageView {
                UIView.animate(withDuration: 1) {
                    imageView.transform = isExpanded ? imageView.transform.rotated(by: CGFloat(Double.pi * 0.999)) : .identity
                }
            }
            filterTableView.performBatchUpdates({ [ weak self] in
                
                isExpanded ?
                    self?.filterTableView.insertRows(at: indexPaths, with: .fade)
                    :
                    self?.filterTableView.deleteRows(at: indexPaths, with: .fade)
                }, completion: .none)
            
        }
    }
    
    
}

// MARK: - UItable view delegate & data source functions  {

extension FilterResultVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { dataSourceArray.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataSourceArray[section].isExpandable else {return 0}
        return  dataSourceArray[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterStoreCell", for: indexPath)as! StoreCell
            cell.cellDelegate=self
            let item = dataSourceArray[indexPath.section].value[indexPath.row]
            cell.displayData(storeName: item.storeName, isSelected: item.isSelected)
//            presenter.ConfigureCell(cell:cell, name: item.storeName,cellIndex:indexPath.row,isSelected:item.isSelected)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView : UIView?
        if section == .zero {
            headerView = createHeader(with: "Type")
        }else if section == 1{
             headerView = createHeader(with: "Store")
        }else{
             headerView = createHeader(with: "Price")
        }
        headerView?.tag = section
        headerView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setHeaderStateOnTap(_:))))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 50.0 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 2){
            return 100
        }else{
            return 44
        }
    }
    
}

/*extension FilterResultVC:UITableViewDelegate,UITableViewDataSource{
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return array.count
 }
 func numberOfSections(in tableView: UITableView) -> Int {
 return 2
 }
 func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 let frame = tableView.frame
 let button = UIButton(frame: CGRect(x: frame.size.width-30 , y: 10, width: 15, height: 15))
 button.tag = section
 button.setImage(UIImage(named: "Arrow"), for: UIControl.State.normal)
 button.addTarget(self,action:#selector(buttonClicked),for:.touchUpInside)
 
 let label = UILabel(frame: CGRect(x: 15 , y: 10, width: frame.size.width-50, height: 15))
 label.text = (section == 0) ? "Store" : "Price"
 
 let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
 headerView.addSubview(button)
 headerView.addSubview(label)
 return headerView
 
 }
 @objc func buttonClicked(){
 print("button clicked")
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell=tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)
 cell.textLabel?.text="just try"
 return cell
 }
 
 
 }*/
