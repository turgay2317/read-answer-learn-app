//
//  PracticesViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import UIKit

class PracticesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    var practiceViewModel = PracticeViewModel()
    var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = userViewModel.currentUser {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        practiceViewModel.load()
        collectionView.reloadData()
    }
}

// CollectionView Design
extension PracticesViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return practiceViewModel.datas!.count / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "practiceCell", for: indexPath) as! PracticeCollectionViewCell
        
        if let practiceData = practiceViewModel.datas![indexPath.row] as? Practice{
            cell.titleLabel.text = String(format: "(%d) - %@", practiceData.number!, practiceData.title!)
            let myLevel = Int(userViewModel.currentUser?.level ?? 0)
            let practiceLevel = Int(practiceData.number ?? 0)
            
            cell.startButton.isEnabled = false
            if myLevel > practiceLevel {
                cell.startButton.setTitle("Tamamlandı", for: .normal)
            }else if myLevel < practiceLevel {
                cell.startButton.setTitle("Kilitli", for: .normal)
            }else{
                cell.startButton.setTitle("Başla", for: .normal)
                cell.startButton.isEnabled = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let cellSize = (width / 2) - 15
        return CGSize(width: cellSize, height: 180)
    }
}

// Click events
extension PracticesViewController{
    @IBAction func buttonClick(_ sender: Any) {
        if userViewModel.practiceCheck(){
            performSegue(withIdentifier: "goParagraphSegue", sender: nil)
        }else{
            alert(title: "Hata", text: "Maalesef hiç enerjiniz kalmamış")
        }
    }
}
