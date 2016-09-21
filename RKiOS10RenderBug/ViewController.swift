//
//  ViewController.swift
//  RKiOS10RenderBug
//
//  Created by Dennis O'Reilly on 9/21/16.
//  Copyright © 2016 University of Michigan. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController, ORKTaskViewControllerDelegate {

    var seenYet: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !seenYet {
            seenYet = true
            self.startSurvey()
        }
    }

    @IBAction func startSurveyTapped(sender: AnyObject) {
        self.startSurvey()
    }
    
    func startSurvey() {
        let textEntryAnswerFormat = ORKAnswerFormat.textAnswerFormatWithValidationRegex("^[aAeEiIoOuUyY]$", invalidMessage: "Vowel only, please.")
        textEntryAnswerFormat.multipleLines = false
        let textStep = ORKQuestionStep(identifier: "VowelFreeText", title: "What is your favorite vowel?", text: "enter A, E, I, O, U, or maybe Y", answer: textEntryAnswerFormat)
        
        let pickerAnswerFormat = ORKAnswerFormat.valuePickerAnswerFormatWithTextChoices([
            ORKTextChoice(text: "A", value: "A"),
            ORKTextChoice(text: "E", value: "E"),
            ORKTextChoice(text: "I", value: "I"),
            ORKTextChoice(text: "O", value: "O"),
            ORKTextChoice(text: "U", value: "U"),
            ORKTextChoice(text: "Y", value: "Y"),
            ])
        let pickerStep = ORKQuestionStep(identifier: "VowelPicker", title: "What is your favorite vowel now?", answer: pickerAnswerFormat)
        
        let numericAnswerFormat = ORKAnswerFormat.integerAnswerFormatWithUnit("letters")
        numericAnswerFormat.minimum = 0
        numericAnswerFormat.maximum = 100
        let numericStep = ORKQuestionStep(identifier: "LetterCount", title: "How many letters are there in your alphabet?", answer: numericAnswerFormat)
        
        let completionStep = ORKCompletionStep(identifier: "Completion")
        
        let task = ORKOrderedTask(identifier: "Alphabet", steps: [textStep, pickerStep, numericStep, completionStep])
        
        let vc = ORKTaskViewController(task: task, taskRunUUID: nil)
        vc.delegate = self
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

