//
//  ContractionTimerViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-15.
//

import UIKit
import SnapKit

class ContractionTimerViewController: UIViewController {
  
  var userConstractionRecords : [contractions]?
  var newRecord: contractions?
  
  var todaysRecord = [[String]]()
  var timerCounting: Bool = false
  var isContracting: Bool = false {
    didSet {
      if timerCounting {
      currentRecordingTitle = startButton.currentTitle
      if isContracting {
      startButton.setTitle("Rest", for: .normal)
      startButton.backgroundColor = #colorLiteral(red: 0.3890488148, green: 0.8415637016, blue: 0.7544795871, alpha: 1)
      } else { startButton.setTitle("Start", for: .normal)
      startButton.backgroundColor = #colorLiteral(red: 0.9845016599, green: 0.3794513941, blue: 0.5343101621, alpha: 1)
      }
      }
    }
  }
  
  var currentRecordingTitle: String?
  var currentRecordingTime: String?
  
  var startTime: Date?
  var stopTime: Date?
  
  let userDefaults = UserDefaults.standard
  
  var START_TIME_KEY = "startTime"
  var STOP_TIME_KEY = "stopTime"
  var COUNTING_KEY = "countingKey"
  var scheduledTimer: Timer!
  
  var timerTabButton : UIButton = {
    let button = UIButton()
    button.setTitle("Contraction", for: .normal)
    button.layer.cornerRadius = 20
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.9459111094, green: 0.9379461408, blue: 0.9782511592, alpha: 1)
    button.addTarget(self, action: #selector(timerTabButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  var recordTabButton : UIButton = {
    let button = UIButton()
    button.setTitle("Records", for: .normal)
    button.layer.cornerRadius = 20
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    button.addTarget(self, action: #selector(recordTabButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  var timerAndRecordNavBarStackView : UIStackView = {
    let stackview = UIStackView()
    stackview.axis = .horizontal
    stackview.distribution = .fillEqually
    stackview.alignment = .center
    stackview.spacing = 10
    
    return stackview
  }()
  
  var buttonsStackView : UIStackView = {
    let buttonsStackView = UIStackView()
    buttonsStackView.axis = .horizontal
    buttonsStackView.distribution = .fillEqually
    buttonsStackView.alignment = .center
    buttonsStackView.spacing = 10
    return buttonsStackView
  }()

  var titleLabel : UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = """
          Contraction
          Timer
          """
    titleLabel.font = UIFont(name: "SimpleBoy", size: 50)
    titleLabel.textColor = #colorLiteral(red: 0.9926157594, green: 0.3876789808, blue: 0.5335384011, alpha: 1)
    titleLabel.numberOfLines = 2
    titleLabel.setLineSpacing(lineSpacing: 1, lineHeightMultiple: 0.5)
    
    return titleLabel
  }()
  
  var timerLabel : UILabel = {
    let timerLabel = UILabel()
    timerLabel.text = "00:00"
    timerLabel.textAlignment = .center
    timerLabel.font = .boldSystemFont(ofSize: 50)
    
    return timerLabel
  }()
  
  var startButton : UIButton = {
    let startButton = UIButton()
    startButton.setTitle("Start", for: .normal)
    startButton.backgroundColor = #colorLiteral(red: 0.9845016599, green: 0.3794513941, blue: 0.5343101621, alpha: 1)
    startButton.layer.cornerRadius = 20
      
    return startButton
  }()

  var stopButton : UIButton = {
    let stopButton = UIButton()
    stopButton.setTitle("Stop", for: .normal)
    stopButton.backgroundColor = #colorLiteral(red: 0.9882352948, green: 0.9882352948, blue: 0.9882352948, alpha: 1)
    stopButton.setTitleColor(.black, for: .normal)
    stopButton.layer.cornerRadius = 20
    
    return stopButton
  }()
  
  var timerAndButtonStackView : UIStackView = {
    let timerAndButtonStackView = UIStackView()
    timerAndButtonStackView.axis = .vertical
    timerAndButtonStackView.distribution = .fillEqually
    timerAndButtonStackView.alignment = .center
    //timerAndButtonStackView.backgroundColor = #colorLiteral(red: 0.9976026416, green: 0.9432250857, blue: 0.9571509957, alpha: 1)
    
    return timerAndButtonStackView
  }()
  
  var recordList : UITableView = {
    let recordList = UITableView()
    recordList.isHidden = true
    return recordList
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.8832569771, alpha: 1)
    
    addSubview()
    snpConstraints()
    
    recordList.delegate = self
    recordList.dataSource = self
    recordList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
    stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
    timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
    
    startButton.addTarget(self, action: #selector(startRestTimer), for: .touchUpInside)
    
    stopButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
    
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
  }
  
  func addSubview(){
    timerAndRecordNavBarStackView.addArrangedSubview(timerTabButton)
    timerAndRecordNavBarStackView.addArrangedSubview(recordTabButton)
    buttonsStackView.addArrangedSubview(startButton)
    buttonsStackView.addArrangedSubview(stopButton)
    timerAndButtonStackView.addArrangedSubview(titleLabel)
    timerAndButtonStackView.addArrangedSubview(timerLabel)
    timerAndButtonStackView.addArrangedSubview(buttonsStackView)
    view.addSubview(timerAndRecordNavBarStackView)
    view.addSubview(recordList)
    view.addSubview(timerAndButtonStackView)
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
    let timeString = makeTimeString(min: time.0, sec: time.1)
    timerLabel.text = timeString
  }
  
