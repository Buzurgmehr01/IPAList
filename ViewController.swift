//
//  ViewController.swift
//  IPAList
//
//  Created by Temp on 06/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()
    
    @IBOutlet var tableView: UITableView!
    let SearchController = UISearchController(searchResultsController: nil)
    var searchResponse: SearchResponse?
    var timer: Timer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpSearchBar()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=5"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {_ in
            self.networkService.request(url: urlString) { (result) in
                switch result {
                case .success(let searchResponse):
                    searchResponse.results.map { (track) in
                        self.searchResponse = searchResponse
                        self.tableView.reloadData()
                    }
                case .failure(_):
                    print("error")
                }
            }
        })
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    private func setUpSearchBar(){
        navigationItem.searchController = SearchController
        SearchController.searchBar.delegate = self
        
    }
    
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let trackName = searchResponse?.results[indexPath.row]
        cell.textLabel?.text = trackName?.trackName
        return cell
    }
}


extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     print(searchText)
    }
    
}

