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
    func showMoreQuestion(attributed: NSMutableAttributedString)
    func showDetailVocubulary(text: String)
    func showMoreResulr(result: String)
}

class CellExercise: UICollectionViewCell {
    
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    weak var delegate: CellExerciseDelegate?
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vQuestion: UIView!
    @IBOutlet weak var tbvNameExercise: UITableView!
    
    var attributed: NSMutableAttributedString?
    var answer: [ChildQuestionEntity] = []{
        didSet{
            self.listAnswer = answer.map{QuestionChoiceResultParam(question_id: Int($0._id&) ?? 0)}
            tbvNameExercise.reloadData()
        }
    }
    
    var numberLine: Int = 0
    let popover = Popover()
    var listAnswer : [QuestionChoiceResultParam] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        tvContent.textContainerInset = UIEdgeInsets.zero
        tvContent.textContainer.lineFragmentPadding = 0
        tbvNameExercise.registerXibFile(CellQuestion.self)
        tbvNameExercise.dataSource = self
        tbvNameExercise.delegate = self
    }
    
    func setupCell(dataCell: QuestionEntity){
        DispatchQueue.main.async {
            self.detectQuestion(contextQuestion: dataCell.content_extend&)
            self.answer = dataCell.answers ?? []
            
        }
    }
    
    func detectQuestion(contextQuestion: String){
        let  textArray = contextQuestion.components(separatedBy: " ")
        let attributedText = NSMutableAttributedString()
        for word in textArray {
            let attributed = NSMutableAttributedString(string: word + " ")
            let range = NSRange(location: 0, length: word.count)
            let myCustomAttributed = [ NSAttributedString.Key.init(rawValue: "tapped"):word, NSAttributedString.Key.font : AppFont.fontRegular14] as [NSAttributedString.Key : Any]
            attributed.addAttributes(myCustomAttributed, range: range)
            attributedText.append(attributed)
        }
        self.attributed = attributedText
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
        aView.btnDetail.addTarget(self, action: #selector(clickDetail), for: .touchUpInside)
        aView.setTitle(title: title)
        popover.blackOverlayColor = .clear
        popover.popoverColor = .white
        popover.addShadow(ofColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), opacity: 1)
        popover.layer.cornerRadius = 5
        popover.show(aView, point: point, inView: self.contentView)
    }
    @objc func clickDetail(){
        delegate?.showDetailVocubulary(text: "")
    }
}
extension CellExercise : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CellExercise: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellQuestion.self, for: indexPath)
        cell.indexPath = indexPath
        if let listAnswer = self.getDataSource(indexPath: indexPath), let option = self.getIdOption(indexPath: indexPath){
            cell.idOption = option
            cell.dataSource = listAnswer
        }
        cell.delegate = self
        heightTableView.constant = tbvNameExercise.contentSize.height
        return cell
    }
    
    func getDataSource(indexPath: IndexPath) -> [String]? {
        return self.answer[indexPath.row].options?.map{$0.value}.compactMap{$0}
    }
    func getIdOption(indexPath: IndexPath) -> [Int]?{
        return self.answer[indexPath.row].options?.map{Int($0._id ?? "0")}.compactMap{$0}
    }
}

extension CellExercise : ClickQuestionDelegate{
    func changeAnswer(id: Int, indexPath: IndexPath?) {
        if let _indexPath = indexPath {
            self.listAnswer[_indexPath.row].option_id = id
        }
    }
}
