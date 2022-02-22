//
//  ContractionTimerViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-15.
//

import UIKit
import SnapKit

class ContractionTimerViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: "Contraction Timer", size: .medium)
 
  var userConstractionRecords : [contractions]?
  var newRecord: contractions?
  var timerValue : String?
  var todaysRecord = [[String]]()
  
  var currentRecordingTitle: String?
  var currentRecordingTime: String?
  
  var startTime: Date?
  var stopTime: Date?
  
  let userDefaults = UserDefaults.standard
  
  var START_TIME_KEY = "startTime"
  var STOP_TIME_KEY = "stopTime"
  var COUNTING_KEY = "countingKey"
  var scheduledTimer: Timer!
  
  
  var inRecordsTab: Bool = false {
    didSet {
      recordList.isHidden = !inRecordsTab
      contractionAndRecordTab.setTitle(inRecordsTab ? "Contraction" : "Records", for: .normal)
      titleLabel.text = inRecordsTab ? "Records" : "Contraction Timer"
    }
  }
  
  var timerCounting: Bool = false {
    didSet {
      stopButton.isEnabled = timerCounting
    }
  }
  
  var isContracting: Bool = false {
    didSet {
      if timerCounting {
        currentRecordingTitle = startButton.currentTitle
      if isContracting {
        startButton.setTitle("Rest", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.3890488148, green: 0.8415637016, blue: 0.7544795871, alpha: 1)
      } else {
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.9845016599, green: 0.3794513941, blue: 0.5343101621, alpha: 1)
      }
      }
    }
  }
  
  var contractionAndRecordTab : UIButton = {
    let button = UIButton()
    button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    button.setTitle("Records", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(contractionAndRecordTabTapped), for: .touchUpInside)
    
    return button
  }()
  
  var buttonsStackView : UIStackView = {
    let buttonsStackView = UIStackView()
    buttonsStackView.axis = .horizontal
    buttonsStackView.distribution = .fillEqually
    buttonsStackView.alignment = .center
    buttonsStackView.spacing = 10
    
    return buttonsStackView
  }()
  
  let timerLabelStackView : UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    stackView.alignment = .top
    
    return stackView
  }()
  
  var minutesLabel : UILabel = {
    let label = UILabel()
    label.text = "00"
    label.font = UIFont(name: "Didot", size: 60)

    return label
  }()
  
  var minutesSignLabel : UILabel = {
    let label = UILabel()
    label.text = "M"
    label.font = UIFont(name: "Didot", size: 20)
    
    return label
  }()
  
  var secondsLabel : UILabel = {
    let label = UILabel()
    label.text = "00"
    label.font = UIFont(name: "Didot", size: 60)
    
    return label
  }()
  
  var secondsSignLabel : UILabel = {
    let label = UILabel()
    label.text = "S"
    label.font = UIFont(name: "Didot", size: 20)
    
    return label
  }()
  
  var startButton = PrimaryButton(title: "Start")
  var stopButton = OutlineButton(title: "Save record")
  
  var timerAndButtonStackView : UIStackView = {
    let timerAndButtonStackView = UIStackView()
    timerAndButtonStackView.axis = .vertical
    timerAndButtonStackView.distribution = .equalSpacing
    timerAndButtonStackView.alignment = .center
    timerAndButtonStackView.spacing = 30
    
    return timerAndButtonStackView
  }()
  
  var currentRecordList : UITableView = {
    let tableView = UITableView()
    return tableView
  }()
  
  var recordList = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSubview()
    snpConstraints()
    tableViewsSetup()
    
    startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
    stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
    timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
    
    stopButton.isEnabled = timerCounting
    
    startButton.addTarget(self, action: #selector(startRestTimer), for: .touchUpInside)
    stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    
    if timerCounting {
      startTimer()
    } else {
      stopTimer()
      if let start = startTime {
        if let stop = stopTime {
          let time = calcRestartTime(start: start, stop: stop)
          let diff = Date().timeIntervalSince(time)
          setTimeLabel(Int(diff))
        }
      }
    }
    
    userConstractionRecords = [
      contractions(contractionDate: Date(), contractionRecord: [details(state: "Constracting", length: "00:04"),details(state: "Rest", length: "00:04")]),
      contractions(contractionDate: Date(), contractionRecord: [details(state: "Constracting", length: "00:06"),details(state: "Rest", length: "00:02")])]
    newRecord =
      contractions(contractionDate: Date(), contractionRecord: [details(state: "Constracting", length: "00:04"),details(state: "Rest", length: "00:07")])
    
  }
  
  func addSubview(){
    buttonsStackView.addArrangedSubview(startButton)
    buttonsStackView.addArrangedSubview(stopButton)
 
    timerLabelStackView.addArrangedSubview(minutesLabel)
    timerLabelStackView.addArrangedSubview(minutesSignLabel)
    timerLabelStackView.addArrangedSubview(secondsLabel)
    timerLabelStackView.addArrangedSubview(secondsSignLabel)
 
    timerAndButtonStackView.addArrangedSubview(timerLabelStackView)
    timerAndButtonStackView.addArrangedSubview(buttonsStackView)
    
    view.addSubview(titleLabel)
    view.addSubview(timerAndButtonStackView)
    view.addSubview(currentRecordList)
    view.addSubview(recordList)
    view.addSubview(contractionAndRecordTab)
  }
  
  private func snpConstraints() {
    
    titleLabel.snp.makeConstraints { make in
      make.width.equalTo(view.snp.width)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
    
    timerAndButtonStackView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.width.equalTo(view.snp.width)
    }
    
    buttonsStackView.snp.makeConstraints { make in
      make.left.equalTo(timerAndButtonStackView.snp.left).offset(50)
      make.right.equalTo(timerAndButtonStackView.snp.right).offset(-50)
    }
    
    currentRecordList.snp.makeConstraints { make in
      make.top.equalTo(timerAndButtonStackView.snp.bottom).offset(15)
      make.width.equalTo(view.snp.width)
      make.bottom.equalTo(contractionAndRecordTab.snp.top)
    }
    
    recordList.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.left.equalTo(view.snp.left)
      make.right.equalTo(view.snp.right)
      make.bottom.equalTo(contractionAndRecordTab.snp.top)
    }
    
    contractionAndRecordTab.snp.makeConstraints { make in
      make.centerX.equalTo(view.snp.centerX)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(50)
      make.bottom.equalTo(-15 + -(self.tabBarController!.tabBar.frame.size.height))
    }
  }
  
  func tableViewsSetup() {
    recordList.delegate = self
    recordList.dataSource = self
    recordList.register(UITableViewCell.self, forCellReuseIdentifier: "savedRecordCell")
    currentRecordList.register(UITableViewCell.self, forCellReuseIdentifier: "currentRecordCell")
    currentRecordList.delegate = self
    currentRecordList.dataSource = self
    recordList.isHidden = true
  }

  func setStartTime(date: Date?){
    startTime = date
    userDefaults.set(startTime, forKey: START_TIME_KEY)
  }
  func setStopTime(date: Date?){
    stopTime = date
    userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
  }
  func setTimerCounting(_ val: Bool){
    timerCounting = val
    userDefaults.set(timerCounting, forKey: COUNTING_KEY)
  }
  
  @objc func startRestTimer() {
    if timerCounting {
      recordData()
      isContracting.toggle()
    } else {
      if let stop = stopTime {
        let restartTime = calcRestartTime(start: startTime!, stop: stop)
        setStopTime(date: nil)
        setStartTime(date: restartTime)
      } else {
        setStartTime(date: Date())
      }
      startTimer()
    }
  }
    
  func calcRestartTime(start: Date, stop: Date) -> Date {
    let diff = start.timeIntervalSince(stop)
      
    return Date().addingTimeInterval(diff)
  }
  
  func startTimer() {
    scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
    setTimerCounting(true)
    newRecord = contractions(contractionDate: Date(), contractionRecord: [])
    currentRecordList.reloadData()
    isContracting.toggle()
  }
  
  @objc func refreshValue(){
    if let start = startTime {
      let diff = Date().timeIntervalSince(start)
      setTimeLabel(Int(diff))
    } else {
      stopTimer()
      setTimeLabel(0)
    }
  }
  
  func setTimeLabel(_ val: Int){
    let time = secondsToMinutesSeconds(val)
    minutesLabel.text = String(format: "%02d", time.0)
    secondsLabel.text = String(format: "%02d", time.1)
    timerValue = makeTimeString(min: time.0, sec: time.1)
  }
  
  func secondsToMinutesSeconds(_ ms: Int) -> (Int, Int){
    let min = (ms % 3600) / 60
    let sec = (ms % 3600) % 60
    
    return (min, sec)
  }
  
  func makeTimeString(min: Int, sec: Int) -> String {
    var timeString  = ""
    timeString += String(format: "%02d", min)
    timeString += ":"
    timeString += String(format: "%02d", sec)
    return timeString
  
  }
  
  func recordData(){
    if timerCounting {
      newRecord?.contractionRecord?.append(details(state: currentRecordingTitle! == "Start" ? "Contracting" : currentRecordingTitle!, length: timerValue))
      currentRecordList.reloadData()
    } else {
      newRecord = nil
      newRecord = contractions(contractionDate: Date(), contractionRecord: [])
    }
    setStartTime(date: Date())
    minutesLabel.text = "00"
    secondsLabel.text = "00"
  }
  
  @objc func contractionAndRecordTabTapped() {
    inRecordsTab.toggle()
  }
  
  @objc func stopTimer(){
    if newRecord != nil {
      newRecord?.contractionRecord?.append(details(state: currentRecordingTitle! == "Start" ? "Contracting" : currentRecordingTitle!, length: timerValue))
      currentRecordList.reloadData()
      if userConstractionRecords != nil {
        userConstractionRecords?.append(newRecord!)
      } else {
        userConstractionRecords = [newRecord!]
      }
      recordList.reloadData()
    }
    if scheduledTimer != nil {
      scheduledTimer.invalidate()
    }
    resetTimer()
    setTimerCounting(false)
    isContracting = false
    startButton.setTitle("Start", for: .normal)
    startButton.backgroundColor = #colorLiteral(red: 0.9845016599, green: 0.3794513941, blue: 0.5343101621, alpha: 1)
  }

  @objc func resetTimer(){
    setStopTime(date: nil)
    setStartTime(date: nil)
    minutesLabel.text = "00"
    secondsLabel.text = "00"
  }
}

