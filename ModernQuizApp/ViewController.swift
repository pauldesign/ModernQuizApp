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
        static var alternateQuestion = [
            Question(Question: "Start No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "No", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "End Yes", Answers: ["Yes","No"], Answer: 0)
        ]}
    
    var questNum = alternateQuestions.alternateQuestion.count - 1
    
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
        
        print(questNum)
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
    
    func restart() {
        for i in 0...questNum {
            Questions.append(alternateQuestions.alternateQuestion[i])
        }
        correct = 0
        wrong = 0
        correctLabel.text = "\(correct)"
        wrongLabel.text = "\(wrong)"
    }
    
    func isEnd() {
        if Questions.count == 0 {
            showEndAlert()
        }
    }
    
    func showEndAlert() {
        let alertController = UIAlertController(title: "Questions Completed!", message: "You completed the quiz with \(correct) correct and \(wrong) wrong. Click restart to retry the quiz.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Restart", style: .Default, handler: nil)
        let action2 = UIAlertAction(title: "Next Level", style: .Default, handler: nil)
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