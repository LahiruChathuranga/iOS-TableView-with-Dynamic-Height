//
//  CustomPickerVC.swift
//  TBVSample
//
//  Created by Lahiru Chathuranga on 11/19/20.
//

import UIKit

protocol CustomPickerVCDelegate {
    func didSelectDateAndLanguage(month: String, year: String, language: String)
}

class CustomPickerVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageImage: UIImageView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    // MARK: - Variables
    let dropDown = MakeDropDown()
    var yearArray = [String]()
    var monthArray = [String]()
    var selectedLabel = UILabel()
    
    var dropDownRowHeight: CGFloat = 20
    var isDropped: Bool = false
    var delegate: CustomPickerVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setUpMonthGestures()
        setUpYearGestures()
        setUpLanguageGestures()
    }
    
    func setupUI() {
        [monthLabel, yearLabel, languageLabel].forEach { (lbl) in
            lbl?.layer.borderWidth = 1
            lbl?.layer.cornerRadius = 4
            lbl?.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        contentView.layer.cornerRadius = 6
        contentView.addShadowToView()
    }
    
    
    func setUpMonthGestures(){
        self.monthLabel.isUserInteractionEnabled = true
        let testLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(monthLabelTapped))
        self.monthLabel.addGestureRecognizer(testLabelTapGesture)
    }
    
    func setUpYearGestures(){
        self.yearLabel.isUserInteractionEnabled = true
        let testLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(yearLabelTapped))
        self.yearLabel.addGestureRecognizer(testLabelTapGesture)
    }
    
    func setUpLanguageGestures(){
        self.languageLabel.isUserInteractionEnabled = true
        let testLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(languageLabelTapped))
        self.languageLabel.addGestureRecognizer(testLabelTapGesture)
    }
    
    @objc func monthLabelTapped() {
        if isDropped {
            self.dropDown.hideDropDown()
            self.isDropped = false
        } else {
            self.selectedLabel = monthLabel
            self.isDropped = true
            self.setUpDropDown(selectedPosition: monthLabel)
            self.monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "November", "December"]
            self.dropDown.showDropDown(height: self.dropDownRowHeight * 5)
        }
        
    }
    
    @objc func yearLabelTapped() {
        
        if isDropped {
            self.dropDown.hideDropDown()
            self.isDropped = false
        } else {
            self.selectedLabel = yearLabel
            self.isDropped = true
            self.setUpDropDown(selectedPosition: yearLabel)
            self.monthArray = ["2018", "2019", "2020", "2021"]
            self.dropDown.showDropDown(height: self.dropDownRowHeight * 5)
        }
        
    }
    
    @objc func languageLabelTapped() {
        if isDropped {
            self.dropDown.hideDropDown()
            self.isDropped = false
        } else {
            self.selectedLabel = languageLabel
            self.isDropped = true
            self.setUpDropDown(selectedPosition: languageLabel)
            self.monthArray = ["Sinhala", "Tamil", "English"]
            self.dropDown.showDropDown(height: self.dropDownRowHeight * 5)
        }
    }
    
    func setUpDropDown(selectedPosition: UILabel){
        dropDown.makeDropDownIdentifier = "DROP_DOWN_NEW"
        dropDown.cellReusableIdentifier = "dropDownCell"
        dropDown.makeDropDownDataSourceProtocol = self
        dropDown.setUpDropDown(viewPositionReference: (selectedPosition.frame), offset: 2)
        dropDown.nib = UINib(nibName: "DropDownTableViewCell", bundle: nil)
        dropDown.setRowHeight(height: self.dropDownRowHeight)
        contentView.addSubview(dropDown)
    }
    
    @IBAction func pressedProceed(_ sender: Any) {
        
        if let month = monthLabel.text,
           let year = yearLabel.text,
           let language = languageLabel.text {
            self.delegate?.didSelectDateAndLanguage(month: month, year: year, language: language)
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Fill all the fields")
        }
        
    }
    
    @IBAction func pressedCancel(_ sender: Any) {
        
    }
    
}
extension CustomPickerVC: MakeDropDownDataSourceProtocol{
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, makeDropDownIdentifier: String) {
        if makeDropDownIdentifier == "DROP_DOWN_NEW"{
            let customCell = cell as! DropDownTableViewCell
            customCell.countryNameLabel.text = self.monthArray[indexPos]
            
        }
    }
    
    func numberOfRows(makeDropDownIdentifier: String) -> Int {
        return self.monthArray.count
    }
    
    func selectItemInDropDown(indexPos: Int, makeDropDownIdentifier: String) {
        self.selectedLabel.text = self.monthArray[indexPos]
        self.dropDown.hideDropDown()
        self.selectedLabel = UILabel()
        self.isDropped = false
    }
    
}
