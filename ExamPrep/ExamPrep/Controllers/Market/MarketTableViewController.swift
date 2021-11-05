//
//  MarketTableViewController.swift
//  ExamPrep
//
//  Created by Dari Kutelov on 5.11.21.
//

import UIKit

class MarketTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var marketData = [Coin]()
    var favorites = [Coin]()
    let searchController = UISearchController()
    var currentSearchString: String?
    
    // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search controller
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        NotificationCenter.default.addObserver(forName: .marketDataLoaded, object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.loadData(searchString: self.currentSearchString)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let coinDetailViewController = segue.destination as? CoinDetailTableViewController,
           let coinCell = sender as? CoinTableViewCell,
           let coin = coinCell.coin {
                coinDetailViewController.coin = coin
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData(searchString: nil)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return favorites.count
        case 1:
            return marketData.count
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.coinCellreuseIdentifier, for: indexPath) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        
        //let coin = marketData[indexPath.row]
        
        switch indexPath.section {
        case 0:
            cell.coin = favorites[indexPath.row]
        case 1:
            cell.coin = marketData[indexPath.row]
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var coin = Coin()
        
        switch indexPath.section {
        case 0:
            coin = favorites[indexPath.row]
        case 1:
            coin = marketData[indexPath.row]
        default:
            break
        }
        
        let isFavorite = (LocalDataManager.favoriteCoins.coins.contains(coin.id))
        
        
        let favoriteSwipAction = UIContextualAction(style: .normal, title: isFavorite ? "Infavorite" :"Favorite") { _ , _ , completionHandler in
            
            switch isFavorite {
            case true:
                if let index = LocalDataManager.favoriteCoins.coins.index(of: coin.id) {
                    try? LocalDataManager.realm.write({
                        LocalDataManager.favoriteCoins.coins.remove(at: index)
                    })
                }
            case false:
                try? LocalDataManager.realm.write({
                    LocalDataManager.favoriteCoins.coins.append(coin.id)
                })
            }
            
            self.loadData(searchString: self.currentSearchString)
            completionHandler(true) // to close
        }
        
        favoriteSwipAction.backgroundColor = .yellow
        return UISwipeActionsConfiguration(actions: [favoriteSwipAction])
    }
    
    // MARK: - Helpers
    
    private func loadData(searchString: String?) {
        DispatchQueue.main.async {
            // Need to cast to array the Results object of realm
            self.marketData = [Coin](LocalDataManager.realm.objects(Coin.self)
                                        .sorted(byKeyPath: "market_cap", ascending: false))
                .filter({ searchString == nil || $0.name.lowercased().contains(searchString?.lowercased() ?? "") })
            
            let currentFavorite = LocalDataManager.favoriteCoins
            self.favorites = self.marketData.filter({ currentFavorite.coins.contains($0.id) })
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - Search Controller Delegate

extension MarketTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let textInSearchBar = searchController.searchBar.text, textInSearchBar.isEmpty == false {
            currentSearchString = textInSearchBar
            loadData(searchString: textInSearchBar)
        }
    }
}
