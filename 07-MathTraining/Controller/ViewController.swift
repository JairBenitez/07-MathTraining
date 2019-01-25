//
//  ViewController.swift
//  07-MathTraining
//
//  Created by Jair Benítez on 31/12/18.
//  Copyright © 2018 Jair Benítez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var drawigView: DrawingImage!
    
    let factory = QuestionsFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawigView.delegate = self
        
        title = "math Training"
        tableView.layer.borderColor = UIColor.blue.cgColor
        tableView.layer.borderWidth = 1
        
        
    }


    func numberDrawn(_ image: UIImage ) {
        askQuestion()
        
    
    }
    
    
    
    func askQuestion() {
        
        drawigView.image = nil
        
        factory.addNewQuestion()
        
        let newIndexPath = IndexPath( row: 0, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .right )
        
        let secondIndexPath = IndexPath( row: 1, section: 0)
        if let cell = tableView.cellForRow(at: secondIndexPath) {
            setText(for: cell, at: secondIndexPath, to: factory.getQuestionAt(position: 1)! )
        }
        
        
        
    }
    
    
    func setText( for cell: UITableViewCell, at indexPath: IndexPath, to question:Question ){
        if( indexPath.row == 0) {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18 )
        }
        
        if let userAnswer = question.userAnswer {
            cell.textLabel?.text = "\(question.text) = \(userAnswer)"
        } else {
            cell.textLabel?.text = "\(question.text) = ?"
        }
        
    }
    
    // - MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return factory.numberOfQuestions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let currentQuestion = factory.getQuestionAt(position: indexPath.row ) {
            setText(for: cell, at: indexPath, to: currentQuestion )
        }
        
        return cell
        
    }
    
    
    // - MARK Metodos de UITableDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

