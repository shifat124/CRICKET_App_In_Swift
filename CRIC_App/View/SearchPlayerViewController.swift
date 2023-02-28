//
//  SearchPlayerViewController.swift
//  CRIC_App
//
//  Created by BJIT on 05/12/1401 AP.
//

import UIKit

class SearchPlayerViewController: UIViewController {
    @IBOutlet weak var searchPlayerField: UITextField!
    var index = 0
    @IBOutlet weak var tableView: UITableView!
    var searchPlayer = [SearchEntity]()
    var viewModel = ViewModel()
    var search = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSearchPlayerFromAPI()
        viewModel.searchedPlayers.bind{ [weak self] data in
            //print("search player data:",data)
            guard let data = data else {
                return
            }
            self?.searchPlayer = configCoreData.shared.getAllRecords(search: self?.search ?? " ")
            if self?.searchPlayer.count == 0 {
                configCoreData.shared.addItemsBatchInsert(data: data)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        searchPlayer = configCoreData.shared.getAllRecords(search: search ?? " ")
        searchBarDesign()
        let nib1 = UINib(nibName: "SquadTableViewCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: "SquadTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchPlayerField.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        if segue.identifier == "gotocareerpage" {
            if let dest = segue.destination as? CareerPlayerViewController{
                dest.loadViewIfNeeded()
                dest.viewModel.getPlayersCareerFromApi(id:Int(searchPlayer[indexPath.row].id))
            }
        }
    }
    func searchBarDesign() {
        //for image and text in search bar
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "search")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "search")!.size.width/15, height: UIImage(named: "search")!.size.height/15)
        imageIcon.frame = CGRect(x: 0, y: 0, width: UIImage(named: "search")!.size.width/15, height: UIImage(named: "search")!.size.height/15)
        searchPlayerField.leftView = contentView
        searchPlayerField.leftViewMode = .always
        searchPlayerField.clearButtonMode = .whileEditing
        
    }
}
extension SearchPlayerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        search = searchPlayerField.text!
        searchPlayer = configCoreData.shared.getAllRecords(search: search)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        return true
    }
}
extension SearchPlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.searchedPlayers.value?.data?.count ?? 0
        return searchPlayer.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadTableViewCell", for: indexPath) as! SquadTableViewCell
        cell.playerName.text = searchPlayer[indexPath.row].fullName
        let localImage = searchPlayer[indexPath.row].imagePath
        if let image = localImage {
            cell.playerImgView.sd_setImage(with: URL(string: image))
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension SearchPlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        index = indexPath.row
        performSegue(withIdentifier: "gotocareerpage", sender: indexPath)
    }
}



