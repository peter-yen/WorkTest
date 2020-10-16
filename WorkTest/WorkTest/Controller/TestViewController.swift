//
//  TestViewController.swift
//  WorkTest
//
//  Created by 嚴啟睿 on 2020/10/15.
//

import UIKit

class TestViewController: UIViewController {
    var codes: [Code] = []
    
    convenience init(codes: [Code]) {
        self.init()
        self.codes = codes
    }
    
    var testTableView: UITableView = {
       let t = UITableView()
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(testTableView)
        self.testTableView.delegate = self
        self.testTableView.dataSource = self
        self.testTableView.register(TestTableViewCell.self, forCellReuseIdentifier: "TestTableViewCell")
        self.testTableView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell") as! TestTableViewCell
        let code = codes[indexPath.row]
        cell.code = code
        return cell
    }
    
    
}
