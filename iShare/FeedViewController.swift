//
//  FeedViewController.swift
//  iShare
//
//  Created by Peter Leung on 2/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    var posts = [Posts]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print(snapshot)
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots.reversed() {
                    if let postDictionary = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let post = Posts(postKey: key, postData: postDictionary)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
            
            }) { (error) in
                print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? PostCell {
            if  post.imageUrl != nil, let img = FeedViewController.imageCache.object(forKey: post.imageUrl! as NSString){
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
            

        } else {
            return PostCell()
        }
        


    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImageImage.image = image
            imageSelected = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: AnyObject) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postAction(_ sender: AnyObject) {
        guard let caption = captionField.text, caption != "" else {
            return
        }
        
        guard let img = addImageImage.image else {
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
           let imgUUID = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            DataService.ds.REF_POST_IMAGES.child(imgUUID).put(imgData, metadata: metaData, completion: { (metadata, error) in
                if error == nil {
                   let downloadURL = metadata?.downloadURL()?.absoluteString
                    self.postToFireBase(imgurl: downloadURL)
                }else {
                    
                }
            })
        }
        
    }
    
    func postToFireBase(imgurl:String?){
        let postDict: Dictionary<String,AnyObject> = [
            "caption": captionField.text! as AnyObject,
            "imageUrl": imgurl!as AnyObject,
            "likes": 0 as AnyObject
        ]
        
        let FirebasePost = DataService.ds.REF_POSTS.childByAutoId()
        FirebasePost.setValue(postDict)
        
        captionField.text = ""
        imageSelected = false
        addImageImage.image = UIImage(named: "add-image")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
