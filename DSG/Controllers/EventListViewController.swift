//
//  EventListViewController.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import UIKit

class EventListViewController: UIViewController {
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var noEventsLabel: UILabel!
    let searchController = UISearchController(searchResultsController: nil)
    private var eventViewModel : EventListViewModel!
    var searchText: String?
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTheSearchBar()
        self.setUpViewModel()
        self.checkIfSearchRequiredAndGetEvent(searchText: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.events.count > 0 {
            self.eventsTableView.reloadData()
        }
    }
    
    func setUpTheSearchBar() {
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        self.eventsTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.backgroundColor = UIColor(red: 52.0/255.0, green: 69.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        self.eventsTableView.backgroundView = UIView()
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.searchTextField.backgroundColor = UIColor(red: 1.0/255.0, green: 8.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func setUpViewModel(){
        self.eventViewModel =  EventListViewModel(listener: self)
        self.eventsTableView.delegate = self
        self.eventsTableView.dataSource = self
    }
    func checkIfSearchRequiredAndGetEvent(searchText: String) {
        if let textToSearch = self.searchText {
            if textToSearch != searchText {
                self.getEvent(searchText: searchText)
            }
        } else {
            self.getEvent(searchText: searchText)
        }
    }
    
    func getEvent(searchText: String) {
        self.searchText = searchText
        self.showIndicator(withTitle: "Loading...", and: "")
        self.eventViewModel.getEventWithSearchQuery(query: searchText)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.events = self.eventViewModel.events.events
            if self.events.count > 0 {
                self.eventsTableView.isHidden = false
                self.eventsTableView.reloadData()
                self.noEventsLabel.isHidden = true
            } else {
                self.eventsTableView.isHidden = true
                self.noEventsLabel.isHidden = false
            }
            
        }
    }
    
    func showErrorMessageAndAskUserToRetry(message: String) {
        DispatchQueue.main.async {
            NativeAlertController.alert("Error", message: message, buttons: ["Ok", "Retry"]) { (action, index) in
                if(index == 1) {
                    self.checkIfSearchRequiredAndGetEvent(searchText: self.searchController.searchBar.text ?? "")
                }
            }
        }
    }
    
}
extension EventListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.checkIfSearchRequiredAndGetEvent(searchText: searchController.searchBar.text ?? "")
    }
}


extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.events.count > 0 && self.events.count > indexPath.row  {
            let event = self.events[indexPath.row]
            self.eventViewModel.pushToEventDetailsPage(event: event, navigationController: self.navigationController,viewController: self)
        }
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.events.count > 0 && self.events.count > indexPath.row  {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.className, for: indexPath) as! EventTableViewCell
            let event = self.events[indexPath.row]
            cell.configureCell(event: event)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}


extension EventListViewController: EventListViewControllerListener {
    func getEventWithSearchQueryCallback(isSuccess: Bool, message: String) {
        self.hideIndicator()
        if isSuccess {
            self.reloadTableView()
        } else {
            
        }
    }
}

extension EventListViewController: EventDetailsViewControllerDelegate {
    func didUpdateFavorite(event: Event) {
        if let eventIndex = self.eventViewModel.provideTheIndexOfEventInEventsArray(events: self.events, event: event) , eventIndex >= 0 {
            self.events[eventIndex] = event
        }
    }
}
