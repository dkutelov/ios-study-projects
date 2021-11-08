//
//  BlocksTableViewController.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import UIKit

class BlocksTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var blocksData = [Block]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .blocksDataLoaded, object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                
                self.loadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let blockDetailViewController = segue.destination as? BlockDetailTableViewController,
           let blockCell = sender as? BlockTableViewCell,
           let block = blockCell.block {
            blockDetailViewController.block = block
            
            if block.hasDetails == false {
                RequestManager.fetchBlockWith(blockHash: block.blockHash) { error in
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocksData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "blocksReusableCell", for: indexPath) as? BlockTableViewCell else {
            return UITableViewCell()
        }
        
        let block = self.blocksData[indexPath.row]
        
        cell.block = block
        
        return cell
    }
    
    
    // MARK: - Helpers
    
    private func loadData() {
        DispatchQueue.main.async {
            self.blocksData = [Block](LocalDataManager.realm.objects(Block.self)
                                        .sorted(byKeyPath: "time", ascending: false))
            
            self.tableView.reloadData()
        }
    }
    
}
