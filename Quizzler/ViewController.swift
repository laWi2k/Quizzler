//
//  ViewController.swift
//  Quizzler
//
//  Created by Daniel on 11.07.2022.
//

import UIKit



class ViewController: UIViewController {
    
    var currentQuestions = QuestionsForQuiz.questions
    
    //MARK: creating things
    
    let buttonTrue = DNButton(title: "True")
    let buttonFalse = DNButton(title: "False")
    let questionText = DNLabel(contentText: "Question Text")
    let progressBar = DNProgressBar(xScale: 1, yScale: 5, progress: 0.5)
    let vStackView = UIStackView()
    var currentIndex: Int?
    
    
    @objc func updateUILabel() {
        
        
        guard let question = currentQuestions.randomElement(), !question.isUsedBefore else {return}
        
        questionText.text = question.question
        
        
        for index in 0..<currentQuestions.count{
            if currentQuestions[index].question == question.question {
                currentQuestions[index].isUsedBefore = true
                currentIndex = index
                //                print(currentQuestions.count)
                //                currentQuestions.remove(at: сurrentIndex)
            }
        }
    }
    
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
            progressBar,
        ])
        
        vStackView.spacing = 15
        vStackView.axis = .vertical
        vStackView.clipsToBounds = true
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        targeting()
        
    }
    
    //MARK: Setting constraints
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
    
    
    //MARK: Buttons
    @objc func keyFalsePressedDown(){
        buttonFalse.alpha = 0.5
        
    }
    
    @objc func keyFalsePressedUp(){
        buttonFalse.alpha = 1
        
        if "false" == currentQuestions[currentIndex!].correctAnswer.lowercased() /*&& !currentQuestions.isEmpty */{
            buttonTrue.backgroundColor = .white
            buttonFalse.backgroundColor = .white
            updateUILabel()
            //            currentQuestions.remove(at: currentIndex!)
        } else {
            buttonFalse.backgroundColor = .systemRed
        }
        
    }
    
    @objc func keyTruePressedDown(){
        buttonTrue.alpha = 0.5
        
    }
    
    @objc func keyTruePressedUp(){
        buttonTrue.alpha = 1
        if "true" == currentQuestions[currentIndex!].correctAnswer.lowercased() /*&& !currentQuestions.isEmpty */ {
            buttonTrue.backgroundColor = .white
            buttonFalse.backgroundColor = .white
            //            currentQuestions.remove(at: currentIndex!)
            _ = Timer(timeInterval: 0.5, target: self, selector: #selector(updateUILabel), userInfo: nil, repeats: true)
            updateUILabel()
        } else {
            buttonTrue.backgroundColor = .systemRed
        }
    }
}

