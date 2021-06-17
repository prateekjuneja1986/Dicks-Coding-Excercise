//
//  EventDetailsViewController.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let selectedImage = "heartSelected"
    let deSelectedImage = "heartDeselected"
    
    weak var delegate: EventDetailsViewControllerDelegate?
    var eventDetailsViewModel : EventDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpDataOnUI()
    }
    
    func setUpDataOnUI() {
        let event = self.eventDetailsViewModel.event
        self.eventTitleLabel.text = "\(event.title)"
        if let imageUrl = event.performers?.first?.image {
            ImageDownloader.shared.loadImage(imageUrl: URL(string: imageUrl), imageView: self.eventImageView)
        }
        self.eventLocationLabel.text = event.venue.displayLocation
        self.eventTimeLabel.text = CustomDateFormatter.formatTheDate(event.datetimeUTC)
        self.favoriteButton.setImage(event.isFavourite ? UIImage(named: selectedImage) : UIImage(named: deSelectedImage), for: .normal)
    }
    
    @IBAction func backToEventListPageButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        let event = self.eventDetailsViewModel.event
        self.eventDetailsViewModel.updateFavoriteInLocalDataBase(event: self.eventDetailsViewModel.event, isFavorite:!event.isFavourite)
        self.favoriteButton.setImage(!event.isFavourite ? UIImage(named: selectedImage) : UIImage(named: deSelectedImage), for: .normal)
        self.delegate?.didUpdateFavorite(event: self.eventDetailsViewModel.event)
    }
}
