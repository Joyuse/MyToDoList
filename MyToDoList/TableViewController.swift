//
//  TableViewController.swift
//  MyToDoList
//
//  Created by Vladimir Pavlov on 14.03.2021.
//

//Отображение в приложение
import UIKit

class TableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
    override func viewDidLoad() {
        super.viewDidLoad()

        /* кушает кол-во нажатий = 2 можно изменить
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            tap.numberOfTapsRequired = 2
            view.addGestureRecognizer(tap)
         */
        
        /* кушает 1 нажатие (настроить потом долгое нажатие)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //используем готовые методы для работы возвращаем отображение строк == кол-ву записей в массиве
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    //забираем ячейку и изменяем ее для вывода нашего массива
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //добавление записи из словаря с неявным конвертированием (?) в строку
        let items = list[indexPath.row]
        cell.textLabel?.text = items ["NameListItem"] as? String
        //если да то поставить галочку
        if items["Completed"] as? Bool == true {
            cell.accessoryType = .checkmark
        }
        //если нет то убрать
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //добавление записей
    @IBAction func addItems(_ sender: Any) {
        //вызов всплывающего окна
        let alertController = UIAlertController(title: "Add to list", message: nil, preferredStyle: .alert)
        // добавляем текстовое поле
        alertController.addTextField { (noteTextFiled) in
            noteTextFiled.placeholder = "New note"
        //При нажатии на кнопку "добавить" не выходя из режима редактирования новая запись находится автоматические в режиме редактирования это можно и нужно убрать с  помощью setEditing == false
            self.tableView.setEditing(false, animated: true)
        }
        
        let apply = UIAlertAction(title: "Apply", style:.cancel) { (alert) in
            //Добавить новую запись через контроллер
            //! - разворот массива
            let newNote =  alertController.textFields![0].text
            addToList(nameItemList: newNote!)
            //self - как this обращение к классу внутри которого мы обращаемся? но при работе в блоке кода(процедуры) self нужен обязательно
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style:.destructive) { (alert) in
        }
        
        //+ фото
        let addPhoto = UIAlertAction(title: "Add Photo", style: .default) { (alert) in
        }
        //добавляем действия apply cancel photo
        alertController.addAction(apply)
        alertController.addAction(cancel)
        alertController.addAction(addPhoto)
        //появление контроллера с анимацией
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editList(_ sender: Any) {
        //для отмены редактирования нужно получать противоположное значение из  editing setEditing - задать, isEditing - значение редактируется true, false если окно не в режиме редактирования
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    //редактирование ячеек по индексу (возвращает кол-во ячеек для редактировния)
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /*
    //при удалении ячейки или ее редактирования
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //удаления ячейки
            deleteItemList(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            print("{ebnf")
        }    
    }
    */
    //обработка нажатия
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //анимация плавности
        tableView.deselectRow(at: indexPath, animated: true)
        //изменение отметки о выполнении
        if changeStateListItem(index: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    //двойное нажатие для редактирования кастыльно получается (доработать)
    @objc func doubleTapped()
    {
        //editTextList()
    }
    
    // Override to support rearranging the table view.
    //меняем записи местами только в режиме редактирования
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //определяем какую запись берем
        //вызываем функцию из model 
        moveItemList(from: fromIndexPath.row, to: to.row)
    }
    
    //Устарело? нужно посмотреть
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let alertController = UIAlertController(title: "Edit note", message: nil, preferredStyle: .alert)
        
        let apply = UIAlertAction(title: "Apply", style:.cancel) { (alert) in
            //Добавить новую запись через контроллер
            //! - разворот массива
            let editNow =  alertController.textFields![0].text
            //addToList(nameItemList: editNow!)
            editTextList(nameItemList: editNow!,index: indexPath.row)
            //self - как this обращение к классу внутри которого мы обращаемся? но при работе в блоке кода(процедуры) self нужен обязательно
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style:.destructive) { (alert) in
        }
        
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") {
            (rowAction, indexPath) in
            //editTextList(index: indexPath.row)
            alertController.addTextField { (noteTextFiled) in
                noteTextFiled.placeholder = "Edit note"
                print("EditButton")
                self.present(alertController, animated: true, completion: nil)
                alertController.addAction(cancel)
                alertController.addAction(apply)
            }
            
            
        }
        editButton.backgroundColor = UIColor.systemBlue
       
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {
            (action,indexPath) in print("Delete")
            deleteItemList(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //present(alertController, animated: true, completion: nil)
      
        //появление контроллера с анимацией
      
        
        
        return [delete,editButton]
    }
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
