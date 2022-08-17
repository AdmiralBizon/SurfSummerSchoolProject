//
//  DetailTextTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

final class DetailTextTableViewCell: UITableViewCell {

    // MARK: - Views

    @IBOutlet private weak var contentLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    // MARK: - Public methods
    
    func configure(item: DetailItemModel?) {
        guard let item = item else {
            return
        }
        contentLabel.attributedText = configureAtributedString(text: item.content)
    }
    
}

// MARK: - Private methods

private extension DetailTextTableViewCell {
    
    func configureAppearance() {
        selectionStyle = .none
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = Color.black
        contentLabel.numberOfLines = 0
    }
    
    func configureAtributedString(text: String) -> NSAttributedString? {
        if text.isEmpty {
            return nil
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
       
        return attrString
    }
    
}