extension ContractionTimerViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    if tableView == recordList {
      return userConstractionRecords?.count ?? 0
    } else {
      return 1
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if tableView == currentRecordList {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      tableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
      return "Length"
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let header = view as? UITableViewHeaderFooterView {
      header.contentView.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.4588235294, blue: 0.968627451, alpha: 1)
      header.textLabel?.textColor = UIColor.white
      header.textLabel?.textAlignment = .center
      header.textLabel?.frame.size.width = view.safeAreaLayoutGuide.layoutFrame.width
    }
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if tableView == recordList {
      let currentCell = tableView.cellForRow(at: IndexPath(row: 0, section: indexPath.section))
      let currentCellisSelected = currentCell?.isSelected ?? false
      if currentCellisSelected && indexPath.row != 0 {
        return tableView.rowHeight
      } else if !currentCellisSelected && indexPath.row != 0 {
        return 0
      }
      return tableView.rowHeight
    } else {
      return tableView.rowHeight
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == recordList {
      if let rows = userConstractionRecords?[section].contractionRecord?.count {
        return rows + 1
      }
      return 0
    } else {
      return newRecord?.contractionRecord?.count ?? 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView == recordList {
      let cell =  UITableViewCell(style: .value1, reuseIdentifier: "savedRecordCell")
      if indexPath.row == 0 {
          let dateformatter = DateFormatter()
          dateformatter.dateFormat = "E, d MMM yyyy - HH:mm:ss"
          cell.textLabel?.text = dateformatter.string(from: userConstractionRecords![indexPath.section].contractionDate!)
        } else {
          
          let detailrows = indexPath.row - 1
          cell.textLabel?.text = userConstractionRecords?[indexPath.section].contractionRecord?[detailrows].state
          cell.detailTextLabel?.text = String((userConstractionRecords?[indexPath.section].contractionRecord?[detailrows].length)!)
            cell.backgroundColor = (indexPath.row % 2) == 0 ? .white : #colorLiteral(red: 0.9490194917, green: 0.9490197301, blue: 0.9533253312, alpha: 1)
        }
      cell.clipsToBounds = true
      return cell
    } else {
      let cell1 =  UITableViewCell(style: .value1, reuseIdentifier: "currentRecordCell")
      cell1.textLabel?.text = newRecord?.contractionRecord?[indexPath.row].state
      cell1.detailTextLabel?.text = String((newRecord?.contractionRecord?[indexPath.row].length)!)
      cell1.clipsToBounds = false
      return cell1
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print(userConstractionRecords!)
//    let currentCell = tableView.cellForRow(at: indexPath)
////    if currentCell!.isSelected {
////      currentCell?.isSelected = false
////      }
    guard tableView == recordList else { return }
    tableView.beginUpdates()
    tableView.endUpdates()
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      userConstractionRecords?.remove(at: indexPath.section)
      tableView.reloadData()
    }
  }
  
}
