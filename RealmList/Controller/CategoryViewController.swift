//
//  ViewController.swift
//  RealmList
//
//  Created by Ahmed Hamam on 11/02/2023.
//

import UIKit
import RealmSwift
class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
   private var categoryArray:Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTable()
        RealmDataBase.shared.getRealmPath()
        categoryArray = RealmDataBase.shared.getCategory()
    }
    func setUpView(){
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "To Do List"
    }
    func setUpTable(){
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.backgroundColor = .lightGray
        categoryTableView.separatorStyle = .none
    }
    
    @IBAction func addCategoryButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Category", message: "Add Category", preferredStyle: .alert)
        alert.addTextField{(textField) in
            textField.placeholder = "Enter New Category"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default,handler: { [weak self]_ in
            guard let self = self,let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {return}
            let newCategory = Category()
            newCategory.title = text
            RealmDataBase.shared.saveInRealm(data: newCategory)
            self.categoryTableView.reloadData()

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
}

extension CategoryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoryTableViewCell{
            cell.categoryLabel.text = categoryArray?[indexPath.row].title
            cell.backgroundColor = .lightGray
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("delete")
        if let catego = categoryArray?[indexPath.row]{
            RealmDataBase.shared.deleteFromRealm(data: catego)

        }
       
        categoryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController else{return}
        VC.category = categoryArray?[indexPath.row]
           navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

  
}

