//
//  ItemViewController.swift
//  RealmList
//
//  Created by Ahmed Hamam on 11/02/2023.
//

import UIKit

import RealmSwift
class ItemViewController: UIViewController {
    
    @IBOutlet weak var itemTableView: UITableView!
    var category : Category?{
        didSet{
            itemArray = category?.items
        }
    }
    
    private var itemArray : List<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTable()
    }
    func setUpView(){
        view.backgroundColor = .lightGray
        navigationItem.largeTitleDisplayMode = .never
        title = category?.title
        
    }
    func setUpTable(){
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.backgroundColor = .lightGray
        itemTableView.separatorStyle = .none
    }
    
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Item", message: "Add Item", preferredStyle: .alert)
        alert.addTextField{(textField) in
            textField.placeholder = "Enter New Item"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default,handler: { [weak self]_ in
            guard let self = self,let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {return}
            
            let newItem = Item()
            newItem.title = text
            try! RealmDataBase.shared.realm.write {
                self.category?.items.append(newItem)
            }
            self.itemTableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    
}

extension ItemViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemTableViewCell{
            cell.backgroundColor = .lightGray
            cell.itemLabel?.text = "   \(itemArray?[indexPath.row].title ?? "")"
            if itemArray[indexPath.row].checked{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = itemArray?[indexPath.row] else {return}
        try! RealmDataBase.shared.realm.write {
            item.checked = !(item.checked )
        }
        if item.checked{
            itemTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            itemTableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("delete")
        let item = itemArray[indexPath.row]
        RealmDataBase.shared.deleteFromRealm(data: item)
        
        itemTableView.reloadData()
    }
}
