//
//  ArtistViewController.swift
//  Artistry
//
//  Created by Teaocat on 2018/1/11.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ArtistListViewController: UIViewController {
    // MARK: - Variable
    let artists: [Artist] = Artist.artistsFromBundle()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Root View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ArtistDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedArtist = artists[indexPath.row]
        }
    }
}

// MARK: - UITableViewDataSource
extension ArtistListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtistTableViewCell
        
        let artist = artists[indexPath.row]
        
        cell.artistImageView.image = artist.image
        
        cell.artistNameLabel.text = artist.name
        cell.artistNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.artistNameLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        cell.artistNameLabel.textAlignment = .center
        
        cell.artistBioLabel.text = artist.bio
        cell.artistBioLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        cell.artistNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.artistBioLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        cell.selectionStyle = .none
        
        return cell
    }
}
