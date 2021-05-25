//
//  ViewController.swift
//  selectQNA
//
//  Created by 羅承志 on 2021/5/19.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButton: [UIButton]!
    
    //問題array
    var questions = [Question]()
    //題目
    var index = 0
    //題數
    var count = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let question1 = Question(description: "皮卡丘", option: ["1", "10", "2", "9"], answer: "1")
        questions.append(question1)
        let question2 = Question(description: "蠟筆小新", option: ["8", "1", "7", "2"], answer: "2")
        questions.append(question2)
        let question3 = Question(description: "小小兵", option: ["6", "3", "5", "1"], answer: "3")
        questions.append(question3)
        let question4 = Question(description: "派大星", option: ["10", "1", "9", "4"], answer: "4")
        questions.append(question4)
        let question5 = Question(description: "章魚哥", option: ["5", "1", "9", "7"], answer: "5")
        questions.append(question5)
        let question6 = Question(description: "海綿寶寶", option: ["9", "2", "6", "10"], answer: "6")
        questions.append(question6)
        let question7 = Question(description: "史迪奇", option: ["5", "1", "9", "7"], answer: "7")
        questions.append(question7)
        let question8 = Question(description: "米奇", option: ["9", "2", "8", "4"], answer: "8")
        questions.append(question8)
        let question9 = Question(description: "米妮", option: ["9", "7", "5", "4"], answer: "9")
        questions.append(question9)
        let question10 = Question(description: "多啦A夢", option: ["7", "2", "10", "5"], answer: "10")
        questions.append(question10)
        //隨機出題
        questions.shuffle()
        
        startGame()
    }
    
    func startGame() {
    //option隨機
    questions[index].option.shuffle()
    //更改選擇題四個button圖片
    for i in 0...3{
        answerButton[i].setImage(UIImage(named: questions[index].option[i]), for: .normal)
    }
        progressLabel.text = "\(count)/10"
        questionLabel.text = questions[index].description
        progressSlider.value = Float(count)
        checkLabel.text = "選擇正確的卡通人物"
        checkLabel.textColor = UIColor.black
    }
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        //如點選圖片之Button與正確答案相同，將...
        if sender.currentImage == UIImage(named: questions[index].answer) {
            checkLabel.text = "答對！🥳🥳"
            checkLabel.textColor = UIColor.green
          //如點選圖片之Button與正確答案不相同，將...
        } else if sender.currentImage != UIImage(named: questions[index].answer) {
            checkLabel.text = "答錯！😈😈"
            checkLabel.textColor = UIColor.red
        }
    }
    
    @IBAction func speak(_ sender: UIButton) {
        var speechUtterance = AVSpeechUtterance()
        speechUtterance = AVSpeechUtterance(string: questionLabel.text!)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        speechUtterance.rate = 0.5
        speechUtterance.pitchMultiplier = 1
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        count += 1
        index += 1
        //當題數為10時，重新開始
        if count == 11 {
            count = 1
            index = 0
            //隨機出題
            questions.shuffle()
        }
        startGame()
    }
}

