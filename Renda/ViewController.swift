//
//  ViewController.swift
//  Renda
//
//  Created by Keitaro Kawahara on 2022/08/25.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var tapButton: UIButton!
    
    var tapCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tapButton.layer.cornerRadius = 125
        
        // Firestoreのデータを監視する
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
            if error != nil {
                print("エラーが発生しました")
                print(error)
                return
            }
            let data = snapshot?.data()
            if data == nil {
                print("データがありません")
                return
            }
            let count = data!["count"] as? Int
            if count == nil {
                print("countという対応する値がありません")
                return
            }
            self.tapCount = count!
            self.countLabel.text = String(count!)
        }
        
    }
    
    // Firestoreを扱うためのプロパティ
    let firestore = Firestore.firestore()
    
    @IBAction func tapTapButton() {
        
        tapCount = tapCount + 1
        
        countLabel.text = String(tapCount)
        
        // FirestoreにtapCountを書き込む
        firestore.collection("counts").document("share").setData(["count": tapCount])
    }
    
    
}

