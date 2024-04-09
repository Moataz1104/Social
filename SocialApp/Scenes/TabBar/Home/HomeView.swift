//
//  HomeView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 08/04/2024.
//

import UIKit

struct Post {
    let title: String
    let content: String
}


class HomeView: UIViewController , AddPostCellDelegate{
    
    var cellHeight: CGFloat?
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        generateFakeData()

    }

    
    
//    MARK: - Cell Height Delegate
    
    func cellHeightDidChange(_ height: CGFloat) {
        cellHeight = height
    }

    
//    MARK: - Actions 
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    
//    MARK: - Privates
    func generateFakeData() {
        for i in 1...100 {
            let post = Post(title: "Post \(i)", content: "Content for post \(i)")
            posts.append(post)
        }
    }
    
    private func registerCells(){
        tableView.register(UINib(nibName: AddPostCell.identifier, bundle: nil), forCellReuseIdentifier: AddPostCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    
}

extension HomeView: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPostCell.identifier, for: indexPath) as! AddPostCell
            cell.delegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let post = posts[indexPath.row]
            cell.textLabel?.text = post.title
            cell.detailTextLabel?.text = post.content
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? cellHeight ?? 150 : UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
