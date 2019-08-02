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
        
        self.view.isUserInteractionEnabled = true
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGuesture)
        tapGuesture.numberOfTapsRequired = 1
        tapGuesture.delegate = self
            
        workPicker.delegate = self
        shortBreakPicker.delegate = self
        longBreakPicker.delegate = self
        dailyGoalsPicker.delegate = self
        workPicker.dataSource = self
        shortBreakPicker.dataSource = self
        longBreakPicker.dataSource = self
        dailyGoalsPicker.dataSource = self
        
        tableView.backgroundColor = .white
        
        pickerData = generateData(min: 1, max: 60)
        dailyGoalsData = generateData(min: 1, max: 30)
        hiddenRows = [1,3,5,7]
        
        
        
    }

    private func generateData(min: Int, max: Int) -> [Int] {
        var array: [Int] = [Int]()
        for number in min...max {
            array.append(number)
        }
        return array
    }
    

    func setLabelValue(){
        workLengthLabel.text = Format.timeToString(defaults.getWorkLength() / 60)
        workLengthLabel.text?.append(" mins")
        shortBreakLabel.text = Format.timeToString(defaults.getShortBreak()/60)
         shortBreakLabel.text?.append(" mins")
        longBreakLabel.text = Format.timeToString(defaults.getLongBreak() / 60)
         longBreakLabel.text?.append(" mins")
        dailyGoalLabel.text = Format.timeToString(defaults.getDailyGoal() )
        dailyGoalLabel.text?.append(" sessions")
    }
    
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
        //if click on the row whose pickerview is already opened
        if hiddenRows.count == 3 && shownPickerRow == indexPath.row + 1{
            hiddenRows = [1,3,5,7]
            shownPickerRow = nil
            
        }else{
            hiddenRows = [1,3,5,7]
            shownPickerRow = hiddenRows[indexPath.row/2]
            hiddenRows.remove(at: indexPath.row/2)
        }
        switch shownPickerRow {
        case 1:
            workPicker.selectRow(defaults.getWorkLength() / 60 - 1, inComponent: 0, animated: false)
        case 3:
            shortBreakPicker.selectRow(defaults.getShortBreak() / 60 - 1, inComponent: 0, animated: false)
        case 5:
            longBreakPicker.selectRow(defaults.getLongBreak() / 60 - 1, inComponent: 0, animated: false)
        case 7:
            dailyGoalsPicker.selectRow(defaults.getDailyGoal() - 1, inComponent: 0, animated: false)
        default:
            break

        }
        tableView.endUpdates()
    }
    
}

extension PDSettingViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        if (touch.view?.isKind(of: UITableView.self))! {
            return true
        }else{
            return false
        }
    }
    
    @objc func viewTapped() {
        tableView.performBatchUpdates({
            hiddenRows = [1,3,5,7]
            shownPickerRow = nil
        }, completion: nil)
    }
}


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
            defaults.setLengthOfWork(value: Int(pickerData[row]) * 60)
        case shortBreakPicker:
            defaults.setLengthOfShortBreak(value: Int(pickerData[row]) * 60)
        case longBreakPicker:
            defaults.setLengthOfLongBreak(value: Int(pickerData[row]) * 60)
        case dailyGoalsPicker:
            defaults.setDailyGoal(value: Int(pickerData[row]) )
        default:
            fatalError()
        }
        setLabelValue()
    }
}
