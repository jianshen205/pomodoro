//
//  PDSettingViewController.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit

class PDSettingViewController: UITableViewController {
    
    let defaults = PDDefaults()
//    @IBOutlet weak var workLengthLabel: UILabel!
//
//    @IBOutlet weak var shortBreakLabel: UILabel!
//
//    @IBOutlet weak var LongBreakLabel: UILabel!
//
//    @IBOutlet weak var dailyGoalLabel: UILabel!
//
//    var inputTexts:[String] = ["Work Length","Short Break Length","Long Break Length","Daily Goals"]
//    var inputTimeLength: [String] = []
//    var datePickerIndexPath: IndexPath?
//
//    var timePicker = UIDatePicker()
    
    @IBOutlet weak var workLengthLabel: UILabel!
    
    @IBOutlet weak var shortBreakLabel: UILabel!
    
    @IBOutlet weak var longBreakLabel: UILabel!
    
    @IBOutlet weak var dailyGoalLabel: UILabel!
    
    @IBOutlet weak var workPicker: UIPickerView!
    @IBOutlet weak var shortBreakPicker: UIPickerView!
    @IBOutlet weak var longBreakPicker: UIPickerView!
    @IBOutlet weak var dailyGoalsPicker: UIPickerView!
    var pickerData: [Int] = [Int]()
    var dailyGoalsData: [Int] = [Int]()
    var hiddenRows: [Int] = [Int]()
    var shownPickerRow: Int?
    
    override func viewDidLoad() {
        self.navigationItem.title = "Setting"
        super.viewDidLoad()
        setLabelValue()
        workPicker.delegate = self
        shortBreakPicker.delegate = self
        longBreakPicker.delegate = self
        dailyGoalsPicker.delegate = self
        workPicker.dataSource = self
        shortBreakPicker.dataSource = self
        longBreakPicker.dataSource = self
        dailyGoalsPicker.dataSource = self
        
        
        pickerData = generateData(min: 1, max: 60)
        dailyGoalsData = generateData(min: 1, max: 30)
        hiddenRows = [1,3,5,7]
//        setupInitialVals()
   
    }
    private func generateData(min: Int, max: Int) -> [Int] {
        var array: [Int] = [Int]()
        for number in min...max {
            array.append(number)
        }
        return array
    }
    
    func setupInitialVals() {
//        inputTimeLength = [Format.timeToString(defaults.getWorkLength()), Format.timeToString(defaults.getShortBreak()), Format.timeToString(defaults.getLongBreak()), Format.timeToString(defaults.getDailyGoal())]
    }
    
    func setLabelValue(){
        workLengthLabel.text = Format.timeToString(defaults.getWorkLength())
        workLengthLabel.text?.append(" mins")
        shortBreakLabel.text = Format.timeToString(defaults.getShortBreak())
         shortBreakLabel.text?.append(" mins")
        longBreakLabel.text = Format.timeToString(defaults.getLongBreak())
         longBreakLabel.text?.append(" mins")
        dailyGoalLabel.text = Format.timeToString(defaults.getDailyGoal())
        dailyGoalLabel.text?.append(" sessions")
    }
    
    
    func setDailyGoals() {
//        let saveFn: (Int) -> Void = defaults.setDailyGoal(value:)(_:)
        
//         timePicker = UIDatePicker()
//        timePicker.datePickerMode = .countDownTimer
////        timePicker.delegate = self
//        timePicker.frame = CGRect(x: 0, y:self.view.frame.height * 1/3 , width: self.view.frame.width, height: self.view.frame.height * 2/3)
//        timePicker.backgroundColor = .white
//        timePicker.addTarget(self, action: #selector(setDaily(datePicker:)), for: .valueChanged)
//
//        self.view.addSubview(timePicker)
    }
    

    
    func  setWorkLength () {
        
    }
    func  setShortBreakLength () {
        
    }
    func  setLongBreakLength () {
        
        
    }
    
   
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if datePickerIndexPath != nil {
//            return 5
//        }else{
//            return 4
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if datePickerIndexPath == indexPath{
//            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: PDDatePickerCell.reuseIdentifier()) as! PDDatePickerCell
//            datePickerCell.updateCell( indexPath: indexPath)
//            datePickerCell.delegate = self
//            return datePickerCell
//        }else {
//            let dateCell = tableView.dequeueReusableCell(withIdentifier: PDTimeLengthTableViewCell.reuseIdentifier()) as! PDTimeLengthTableViewCell
//            dateCell.updateText(text: inputTexts[indexPath.row], time: inputTimeLength[indexPath.row])
//            return dateCell
//        }
//
//        }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hiddenRows.contains(indexPath.row) {
            return 0
        } else {
            if [1,3,5,7].contains(indexPath.row){
                return 162
            }
            else{
                return 44
            }
        }
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
        if hiddenRows.count == 3 && shownPickerRow == indexPath.row + 1{
            hiddenRows = [1,3,5,7]
            shownPickerRow = nil
            
        }else{
            hiddenRows = [1,3,5,7]
            shownPickerRow = hiddenRows[indexPath.row/2]
            hiddenRows.remove(at: indexPath.row/2)
            
        }
//        //collapse the cell
//        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row{
//            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
//            self.datePickerIndexPath = nil
//        }else{
//            if let datePickerIndexPath = datePickerIndexPath{
//                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
//            }
//            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
//            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
        tableView.endUpdates()

    }


//    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
//        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row{
//            return indexPath
//        }else{
//            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
//        }
//
//    }
//
    
}

//
//extension PDSettingViewController: PDDatePickerCellDelegate {
//
//    func didChangeDate(timeLength: String, indexPath: IndexPath) {
//        inputTimeLength[indexPath.row] = timeLength
//        switch indexPath.row {
//        case 0:
//            defaults.setLengthOfWork(value: Int(timeLength)!)
//        case 1:
//            defaults.setLengthOfShortBreak(value: Int(timeLength)!)
//        case 2:
//            defaults.setLengthOfLongBreak(value: Int(timeLength)!)
//        case 3:
//            defaults.setDailyGoal(value: Int(timeLength)!)
//        default:
//            fatalError()
//        }
//        tableView.reloadRows(at: [indexPath], with: .none)
//    }
//}

extension PDSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 25
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView {
        case dailyGoalsPicker:
            return String(format: (dailyGoalsData[row] == 1 ? "%d   session" : "%d   sessions"), dailyGoalsData[row])
        default:
            return String(format: (pickerData[row] == 1 ? "%d   min" : "%d   mins"), pickerData[row])
        }
       
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){

        switch pickerView {
        case workPicker:
            defaults.setLengthOfWork(value: Int(pickerData[row]))
        case shortBreakPicker:
            defaults.setLengthOfShortBreak(value: Int(pickerData[row]))
        case longBreakPicker:
            defaults.setLengthOfLongBreak(value: Int(pickerData[row]))
        case dailyGoalsPicker:
            defaults.setDailyGoal(value: Int(pickerData[row]))
        default:
            fatalError()
        }
        setLabelValue()
    }
}
