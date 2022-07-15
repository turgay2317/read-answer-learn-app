//
//  WordbookViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import UIKit

class WordbookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userViewModel = UserViewModel()
    var wordViewModel = WordViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let user = userViewModel.currentUser {
            wordViewModel.loadByUserID(id: user.id.stringValue)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

// TableView
extension WordbookViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( wordViewModel.datas?.count ?? 0 )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as! WordTableViewCell
        
        let word = wordViewModel.datas![indexPath.row]
        
        cell.englishLabel.text = word.english

        cell.turkishLabel.text = word.turkish
        
        return cell
    }

}
