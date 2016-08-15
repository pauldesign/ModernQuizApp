//
//  ViewController.swift
//  ModernQuizApp
//
//  Created by Paul Maxeiner on 8/11/16.
//  Copyright © 2016 Paul Maxeiner. All rights reserved.
//

import UIKit

struct Question {
    var Question : String!
    var Answers : [String]!
    var Answer : Int!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!

    
    var Questions = [Question]()
    
    var QNumber = Int()
    
    var AnswerNumber = Int()
    
    var correct = Int()
    
    var wrong = Int()
    
    struct alternateQuestions {
        static var lv1 = [
            Question(Question: "Start No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "End Yes", Answers: ["Yes","No"], Answer: 0)
        ]
        static var lv2 = [
            Question(Question: "Start No2", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No2", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No2", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "End Yes2", Answers: ["Yes","No"], Answer: 0)
        ]
        static var lv3 = [
            Question(Question: "Start No3", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No3", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No3", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "End Yes3", Answers: ["Yes","No"], Answer: 0)
        ]
    }
    
    var lv1questNum = alternateQuestions.lv1.count - 1
    var lv2questNum = alternateQuestions.lv2.count - 1
    var lv3questNum = alternateQuestions.lv3.count - 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        Questions = [
            Question(Question: "Start No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "End Yes", Answers: ["Yes","No"], Answer: 0)
        ]
        
        randomQueston()
        
        print(lv1questNum)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomQueston() {
        if Questions.count > 0 {
            QNumber = random() % Questions.count
            questionLabel.text = Questions[QNumber].Question
            
            AnswerNumber = Questions[QNumber].Answer
            
            for i in 0..<Buttons.count {
                Buttons[i].setTitle(Questions[QNumber].Answers[i], forState: UIControlState.Normal)
            }
            
            Questions.removeAtIndex(QNumber)
        } else {
            
        }
    }
    
    func restartScore() {
        correct = 0
        wrong = 0
        correctLabel.text = "\(correct)"
        wrongLabel.text = "\(wrong)"
    }
    
    func restartlv1() {
        for i in 0...lv1questNum {
            Questions.append(alternateQuestions.lv1[i])
        }
        restartScore()
    }
    func restartlv2() {
        for i in 0...lv2questNum {
            Questions.append(alternateQuestions.lv2[i])
        }
        restartScore()
    }
    func restartlv3() {
        for i in 0...lv2questNum {
            Questions.append(alternateQuestions.lv3[i])
        }
        restartScore()
    }
    
    func isEnd() {
        if Questions.count == 0 {
            showEndAlertlv1()
        }
    }
    
    func exit(Sender: UIButton!) {
        let mainVC: MainScreenViewController = MainScreenViewController(nibName: nil, bundle: nil)
        
        self.presentViewController(mainVC, animated: true, completion: nil)
        
    }
    
    func showEndAlertlv1() {
        let alertController = UIAlertController(title: "Questions Completed!", message: "You completed the quiz with \(correct) correct and \(wrong) wrong. Click restart to retry the quiz.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Restart", style: .Default) {
            UIAlertAction in
            self.restartlv1()
        }
        let action2 = UIAlertAction(title: "Next Level", style: .Default) {
            UIAlertAction in
            self.restartlv2()
        }
        alertController.addAction(action)
        alertController.addAction(action2)
        presentViewController(alertController, animated: true, completion: nil)
        randomQueston()
    }
    func showEndAlertlv2() {
        let alertController = UIAlertController(title: "Questions Completed!", message: "You completed the quiz with \(correct) correct and \(wrong) wrong. Click restart to retry the quiz.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Restart", style: .Default) {
            UIAlertAction in
            self.restartlv2()
        }
        let action2 = UIAlertAction(title: "Next Level", style: .Default) {
            UIAlertAction in
            self.restartlv3()
        }
        alertController.addAction(action)
        alertController.addAction(action2)
        presentViewController(alertController, animated: true, completion: nil)
        randomQueston()
    }
    func showEndAlertlv3() {
        let alertController = UIAlertController(title: "Questions Completed!", message: "You completed the quiz with \(correct) correct and \(wrong) wrong. Click restart to retry the quiz.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Restart", style: .Default) {
            UIAlertAction in
            self.restartlv3()
        }
        let action2 = UIAlertAction(title: "Exit", style: .Default) {
            UIAlertAction in
            self.exit(.None)
        }
        alertController.addAction(action)
        alertController.addAction(action2)
        presentViewController(alertController, animated: true, completion: nil)
        randomQueston()
        
    }
    
    func rightAnswer() {
        correct += 1
        correctLabel.text = "\(correct)"
        isEnd()
            let alertController = UIAlertController(title: "Correct", message: "You got it right!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Next", style: .Default, handler: nil)
                alertController.addAction(action)
                presentViewController(alertController, animated: true, completion: nil)
        randomQueston()
    }
    
    func wrongAnswer() {
        wrong += 1
        wrongLabel.text = "\(wrong)"
        isEnd()
            let alertController = UIAlertController(title: "Wrong", message: "You got it wrong!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Next", style: .Default, handler: nil)
                alertController.addAction(action)
                presentViewController(alertController, animated: true, completion: nil)
        randomQueston()
    }
    
    @IBAction func yes(sender: AnyObject) {
        if AnswerNumber == 0 {
            rightAnswer()
        } else {
            wrongAnswer()
        }

    }
    
    @IBAction func no(sender: AnyObject) {
        if AnswerNumber == 1 {
            rightAnswer()
        } else {
            wrongAnswer()
        }

    }
    
}