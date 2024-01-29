//
//  TopUsersCollectionViewCell.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import UIKit

import Charts

class TopUsersCollectionViewCell: UICollectionViewCell, BindableType {
    
    @IBOutlet private(set) weak var chartView: BarChartView!
    
    private let valueChartDataSet = BarChartDataSet(entries: [], label: "Top 5 Users")
    private let chartData = BarChartData()
    private var chartDelegate: ChartViewDelegate?
    
    var viewModel: ReportSectionItemViewModel?
   
    deinit {
//            selectIndex = nil
//            selectEntry = nil
            chartDelegate = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupChartView()
    }
    
    func bindViewModel() {
        guard let viewModel = try? viewModel?.reportTopUsersViewModel() else {
            return
        }
        
        update(contents: viewModel.items)
        
    }
    
    private func setupChartView() {
        chartView.renderer = BarChartRenderer(dataProvider: chartView,
                                              animator: chartView.chartAnimator,
                                              viewPortHandler: chartView.viewPortHandler)
        chartView.fitBars = true
        chartView.fitScreen()
        chartView.drawValueAboveBarEnabled = true
        
        // disable zoom function
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(false)
        chartView.highlightPerDragEnabled = false
        chartView.doubleTapToZoomEnabled = false
        
        // Legend
        chartView.legend.enabled = false
        
        let delegate = ChartViewDelegateHandler {[weak self] (_, _, _) in
//            self?.handleSelect(entry: entry, highlight: highlight)
        } selectNone: {[weak self] (_) in
//            self?.handleNoneSelected()
        }
        
        chartView.delegate = delegate
        setupChartXAxisViews()
        setupChartYAxisViews()
        setupChartDataIfNeeded()
        chartDelegate = delegate
    }
    
    private func setupChartXAxisViews() {
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = true
        xAxis.labelRotationAngle = 0
        xAxis.labelCount = 5
        xAxis.axisLineColor = .clear
        xAxis.labelTextColor = .secondaryLabel
        xAxis.granularity = 0.1
        xAxis.granularityEnabled = true
        
        xAxis.labelFont = UIFont.systemFont(ofSize: 12.0)
    }
    
    private func setupChartYAxisViews() {
        let right = chartView.rightAxis
        right.enabled = false
        
        let leftAxis = chartView.leftAxis
        
        leftAxis.drawTopYLabelEntryEnabled = true
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawBottomYLabelEntryEnabled = true
        
        // zero line configuration
        leftAxis.drawZeroLineEnabled = true
        leftAxis.zeroLineWidth = 0.5
        leftAxis.zeroLineColor = .lightGray
        leftAxis.zeroLineDashPhase = 1
        
        // grid line configuration
        leftAxis.drawGridLinesEnabled = true
        leftAxis.gridLineWidth = 0.5
        leftAxis.gridLineDashLengths = [4.8, 7.2]
        leftAxis.gridColor = .gray
        
        leftAxis.granularityEnabled = true
        leftAxis.granularity = 0.01
        
        leftAxis.drawLabelsEnabled = true
        leftAxis.labelCount = 4
        leftAxis.forceLabelsEnabled = true
        leftAxis.axisMinimum = 0
        
    }
    
    private func setupChartDataIfNeeded() {
        let set = valueChartDataSet
        set.setColor(.blue)
        set.highlightColor = .systemGreen
        set.highlightAlpha = 1
        set.valueFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        set.valueTextColor = .black
        
        let data = chartData
        data.barWidth = 0.65
        data.append(set)
        chartView.data = data
    }
    
    private func update(contents items: [UserChartEntryViewModel]) {
        valueChartDataSet.valueFormatter = DefaultValueFormatter(block: { (value, entry, _, _) in
            guard let founded = items.first(where: { $0.dataEntry == entry }) else {
                return "\(value)"
            }
            return founded.formattedValue()
        })
        
        let dataEntries = items.map({ $0.dataEntry })
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: items.map { $0.formattedTitle() })
        update(contents: dataEntries)
    }
    
    private func update(contents: [ChartDataEntry]) {
        
        valueChartDataSet.removeAll(keepingCapacity: true)
        var result = true
        for content in contents {
            result = result && valueChartDataSet.addEntryOrdered(content)
        }
        
        guard result else {
            return
        }
        
        chartData.notifyDataChanged()
        chartView.notifyDataSetChanged()
        chartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInOutBack)
    }
    
    private func handleSelect(entry: ChartDataEntry, highlight: Highlight) {
        
//        guard let index = chartView.barData?[safe: 0]?.entryIndex(entry: entry) else {
//            return
//        }
        
//        self.selectIndex?(self, index)
    }
    
    private func handleNoneSelected() {
        
    }
    
    private func highlight(entry: ChartDataEntry) {
        guard chartView.barData?.count != 0 else {
            return
        }
        
        chartView.highlightValue(Highlight(x: entry.x, y: entry.y, dataSetIndex: 0), callDelegate: false)
    }
    
}

fileprivate extension TopUsersCollectionViewCell {
    
    final class ChartViewDelegateHandler: NSObject, ChartViewDelegate {
        
        typealias SelectHandler = (ChartViewBase,ChartDataEntry, Highlight) -> Void
        typealias SelectNoneHandler = (ChartViewBase) -> Void
        
        private let handler: SelectHandler
        private let noneHandler: SelectNoneHandler
        
        init(handler: @escaping SelectHandler, selectNone: @escaping SelectNoneHandler) {
            self.handler = handler
            self.noneHandler = selectNone
        }
        
        func chartValueNothingSelected(_ chartView: ChartViewBase) {
            noneHandler(chartView)
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            handler(chartView, entry, highlight)
        }
    }
    
}
