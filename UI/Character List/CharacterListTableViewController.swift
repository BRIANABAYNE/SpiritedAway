//
//  CharacterListTableViewController.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import UIKit // We are importing UIkit for a picture.

class CharacterListTableViewController: UITableViewController {
    

    var viewModel: CharacterListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        viewModel = CharacterListViewModel(injectedDelegate: self)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return viewModel.characterList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell() }
     
        let selectedCharacter = viewModel.characterList[indexPath.row]
     
        cell.viewModel = SingleCharacterViewModel(injectedDelegate: cell, characterData: selectedCharacter)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC" else { return }
               guard let indexPath = tableView.indexPathForSelectedRow,
              let cell = tableView.cellForRow(at: indexPath) as? CharacterTableViewCell,
              let destination = segue.destination as? SingleCharacterDetailViewController,
                     let imageToSend = cell.characterImageView.image,
                     let characterToSend = cell.viewModel?.fetchedCharacter else { return }
        destination.configure(with: characterToSend, image: imageToSend)
    }
}

// MARK: - EXtension

extension CharacterListTableViewController: CharacterListViewModelDelegate {
    func characterListFetchedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
