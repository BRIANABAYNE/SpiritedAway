//
//  CharacterListTableViewController.swift
//  AnimeMVVM
//
//  Created by Briana Bayne on 6/29/23.
//

import UIKit // We are importing UIkit for a picture.

class CharacterListTableViewController: UITableViewController {
    
    // Here we are providing the background logic from the viewModel to the TableViewController. This is allowing the background information to the characterListViewModel.
    var viewModel: CharacterListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Injecting the delegate
        viewModel = CharacterListViewModel(injectedDelegate: self)
    }
    
    // MARK: - Table view data source
    
    // Number of sections in rows
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This is giving the information of the characterlist from the viewModel how many characters we will have by the count. This is telling how many rows in sections to have.
        return viewModel.characterList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell() }
        // We are type casting our custom CharacterTableViewCell else we will return with a basic B ( UITablewViewCell )
        let selectedCharacter = viewModel.characterList[indexPath.row]
       // cell.viewModel.characterData = selectedCharacter
        // We are creating a constant called selectedCharater and giving it the value of the viewModel.characterList for the indexPath per row.
        cell.viewModel = CharacterSingleViewModel(injectedDelegate: cell, characterData: selectedCharacter)
        return cell
    }
    // Need more help around understanding this.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC" else { return }
               guard let indexPath = tableView.indexPathForSelectedRow,
              let cell = tableView.cellForRow(at: indexPath) as? CharacterTableViewCell,
              let destination = segue.destination as? CharacterSingleDetailViewController,
                     let imageToSend = cell.characterImageView.image,
                     let characterToSend = cell.viewModel?.fetchedCharacter else { return }
        destination.configure(with: characterToSend, image: imageToSend)
    }
}

    // We are extending the characterListTableViewController and this is done outside the scope of the the tableview. We are adpoting the delegate and calling the function that is completing with the fetch sucessfuly. We created this function and it could have been named anything. Since we are going back on the mainthread, we are caling the DispatchQu becasue all UI changes happen on the mainthread. Then we are telling self ( meaning the tableViewController ) to reaload the data.

extension CharacterListTableViewController: CharacterListViewModelDelegate {
    func characterListFetchedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
