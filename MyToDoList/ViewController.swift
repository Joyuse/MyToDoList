//
//  ViewController.swift
//  MyToDoList
//
//  Created by Vladimir Pavlov on 12.03.2021.
//

import UIKit

var data: [String] = ["Create App", "Add func", "Commit", "Profit"]
 

// дополненные делегаты и датасоурс
class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // привязанный эллемент tableView
    @IBOutlet weak var tableView: UITableView!
    
    
    //возвращаем кол-во элементов data.count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }

    // метод вызовится столько, сколько у нас ячеек data.count
    // indexPath  - section = 0 row = 1.. data.count
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //withIdentifier - берем из storyBoard - индекс(Uniq)
        //IndextPath - индекс элемента в массиве
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    //функция для нажатия по объекту TableView(новая ячейка)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //функци для нажатия по объекту TableView (выбранная ячейка)
    
    
    
}

