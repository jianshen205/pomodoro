//
//  PDStatViewController.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit

class PDStatViewController: UIViewController {
    var defaults : PDDefaults!
    var persistanceService : PDPersistanceService!
    var subjects : [Subject]?
    init() {
        super.init(nibName: nil, bundle: nil)
        self.persistanceService = PDPersistanceService()
        self.defaults = PDDefaults()
        self.subjects = self.persistanceService.fetchAllSubjects()
        self.view.backgroundColor = .orange
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.view.addSubview(statStackView)
        NSLayoutConstraint.activate([
            statStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            statStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            statStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            statStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        self.tableView.register(PDTimeDisplayCell.self, forCellReuseIdentifier: "TimeDisplay")
        self.tableView.register(PDHeaderCell.self, forCellReuseIdentifier: "Header")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    lazy var statStackView: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [barChartView, tableView])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    
    lazy var barChartView : PDBarChartView = {
        let barChart = PDBarChartView()
        barChart.frame = .zero
        return barChart
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
}

extension PDStatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.persistanceService.fetchAllSubjects().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let subject = self.subjects?[indexPath.row]
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier:"TimeDisplay") as? PDTimeDisplayCell else {
            assertionFailure("dequeue didn't return a tablecell")
            return PDTimeDisplayCell()
        }
        cell.primaryText.text = subject?.name
        cell.secondaryText.text =  String(self.persistanceService.getSessionTimeOfSubject(subject: subject!) / 60)
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "Header") as? PDHeaderCell else {
            assertionFailure()
            return PDHeaderCell()
        }
        return cell
    }
    
}
