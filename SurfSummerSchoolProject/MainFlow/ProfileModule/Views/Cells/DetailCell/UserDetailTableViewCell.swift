//
//  UserDetailTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 21.08.2022.
//

import UIKit

final class UserDetailTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet private weak var detailTitle: UILabel!
    @IBOutlet private weak var detailSubtitle: UILabel!
    
    // MARK: - UITableViewCell

    override func prepareForReuse() {
        super.prepareForReuse()
        detailTitle.text = nil
        detailSubtitle.text = nil
    }
    
   // MARK: - Public methods
    
    func configure(title: String?, subtitle: String?) {
        detailTitle.text = title
        detailSubtitle.text = subtitle
    }
    
}
