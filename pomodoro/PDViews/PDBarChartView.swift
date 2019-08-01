//
//  PDBarChartView.swift
//  pomodoro
//
//  Created by JianShen on 7/31/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit
class PDBarChartView: UICollectionView {
    var persistanceService = PDPersistanceService()
    var data: [DailyStat]!
    var headerText: String?
    init() {
        
        let flow = UICollectionViewFlowLayout()
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        super.init(frame: .zero, collectionViewLayout: flow)
        self.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        self.register(PDBarChartCell.self, forCellWithReuseIdentifier: "barChartCell")
        self.register(PDBarChartHeaderCell.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        
        self.data = self.persistanceService.getSessionsFromLastWeek()
        self.headerText = buildGraphHeader(stat: data.last!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init with coder is not implemented yet")
    }

    
    func buildGraphHeader(stat: DailyStat) -> String {
        //todo:
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"

        let time = TimeInterval(exactly: stat.length)
        let formatter2 = DateComponentsFormatter()
        formatter2.unitsStyle = .full
        formatter2.allowedUnits = stat.length < 60 ? [.second] : [.day, .hour, .minute]
        
        return String.init(format: "%@: %@", formatter.string(from: stat.date), formatter2.string(from: time!) ?? "")
    }
}

extension PDBarChartView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barChartCell", for: indexPath) as?
            PDBarChartCell else {
                assertionFailure("dequeue didin't return cell")
                return PDBarChartCell(frame:.zero)
        }
        cell.setDay(date: data[indexPath.row].date)
        guard let maxTime: Int = data.max()?.length, maxTime > 0 else { return cell }
        cell.setBarHeight(maxTime: maxTime, seconds: data[indexPath.row].length)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(frame.size.width/CGFloat(data.count)), height: frame.size.height - 45)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? PDBarChartHeaderCell else {
            assertionFailure("DequeueSupplementaryView didn't return a StatBarGraphHeaderCell")
            return PDBarChartHeaderCell(frame: .zero)
        }
        header.updateText(primaryText: "Last 7 Days:", secondaryText: self.headerText!)
        return header
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: 45)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.headerText = buildGraphHeader(stat: data[indexPath.row])
        self.reloadData()
    }
}
