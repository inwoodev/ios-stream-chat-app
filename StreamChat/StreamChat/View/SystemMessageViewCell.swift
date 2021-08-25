//
//  SystemMessageViewCell.swift
//  StreamChat
//
//  Created by 황인우 on 2021/08/18.
//

import UIKit

class SystemMessageViewCell: UITableViewCell {
    static let identifier = "SystemMessageViewCell"
    
    private let systemMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray2
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpLayout() {
        self.contentView.addSubview(systemMessageLabel)
        NSLayoutConstraint.activate([
            systemMessageLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            systemMessageLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            systemMessageLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            systemMessageLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func changeLabelText(_ text: String) {
        systemMessageLabel.text = text
    }
}