  func secondsToMinutesSeconds(_ ms: Int) -> (Int, Int){
    let min = (ms % 3600) / 60
    let sec = (ms % 3600) % 60
    
    return (min, sec)
  }
  
  func makeTimeString(min: Int, sec: Int) -> String{
    var timeString  = ""
    timeString += String(format: "%02d", min)
    timeString += ":"
    timeString += String(format: "%02d", sec)
    
    return timeString
  
  }
  
  func recordData(){
    if timerCounting {
      newRecord?.contractionRecord?.append(details(state: currentRecordingTitle!, length: timerLabel.text!))
    } else {
      newRecord = nil
      newRecord = contractions(contractionDate: Date(), contractionRecord: [])
    }
    setStartTime(date: Date())
    timerLabel.text = makeTimeString(min: 0, sec: 0)
  }
  
  func stopTimer(){
    if newRecord != nil {
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
    timerLabel.text = makeTimeString(min: 0, sec: 0)
  }
  
  @objc func timerTabButtonTapped(){
    timerTabButton.isEnabled = false
    recordTabButton.isEnabled = true
    timerAndButtonStackView.isHidden = false
    recordList.isHidden = true
  }
  
  @objc func recordTabButtonTapped(){
    recordTabButton.isEnabled = false
    timerTabButton.isEnabled = true
    recordList.isHidden = false
    timerAndButtonStackView.isHidden = true
  }
  
  private func snpConstraints() {
    timerAndButtonStackView.snp.makeConstraints{ (make) -> Void in
      make.top.equalTo(timerAndRecordNavBarStackView.snp.bottom)
      make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width)
      make.bottom.equalTo(0).offset(-50)
    }
    
    titleLabel.snp.makeConstraints{(make) -> Void in
      make.width.equalTo(timerAndButtonStackView.snp.width)
    }
    
    timerLabel.snp.makeConstraints{(make) -> Void in
      make.top.equalTo(titleLabel.snp.bottom)
      make.width.equalTo(timerAndButtonStackView.snp.width)
      make.height.equalTo(80)
    }
    
    buttonsStackView.snp.makeConstraints{(make) -> Void in
      make.left.equalTo(timerAndButtonStackView.snp.left).offset(50)
      make.right.equalTo(timerAndButtonStackView.snp.right).offset(-50)
      make.height.equalTo(80)
    }
    
    recordList.snp.makeConstraints{(make) -> Void in
      make.top.equalTo(timerAndRecordNavBarStackView.snp.bottom)
      make.left.equalTo(view.snp.left)
      make.right.equalTo(view.snp.right)
      make.bottom.equalTo(view.snp.bottom)
    }
    
    timerTabButton.snp.makeConstraints { make in
    make.height.equalTo(60)
    }
    
    timerAndRecordNavBarStackView.snp.makeConstraints { make in
    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
    make.left.equalTo(0).offset(50)
    make.right.equalTo(0).offset(-50)
    make.height.equalTo(30)
    }
  }
}


extension ContractionTimerViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return userConstractionRecords?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let currentCell = tableView.cellForRow(at: IndexPath(row: 0, section: indexPath.section))
    let currentCellisSelected = currentCell?.isSelected ?? false
    
    if currentCellisSelected && indexPath.row != 0 {
      return tableView.rowHeight
    } else if !currentCellisSelected && indexPath.row != 0 {
      return 0
    }
    
    return tableView.rowHeight
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let rows = userConstractionRecords?[section].contractionRecord?.count {
    return rows + 1
    }
  return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =  UITableViewCell(style: .value1, reuseIdentifier: "cell")
    if indexPath.row == 0 {
      let dateformatter = DateFormatter()
      dateformatter.dateFormat = "E, d MMM yyyy - HH:mm:ss"
      cell.textLabel?.text = dateformatter.string(from: userConstractionRecords![indexPath.section].contractionDate!)
    } else {
      let detailrows = indexPath.row - 1
      cell.textLabel?.text = userConstractionRecords?[indexPath.section].contractionRecord?[detailrows].state
      cell.detailTextLabel?.text = String(userConstractionRecords?[indexPath.section].contractionRecord?[detailrows].length ?? "1")
        cell.backgroundColor = (indexPath.row % 2) == 0 ? .white : #colorLiteral(red: 0.9490194917, green: 0.9490197301, blue: 0.9533253312, alpha: 1)
    }
    cell.clipsToBounds = true
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(userConstractionRecords!)
    let currentCell = tableView.cellForRow(at: indexPath)
//    if currentCell!.isSelected {
//      currentCell?.isSelected = false
//      }
      tableView.beginUpdates()
      tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      print(indexPath.section)
      userConstractionRecords?.remove(at: indexPath.section)
      tableView.reloadData()
    }
  }
}
