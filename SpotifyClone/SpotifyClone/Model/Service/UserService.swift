//
//  UserService.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 22.12.21.
//

import Foundation

class UserService {
    static let shared = UserService()
    
    private let currentUser = User()
    
    private init() {}
    
    func followAlbum(album: Album) {
        if !isFollowingAlbum(album: album) {
            currentUser.followingAlbums.append(album.name)
            album.followers = album.followers + 1
        }
    }
    
    func unfollowAlbum(album: Album) {
        if let index = currentUser.followingAlbums.firstIndex(of: album.name) {
            currentUser.followingAlbums.remove(at: index)
            album.followers = album.followers - 1
        }
    }
    
    func isFollowingAlbum(album: Album) -> Bool {
        return currentUser.followingAlbums.contains(album.name)
    }
    
    func favoriteSong(this song: Song) {
        if !isFavoritedSong(this: song) {
            currentUser.favoriteSongs.append(song.title)
        }
    }
    
    func unfavoriteSong(this song: Song) {
        if let index = currentUser.favoriteSongs.firstIndex(of: song.title) {
            currentUser.favoriteSongs.remove(at: index)
        }
    }
    
    func isFavoritedSong(this song: Song) -> Bool {
        return currentUser.favoriteSongs.contains(song.title)
    }
}
