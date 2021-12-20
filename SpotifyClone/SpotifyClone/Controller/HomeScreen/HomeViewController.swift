//
//  HomeViewController.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 20.12.21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var categories: [Category]!

    override func viewDidLoad() {
        super.viewDidLoad()

        categories = CategoryService.shared.getCategories()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: K.categoryCell, for: indexPath) as? CategoryCell else {
                   return UITableViewCell()
               }
        let currentIndex = indexPath.row
        let category = categories[currentIndex]
        categoryCell.update(category: category, index: currentIndex)
        return categoryCell
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // get category index from the collection tag
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        
        return category.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.albumCell, for: indexPath) as? AlbumCell else {
                   return UICollectionViewCell()
               }
        let categoryIndex = collectionView.tag
        let album = categories[categoryIndex].albums[indexPath.row]
        albumCell.update(album: album)
        
        return albumCell
    }
    
    
}
