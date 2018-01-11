//
//  ArtistDetailViewController.swift
//  Artistry
//
//  Created by Teaocat on 2018/1/11.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ArtistDetailViewController: UIViewController {
    // MARK: - Variable
    var selectedArtist: Artist!
    let moreInfoText = "Select For More Info >"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedArtist.name

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArtistDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkTableViewCell
        
        let work = selectedArtist.works[indexPath.row]
        
        cell.workImageView.image = work.image
        
        cell.workTitleLabel.text = work.title
        cell.workTitleLabel.textAlignment = .center
        cell.workTitleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.workTitleLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        cell.workInfoLabel.text = work.isExpanded ? work.info : moreInfoText
        cell.workInfoLabel.textAlignment = work.isExpanded ? .left : .center
        cell.workInfoLabel.textColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 0.8)
        
        cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.workInfoLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ArtistDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else {
            return
        }
        
        var work = selectedArtist.works[indexPath.row]
        work.isExpanded = !work.isExpanded
        selectedArtist.works[indexPath.row] = work
        
        cell.workInfoLabel.text = work.isExpanded ? work.info : moreInfoText
        cell.workInfoLabel.textAlignment = work.isExpanded ? .left : .center
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}
