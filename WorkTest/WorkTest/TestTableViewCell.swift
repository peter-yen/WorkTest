//
//  TestTableViewCell.swift
//  WorkTest
//
//  Created by 嚴啟睿 on 2020/10/15.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    var code: Code! {
        didSet {
            self.setupRightLabel(text: code.code)
            self.setupLeftLabel(text: code.name)
        }
    }
    var rightView: UIView!
    
    lazy var rightLabel: UILabel = {
       let l = UILabel()
        return l
    }()
    
    lazy var leftLabel: UILabel = {
       let l = UILabel()
        return l
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupRightView()
        self.accessoryView = self.rightView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupRightView() {
        self.rightView = UIView()
        self.rightView.frame = CGRect(x: 0, y: 0, width: 200, height: frame.height)
    }
    
    func setupRightLabel(text: String) {
        self.rightLabel.text = ""
        self.rightLabel.text = text
        self.rightView.addSubview(rightLabel)
        self.rightLabel.textAlignment = .center
        self.rightLabel.snp.makeConstraints { (m) in
            m.margins.equalToSuperview()
        }
    }
    
    func setupLeftLabel(text: String) {
        self.leftLabel.text = ""
        self.leftLabel.text = "\(text) :"
        self.addSubview(leftLabel)
        self.leftLabel.textAlignment = .left
        self.leftLabel.snp.makeConstraints { (m) in
            m.margins.equalToSuperview()
        }
    }
}
