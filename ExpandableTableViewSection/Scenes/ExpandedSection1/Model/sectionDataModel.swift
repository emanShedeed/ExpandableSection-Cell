//
//  DataModel.swift
//  ExpandableTableViewSection
//
//  Created by gody on 9/10/20.
//  Copyright © 2020 gody. All rights reserved.
//

struct sectionDataModel
{
    var headerName:String?
    var cellTitles = [String]()
    var isExpandable:Bool = false
    init(headerName:String,cellTitles:[String],isExpandable:Bool) {
        self.headerName=headerName
        self.cellTitles=cellTitles
        self.isExpandable=isExpandable
    }
}
