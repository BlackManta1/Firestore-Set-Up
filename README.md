# Firestore-Set-Up
Cloud Firestore, the lasted back-end mobile app solution for realtime database

## Let's get to the heart of the matter

3 functions:
- [x] 1 - How to add data
- [x] 2 - How to read data
- [x] 3 - How to filter data

### Source Code

```swift

    import Firebase

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



```
### Data Structure
<p align="left">
<img src="https://user-images.githubusercontent.com/46055179/64755877-b2bd9100-d53d-11e9-93ee-7cab927b1b68.PNG" width="923">
</p>


