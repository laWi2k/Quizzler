//
//  ViewController.swift
//  Quizzler
//
//  Created by Daniel on 11.07.2022.
//

import UIKit



class ViewController: UIViewController {
    
    let buttonTrue = DNButton(title: "True")
    let buttonFalse = DNButton(title: "False")
    let questionText = DNLabel(contentText: "Question Text")
    let progressBar = DNProgressBar(xScale: 1, yScale: 5)
    let vStackView = UIStackView()
    
    var currentIndex: Int?
    var counter = 0
    var finished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(vStackView)
        constraints()
        updateUILabel()
        
        vStackView.addArrangedSubviews([
            questionText,
            buttonTrue,
            buttonFalse,
            progressBar,])
        
        stackSettings()
        targeting()
    }
    
    //MARK: - Question logic
    @objc func updateUILabel() {
        
        currentIndex = Int.random(in: 0..<QuestionsForQuiz.questions.count)
        
        if counter == QuestionsForQuiz.questions.count {
            questionText.font = .boldSystemFont(ofSize: 55)
            questionText.text = "That's it for today!"
        }
        
        let question = QuestionsForQuiz.questions[currentIndex!]
        if !question.isUsedBefore {
            QuestionsForQuiz.questions[currentIndex!].isUsedBefore = true
            counter += 1
            questionText.text = question.question
            print(currentIndex as Any)
            print(questionText.text as Any)
            print(question.correctAnswer)
        } else if finished {
            questionText.font = .boldSystemFont(ofSize: 55)
            questionText.text = "That's it for today!"
        }
    }
    
    //MARK: - Button logic
    @objc func keyFalsePressedDown(){
        buttonFalse.alpha = 0.5
        
    }
    
    @objc func keyFalsePressedUp(){
        buttonFalse.alpha = 1
        
        if "false" == QuestionsForQuiz.questions[currentIndex!].correctAnswer.lowercased() && !finished{
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUILabel), userInfo: nil, repeats: false)
            progressBar.progress = Float(counter) / Float(QuestionsForQuiz.questions.count)
            buttonTrue.backgroundColor = .white
            buttonFalse.backgroundColor = .white
        } else if finished {
            buttonTrue.isHidden = true
            buttonFalse.isHidden = true
            progressBar.isHidden = true
        } else if "false" != QuestionsForQuiz.questions[currentIndex!].correctAnswer.lowercased() && !finished{
            buttonFalse.backgroundColor = .systemRed
        }
        
    }
    
    @objc func keyTruePressedDown(){
        buttonTrue.alpha = 0.5
        
    }
    
    @objc func keyTruePressedUp(){
        buttonTrue.alpha = 1
        if "true" == QuestionsForQuiz.questions[currentIndex!].correctAnswer.lowercased() && !finished {
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUILabel), userInfo: nil, repeats: false)
            progressBar.progress = Float(counter) / Float(QuestionsForQuiz.questions.count)
            buttonTrue.backgroundColor = .white
            buttonFalse.backgroundColor = .white
        } else if finished {
            buttonTrue.isHidden = true
            buttonFalse.isHidden = true
            progressBar.isHidden = true
        } else if "true" != QuestionsForQuiz.questions[currentIndex!].correctAnswer.lowercased() && !finished {
            buttonTrue.backgroundColor = .systemRed
        }
    }
    
    //MARK: -Setting up everything
    func constraints(){
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func targeting() {
        buttonTrue.addTarget(self, action: #selector(keyTruePressedDown), for: .touchDown)
        buttonTrue.addTarget(self, action: #selector(keyTruePressedUp), for: .touchUpInside)
        buttonFalse.addTarget(self, action: #selector(keyFalsePressedDown), for: .touchDown)
        buttonFalse.addTarget(self, action: #selector(keyFalsePressedUp), for: .touchUpInside)
    }
    
    func stackSettings() {
        vStackView.spacing = 20
        vStackView.axis = .vertical
        vStackView.clipsToBounds = true
        vStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

