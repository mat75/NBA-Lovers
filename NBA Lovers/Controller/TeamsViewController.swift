//
//  TeamsViewController.swift
//  NBA Lovers
//
//  Created by mattia mauceri on 08/02/2021.
//

import UIKit

class TeamsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setStatusBar(backgroundColor: .systemIndigo)
        setupTableView()
    }
    
    func setupTableView(){
        self.tableView.register(UINib(nibName: K.teamCellNibName, bundle: nil), forCellReuseIdentifier: K.teamcellIdentifier)
        self.tableView.backgroundColor = .dirtyWhite
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}
    
//MARK: - table view datasource
extension TeamsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.teamcellIdentifier) as? TeamTableViewCell ?? UITableViewCell()
        return cell
    }
    

}
