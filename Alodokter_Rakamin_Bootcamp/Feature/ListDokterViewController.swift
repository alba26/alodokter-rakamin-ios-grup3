//
//  ListDokterViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by Felinda Gracia Lubis on 18/12/21.
//

import UIKit

class ListDokterViewController: UIViewController {

    @IBOutlet weak var contentView: ListDokterView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(UINib(nibName: "ListDokterTableViewCell", bundle: nil), forCellReuseIdentifier: "dokterCell")
    }
}

extension ListDokterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dokterCell") as! ListDokterTableViewCell
        cell.content.cardView()
        cell.doctorImageView.circleView()
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorDetailViewController") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
