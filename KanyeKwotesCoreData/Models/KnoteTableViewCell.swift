//
//  KnoteTableViewCell.swift
//  KanyeKwotesCoreData
//
//  Created by Christopher Alegre on 9/26/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import UIKit
import CoreData

class KnoteTableViewCell: UITableViewCell {

    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var personQuotedLabel: UILabel!
    @IBOutlet weak var kayneButton: UIButton!
    
    
    
    @IBAction func kayneButtonTapped(_ sender: Any) {
        delegate?.kayneButtonTapped(self)
    }
}

extension KnoteTableViewCell {
    func update(knote: Knote) {
        quoteLabel.text = knote.body
        personQuotedLabel.text = knote.notKayneName
        
        if knote.vailed {
            kayneButton.setImage(UIImage (named: "Mystery"), for: .normal)
        } else if knote.isKanye {
            kayneButton.setImage(UIImage (named: "Gladye"), for: .normal)
        } else if !knote.isKanye {
            kayneButton.setImage(UIImage (named: "Sadye"), for: .normal)
        }
    }
}

protocol ButtonTableViewCellDelegate {
    func kayneButtonTapped(_ sender: KnoteTableViewCell)
}
