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
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumViewController = segue.destination as? AlbumViewController,
            let album = sender as? Album {
            albumViewController.album = album
        }
    }
    
    //change status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        let album = category.albums[indexPath.row]
        performSegue(withIdentifier: K.AlbumSegue, sender: album)
    }
}
