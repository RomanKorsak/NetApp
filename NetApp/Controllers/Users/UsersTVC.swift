//
//  UsersTVC.swift
//  NetApp
//
//  Created by Роман Корсак on 19.04.22.
//

import UIKit

protocol UserTVCProtcol {
    func fetchData()
}

final class UsersTVC: UITableViewController {
    
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.nameLBL.text = users[indexPath.row].name
        cell.userNameLBL.text = users[indexPath.row].username
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "DetailedPersonVC") as? DetailedPersonVC else { return }

        detailedVC.person = users[indexPath.row]
        navigationController?.pushViewController(detailedVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movingUser = users[fromIndexPath.row]
        users.remove(at: fromIndexPath.row)
        users.insert(movingUser, at: to.row)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - Extension UsersTVC
extension UsersTVC: UserTVCProtcol {
    func fetchData() {
        guard let url = URL(string: ApiConstants.usersURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else { return }
            do {
                self?.users = try JSONDecoder().decode([User].self, from: data)
                print(self?.users ?? "")
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }
}
