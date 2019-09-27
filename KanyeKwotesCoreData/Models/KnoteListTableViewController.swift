//
//  KnoteListTableViewController.swift
//  KanyeKwotesCoreData
//
//  Created by Christopher Alegre on 9/26/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import UIKit
import CoreData

class KnoteListTableViewController: UITableViewController, ButtonTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        KwoteController.shared.fetchResultsController.delegate = self
    }
    
    @IBAction func newKnoteTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "add a Kwote", message: "Please honnor our dear buddy Kanye with a kwote", preferredStyle: .alert)
        
        let isKanyeButton = UIAlertAction(title: "Is Kayne", style: .default) { (action) in
            guard let newKnoteBody = alert.textFields?[0].text else {return}
            KwoteController.shared.add(body: newKnoteBody, isKanye: true)
        }
        
        let isNotKayneButton = UIAlertAction(title: "Not Kayne", style: .destructive) { (_) in
            guard let newKnoteBody = alert.textFields?[0].text else {return}
            KwoteController.shared.add(body: newKnoteBody, isKanye: false)
        }
        
        let canelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (_) in }
        alert.addAction(isKanyeButton)
        alert.addAction(isNotKayneButton)
        alert.addAction(canelButton)
        self.present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        KwoteController.shared.fetchResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KwoteController.shared.fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionNumber = Int(KwoteController.shared.fetchResultsController.sections?[section].name ?? "zero")
        if sectionNumber == 0 {
            return "Unvailed"
        } else {
            return "Vailed"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: KnoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "KnoteController", for: indexPath) as? KnoteTableViewCell else {return UITableViewCell()}
        
        let knote = KwoteController.shared.fetchResultsController.object(at: indexPath)
        cell.update(knote: knote)
        cell.delegate = self

        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let knote = KwoteController.shared.fetchResultsController.object(at: indexPath)
            KwoteController.shared.delete(knote: knote)
            
        } else if editingStyle == .insert { }
    }
    
    func kayneButtonTapped(_ sender: KnoteTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else {return}
        let knote = KwoteController.shared.fetchResultsController.object(at: index)
        KwoteController.shared.toggle(knote: knote)
        sender.update(knote: knote)
       }
}

extension KnoteListTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default: return
        }
    }
}
