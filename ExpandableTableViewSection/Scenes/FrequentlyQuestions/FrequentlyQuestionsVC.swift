//
//  automaicCellHeightViewController.swift
//  ExpandableTableViewSection
//
//  Created by gody on 9/13/20.
//  Copyright © 2020 gody. All rights reserved.
//

import UIKit

class FrequentlyQuestionsVC: UIViewController {
    @IBOutlet weak var questionsTV: UITableView!
    
    var searchBar = UISearchBar()
    var searchbarBtnIcon = UIBarButtonItem()
    let titleLabel=UILabel()
    var cellHeight :CGFloat!
    var searchBarIsActive = false
    var isSearchBarEmpty: Bool {
       return searchBar.text?.isEmpty ?? true
     }
     var isFiltering: Bool {
         return searchBarIsActive && !isSearchBarEmpty
     }
     var questionsArray:[(questionTitle: String, questionAnswer: String , isExpanded:Bool)] = []
      var filteredQuestions: [(questionTitle: String, questionAnswer: String , isExpanded:Bool)] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         questionsTV.rowHeight = UITableView.automaticDimension
        questionsArray=[
        ("why this happen ? why this happen ? why this happen ? why this happen ?","small text",false),
        ("what happen? what happe? what happen?","Lorem ipsum dolor sit amet, an dico offendit probatus mei. Cu mundi dicam ignota vel, ridens invenire appellantur usu eu. Ad hinc paulo animal vim, ex consul viderer accusamus usu, rebum viderer alienum per te",false),
        ("should this happen? should this happen? should this happen?","Lorem ipsum dolor sit amet, an dico offendit probatus mei. Cu mundi dicam ignota vel, ridens invenire appellantur usu eu. Ad hinc paulo animal vim, ex consul viderer accusamus usu, rebum viderer alienum per te. Id nam postulant salutatus. Eu has sale simul, id vero gubergren sed, ei lucilius oportere ius. \n Usu nihil accusam singulis cu, per cu aeterno maiestatis, ad delicata salutatus usu. Ad est dico utamur. Per cu velit detracto, an harum honestatis vix, usu ne sumo sententiae vituperata. Vim ex utinam perfecto, quo te zril putent appellantur. Mea audiam detracto te.",false)]
        questionsTV.rowHeight = UITableView.automaticDimension
       cellHeight = UITableView.automaticDimension
        questionsTV.estimatedRowHeight = 67.0;
        setUpNavBar()
    }
    
    func setUpNavBar(){
//         let attributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 18 )]
        titleLabel.text = "FAQ"
//         titleLabel.letterSpace=1.08
         titleLabel.sizeToFit()
         
         navigationItem.titleView = titleLabel
         
         searchBar.delegate = self
         searchBar.searchBarStyle = UISearchBar.Style.minimal
         searchBar.frame=CGRect(x:  UIScreen.main.bounds.width, y: 0, width: searchBar.frame.width, height: searchBar.frame.height)
         var searchText : UITextField!
         if #available(iOS 13.0, *) {
             searchText = searchBar.searchTextField
         } else {
             searchText = searchBar.value(forKey: "searchField") as? UITextField
         }
         searchText.backgroundColor  = .none
         searchbarBtnIcon = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
         navigationItem.rightBarButtonItem = searchbarBtnIcon
     }
    @objc func searchButtonPressed(sender: AnyObject) {
           showSearchBar()
       }
       
       func showSearchBar() {
           searchBar.showsCancelButton=true
           searchBar.alpha=0.0
           UIView.animate(withDuration: 0.5, animations: {
               self.navigationItem.setRightBarButton(nil, animated: true)
               self.searchBar.frame=CGRect(x:  0, y: 0, width: self.searchBar.frame.width, height: self.searchBar.frame.height)
               self.navigationItem.hidesBackButton=true
               self.navigationItem.titleView = self.searchBar
               self.searchBar.alpha=1.0
           }, completion: { finished in
               self.searchBar.becomeFirstResponder()
           })
       }
       
       func hideSearchBar() {
           navigationItem.hidesBackButton=false
           UIView.animate(withDuration: 0.5, animations: {
               
               self.searchBar.frame=CGRect(x:  UIScreen.main.bounds.width, y: 0, width: self.searchBar.frame.width, height: self.searchBar.frame.height)
               
               self.navigationItem.rightBarButtonItem=self.searchbarBtnIcon
               
               self.navigationItem.titleView = self.titleLabel
               
           }, completion: { finished in
               
           })
       }
       
       
       //MARK: UISearchBarDelegate
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBarIsActive = false
           searchBar.text=""
           questionsTV.reloadData()
           hideSearchBar()
       }
       func filterContentForSearchText(_ searchText: String){
         filteredQuestions = questionsArray.filter { (question) -> Bool in
           return (question.questionTitle.lowercased().contains(searchText.lowercased())) ||
           (question.questionAnswer.lowercased().contains(searchText.lowercased()))
         }
         
         questionsTV.reloadData()
       }
       
}
extension FrequentlyQuestionsVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredQuestions.count : questionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "AutomaticCell", for: indexPath) as! AutomaticCell
        let question = isFiltering ? filteredQuestions[indexPath.row] : questionsArray[indexPath.row]
        cell.titleLbl.text=question.questionTitle
        cell.subTitleLbl.isHidden = !question.isExpanded
//        if(!question.isExpanded){
//         cell.subTitleLblHeight.constant = 0
//
//        }
         cellHeight = UITableView.automaticDimension
        cell.titleLbl.textColor = question.isExpanded ? UIColor.gray : UIColor.black
        cell.subTitleLbl.text=question.questionAnswer
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isFiltering){
            filteredQuestions[indexPath.row].isExpanded.toggle()
        }else{
            questionsArray[indexPath.row].isExpanded.toggle()
        }
        questionsTV.reloadData()
    }
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let question = isFiltering ? filteredQuestions[indexPath.row] : questionsArray[indexPath.row]
//        if(question.isExpanded){
//            return cellHeight
//        }
//    return  70
//    }
//
}
extension FrequentlyQuestionsVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarIsActive = true
       filterContentForSearchText(searchBar.text!)
    }
}
