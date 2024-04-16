//
//  NotifiView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/04/2024.
//

import UIKit

class NotifiView: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        registerCell()
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: NotifiCell.identifier, bundle: nil), forCellReuseIdentifier: NotifiCell.identifier)
    }


}

extension NotifiView:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotifiCell.identifier, for: indexPath) as! NotifiCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}
