//
//  EventTableViewCell.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.eventImageView.layer.cornerRadius = 8
        self.addShadowToContainerView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(event: Event) {
        self.eventTitleLabel.text = "\(event.title)"
        if let imageUrl = event.performers?.first?.image {
            ImageDownloader.shared.loadImage(imageUrl: URL(string: imageUrl), imageView: self.eventImageView)
        }
        self.eventLocationLabel.text = event.venue.displayLocation
        self.eventTimeLabel.text = CustomDateFormatter.formatTheDate(event.datetimeUTC)
        self.favoriteImageView.isHidden = !event.isFavourite
    }
    
    func addShadowToContainerView() {
        self.containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 8, scale: true)
    }
}
