//
//  ViewController.swift
//  FirestoreApp
//
//  Created by Saliou DJALO on 10/09/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.handleColorView), userInfo: nil, repeats: true)
        
        //addDataFirestore()
        //readDataFirestore()
        filterDataFirestore()
        
    }
    
    @objc func handleColorView() {
        let randomRed = Int.random(in: 0 ..< 256)
        let randomGreen = Int.random(in: 0 ..< 256)
        let randomBlue = Int.random(in: 0 ..< 256)
        view.backgroundColor = UIColor(red: CGFloat(randomRed)/255, green: CGFloat(randomGreen)/255, blue: CGFloat(randomBlue)/255, alpha: 1)
    }
    
    // Lets start with a example of Cloud Firestore
    
    // Done
    func addDataFirestore() {
        var ref: DocumentReference? = nil
        
        let userValues: [String: Any] = [
            "first": "Bobby",
            "last": "Murphy",
            "born": 1988
        ]
        
        ref = Firestore.firestore().collection("users").addDocument(data: userValues) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // Done
    func readDataFirestore() {
        Firestore.firestore().collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    let dictionary: [String: Any] = document.data()
                    if let firstName = dictionary["first"] as? String, let lastName = dictionary["last"] as? String, let bornYear = dictionary["born"] as? Int {
                        print("First: \(firstName) - Last: \(lastName) - Born Year: \(bornYear)")
                    }
                }
            }
        }
    }
    
    // filter data
    func filterDataFirestore() {
        // Je veux recuperer la liste des utilisateurs nees avant 1995.
        Firestore.firestore().collection("users").whereField("born", isLessThan: 1995)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let dictionary: [String: Any] = document.data()
                        if let firstName = dictionary["first"] as? String, let lastName = dictionary["last"] as? String, let bornYear = dictionary["born"] as? Int {
                            print("\(firstName) \(lastName) is born in \(bornYear)")
                        }
                        
                    }
                }
        }
        
    }
    
    
    
}

