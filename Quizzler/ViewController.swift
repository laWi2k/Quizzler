//
//  ViewController.swift
//  Quizzler
//
//  Created by Daniel on 11.07.2022.
//

import UIKit


//extedning StackView so it can add multiple subviews
extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { view in
            addArrangedSubview(view)
        }
    }
}


struct QuestionsForQuiz {
    var question: String
    var correctAnswer: String
    var isUsedBefore: Bool
    
    static var questions = [QuestionsForQuiz(question: "There are 4 Maxwell's equations, right?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Is Russia the biggest country?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Did Max Verstappen win the 2021 FIA F1 Championship?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Did Rayan Gosling die at the end of 'Drive'?", correctAnswer: "false", isUsedBefore: false),
                            QuestionsForQuiz(question: "Did Red Bull win the 2021 FIA F1 Constructors Championship?", correctAnswer: "false", isUsedBefore: false),
                            QuestionsForQuiz(question: "Am i gonna be an iOS developer?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Is Moscow the capital of Russia?", correctAnswer: "true", isUsedBefore: false)]
}


class ViewController: UIViewController {
    
    var currentQuestions = QuestionsForQuiz.questions
    
    //MARK: creating things
    
    let buttonTrue = DNButton(title: "True")
    let buttonFalse = DNButton(title: "False")
    
    let labelView: UILabel = {
        let questionLabel = UILabel()
        questionLabel.text = "Question Text"
        questionLabel.textColor = .black
        questionLabel.textAlignment = .center
        questionLabel.font = .boldSystemFont(ofSize: 25)
        questionLabel.layer.cornerRadius = 16
        questionLabel.numberOfLines = 0
        return questionLabel
    }()
    
    let progressView: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.setProgress(0.5, animated: true)
        progressBar.trackTintColor = .white
        progressBar.tintColor = .black
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 5)
        //        progressBar.layer.cornerRadius = 10
        return progressBar
    }()
    
    let vStackView = UIStackView()
    
    var currentIndex: Int?
    
    
    @objc func updateUILabel() {
        
        guard let question = currentQuestions.randomElement(), !question.isUsedBefore else {return}
        
        labelView.text = question.question
        
        
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
            labelView,
            buttonTrue,
            buttonFalse,
            progressView,
            
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
    
    func targeting() {
        buttonTrue.addTarget(self, action: #selector(keyTruePressedDown), for: .touchDown)
        buttonTrue.addTarget(self, action: #selector(keyTruePressedUp), for: .touchUpInside)
        buttonFalse.addTarget(self, action: #selector(keyFalsePressedDown), for: .touchDown)
        buttonFalse.addTarget(self, action: #selector(keyFalsePressedUp), for: .touchUpInside)
    }
    
}

