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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Questions = [
            Question(Question: "Srimayi's last name is Erravelli.", Answers: ["Yes","No"], Answer: 0),
            Question(Question: "Srimayi's middle name is Soa.", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "Srimayi's mom's name is Sretaa.", Answers: ["Yes","No"], Answer: 1),
            Question(Question: "Srimayi's first name is Srimayi", Answers: ["Yes","No"], Answer: 0)
        ]
        
        randomQueston()
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
            NSLog("Questions Finsished!")
        }
    }
    
    func showEndAlert() {
        let alertController = UIAlertController(title: "You Did It!", message: "You completed the quiz with \(correct) correct and \(wrong) wrong!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Restart", style: .Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func isEnd() {
        if Questions.count == 0 {
            showEndAlert()
        }
    }
    
    func rightAnswer() {
        isEnd()
        let alertController = UIAlertController(title: "Correct!", message: "The Question You Answered is Correct!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Next", style: .Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
        randomQueston()
        correct += 1
        correctLabel.text = "\(correct)"
    }
    
    func wrongAnswer() {
        let alertController = UIAlertController(title: "Wrong!", message: "The Question You Answered is Wrong!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Next", style: .Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
        NSLog("Question Was Answered Wrong!")
        randomQueston()
        isEnd()
        wrong += 1
        wrongLabel.text = "\(wrong)"
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