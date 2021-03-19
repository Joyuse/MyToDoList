//
//  Model.swift
//  MyToDoList
//
//  Created by Vladimir Pavlov on 14.03.2021.
//

//логика приложения описывается тут

import Foundation

//записи toDoList
var list:[[String : Any]] {
    //сохранение данных
    
    // newValue - новый list (любые изменение list'a) с подгрузкой словаря из addToList
    set {
        UserDefaults.standard.set(newValue, forKey: "listToDoKey")
        UserDefaults.standard.synchronize()
    }
    //загрузка данных
    get {
        if let listArray = UserDefaults.standard.array(forKey: "listToDoKey") as? [[String:Any]] {
         return listArray
        }
        else {
            return []
        }
    }
}

//первый запуск приложения
@discardableResult func firstLaunch() -> Bool {
    let defaults = UserDefaults.standard
    //не первый запуск приложения
    if defaults.string(forKey: "firstLaunch") != nil{
        return true
    }
    //первый запуск приложения
    else{
        defaults.set(true, forKey: "firstLaunch")
        list.append(["NameListItem": "New Note","Completed" : false])
        return false
    }
}

//добавить запись
func addToList(nameItemList: String, complete: Bool = false){
    if nameItemList.isEmpty {
        print("Строка пустая")
    }
    else {
        list.append(["NameListItem": nameItemList,"Completed" : complete])
    }
}

//редактировать
func editTextList(nameItemList: String, complete: Bool = false ,index: Int){
    //удалить ячейку № index
    //list.remove(at: index)
    //вставить на место index новую запись
    list[index] = ["NameListItem": nameItemList,"Completed" : complete]
    //list.append(["NameListItem": nameItemList,"Completed" : complete])
    print(index)
}

//удалить
func deleteItemList(index: Int){
    list.remove(at: index)
}

//Отметка о выполнении записей
func changeStateListItem(index: Int) -> Bool{
    list[index]["Completed"] = !(list[index]["Completed"] as! Bool)
    return (list[index]["Completed"] as! Bool)
}


//перенос записи
func moveItemList(from: Int, to: Int){
    let moveItemList = list[from]
    //передвигаем старую запись со старой at
    list.remove(at: from)
    //вставляем запись в новое плоожение to
    list.insert(moveItemList, at: to)
}

//добавить фотографию
func makePhoto (){
    
}



//Изменение текста (Курсив, жирный)

//Изменение текста (шрифт, размер)

