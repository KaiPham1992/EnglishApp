//
//  CellExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Popover

protocol CellExerciseDelegate: class {
    func showMoreQuestion(text: String)
}

class CellExercise: UICollectionViewCell {
    
    @IBAction func showMoreQuestion(_ sender: Any) {
        delegate?.showMoreQuestion(text: tvContent.text)
    }
    
    //    @IBAction func clickMore(_ sender: Any) {
    //        if isShowMore {
    //            btnMore.setTitle("An bot", for: .normal)
    //            UIView.animate(withDuration: 0.1) {
    //                self.heightTVContent.constant = AppFont.fontRegular14.lineHeight * CGFloat(self.numberLine) + 16
    //                self.heightScrollView.constant = self.vProfile.frame.size.height + self.heightTB + 20
    //                self.view.layoutIfNeeded()
    //            }
    //        } else {
    //            btnMore.setTitle("Xem them", for: .normal)
    //            UIView.animate(withDuration: 0.1) {
    //                self.heightTVContent.constant = AppFont.fontRegular14.lineHeight * 8 + 16
    //                self.heightScrollView.constant = self.vProfile.frame.size.height + self.heightTB + 20
    //                self.view.layoutIfNeeded()
    //            }
    //        }
    //        self.isShowMore = !isShowMore
    //    }
    
    weak var delegate: CellExerciseDelegate?
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vQuestion: UIView!
    @IBOutlet weak var tbvNameExercise: UITableView!
    @IBOutlet weak var heightTVContent: NSLayoutConstraint!
    @IBOutlet weak var heightVBlur: NSLayoutConstraint!
    @IBOutlet weak var vBlur: ViewGradient!
    
    
    var numberLine: Int = 0
    let listQuestion : [String] = ["dasghdasjkdhasjdhasjdasjdhasdhasjkdhajksdhajskdhajks","czxnbcnmxzbcxzbcnxzbcmnzxbcmnzxbcmnzbczmnbcmnzxbcmznxbcmnxz","1","4","5","6","dasghdasjkdhasjdhasjdasjdhasdhasjkdhajksdhajskdhajks","czxnbcnmxzbcxzbcnxzbcmnzxbcmnzxbcmnzbczmnbcmnzxbcmznxbcmnxz","1","4","5","6","dasghdasjkdhasjdhasjdasjdhasdhasjkdhajksdhajskdhajks","czxnbcnmxzbcxzbcnxzbcmnzxbcmnzxbcmnzbczmnbcmnzxbcmznxbcmnxz","1","4","5","6"]
     let popover = Popover()
    
    
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    var listSelect : [Bool] = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        heightTVContent.constant = AppFont.fontRegular14.lineHeight * 8 + 16
        tvContent.textContainerInset = UIEdgeInsets.zero
        tvContent.textContainer.lineFragmentPadding = 0
        vBlur.setupThreeGradient(beginColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), centerColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.74), endColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        tbvNameExercise.registerXibFile(CellQuestion.self)
        tbvNameExercise.dataSource = self
        tbvNameExercise.delegate = self
        detectQuestion()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            let number = "In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life.In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life".getHeightLabel(width: self.tvContent.frame.width, font: AppFont.fontRegular14)
            self.numberLine = Int(number)
            if number > 8 {
                self.heightVBlur.constant = 100
            } else {
                self.heightVBlur.constant = 0
            }
        }
        
    }
    
    func detectQuestion(){
        let question = "In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life.In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life"
        let  textArray = question.components(separatedBy: " ")
        let attributedText = NSMutableAttributedString()
        for word in textArray {
            let attributed = NSMutableAttributedString(string: word + " ")
            let range = NSRange(location: 0, length: word.count)
            let myCustomAttributed = [ NSAttributedString.Key.init(rawValue: "tapped"):word, NSAttributedString.Key.font : AppFont.fontRegular14] as [NSAttributedString.Key : Any]
            attributed.addAttributes(myCustomAttributed, range: range)
            attributedText.append(attributed)
        }
        tvContent.attributedText = attributedText
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let content = sender.view as! UITextView
        let layoutManager = content.layoutManager
        var location = sender.location(in: content)
        
        location.x -= content.contentInset.left
        location.y -= content.contentInset.top
        
        print(location.x)
        print(location.y)
        let characterIndex  = layoutManager.characterIndex(for: location, in: content.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        if characterIndex < content.textStorage.length {
            print("Your character is at index: \(characterIndex)")
            let myRange = NSRange(location: characterIndex, length: 1)
            let subString = (content.attributedText.string as NSString).substring(with: myRange)
            print("character at index: \(subString)")
            let attributeName = "tapped" //make sure this matches the name in viewDidLoad()
            let attributeValue = content.attributedText!.attribute(NSAttributedString.Key("tapped"), at: characterIndex, effectiveRange: nil) as? String
            if let value = attributeValue {
                setupPopOver(x: sender.location(in: content).x, y: sender.location(in: content).y + AppFont.fontRegular14.lineHeight / 2, title: value)
                print("You tapped on \(attributeName) and the value is: \(value)")
            }
        }
    }
    
    func setupPopOver(x:CGFloat, y: CGFloat,title: String){
        popover.removeFromSuperview()
        let point = tvContent.convert(CGPoint(x: x, y: y), to: self.contentView)
        let aView = SearchVocabularyView(frame: CGRect(x: 0, y: 0, width: 200, height: 85))
        aView.setTitle(title: title)
        popover.blackOverlayColor = .clear
        popover.popoverColor = .white
        popover.addShadow(ofColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), opacity: 1)
        popover.layer.cornerRadius = 5
        popover.show(aView, point: point, inView: self.contentView)
    }
}
extension CellExercise : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show popup suggestion result
        //        PopUpHelper.shared.showSuggesstionResult(diamond: {
        //
        //        }) {
        //
        //        }
        //show pop update account
        //        PopUpHelper.shared.showUpdateAccount {
        //
        //        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension CellExercise: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellQuestion.self, for: indexPath)
        cell.setupData(title: listQuestion[indexPath.row])
        cell.indexPath = indexPath
        cell.isSelect = listSelect[indexPath.row]
        cell.delegate = self
        heightScrollView.constant = vQuestion.frame.height + tbvNameExercise.contentSize.height
        return cell
    }
}

extension CellExercise : ClickQuestionDelegate{
    func clickQuestion(indexPath: IndexPath?, isSelect: Bool) {
        self.listSelect[indexPath?.row ?? 0] = isSelect
    }
}
