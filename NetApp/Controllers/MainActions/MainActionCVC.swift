//
//  MainActionCVC.swift
//  NetApp
//
//  Created by Роман Корсак on 19.04.22.
//

import UIKit

enum UserActions: String, CaseIterable {
    case downLoadImage = "Download Image"
    case users = "Users"
}

private let reuseIdentifier = "Cell"

final class MainActionCVC: UICollectionViewController {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let usersTVC = segue.destination as? UserTVCProtcol else { return }
        usersTVC.fetchData()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserActions.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActionCVCell
        cell.actionLBL.text = UserActions.allCases[indexPath.item].rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = UserActions.allCases[indexPath.item]

        switch userAction {
        case .downLoadImage: performSegue(withIdentifier: "imageVC", sender: nil)
        case .users: performSegue(withIdentifier: "usersTVC", sender: nil)
        }
    }
}

// MARK: Extension MainActionCVC
extension MainActionCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    }
}
