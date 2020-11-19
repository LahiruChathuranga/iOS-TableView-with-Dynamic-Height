//
//  ViewController.swift
//  TBVSample
//
//  Created by Lahiru Chathuranga on 11/2/20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    
    // MARK: - Variables
    var infoArray: [String] = []
    let cellIdentifire = "InfoTVCell"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addTempData()
    }
    
    func addTempData() {
        let arraySize = 100
        
        for _ in 0..<arraySize {
            let str = randomString(length: 10)
            infoArray.append(str)
        }
        
        if infoArray.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            print(infoArray.count)
            self.heightCons.constant = CGFloat((self.infoArray.count * 50))
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pressedAdd(_ sender: Any) {
        
        let vc = CustomPickerVC(nibName: "CustomPickerVC", bundle: nil)
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
   
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? InfoTVCell {
            cell.textLabel?.text = infoArray[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}
extension ViewController {
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
extension ViewController: CustomPickerVCDelegate {
    func didSelectDateAndLanguage(month: String, year: String, language: String) {
        print("Month - \(month) Year - \(year) Language - \(language)")
    }
    
    
}
