//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Wilson Shakya on 01/05/21.
//

import Foundation
import UIKit
import Combine

class ResultViewController: UIViewController {
    
    let viewModel = ResultViewModel(coreDataManager: CoreDataManager())
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        linkPublishers()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setupTable() {
        tableView.tableFooterView = .init()
        tableView.alwaysBounceVertical = false
        tableView.contentInset = .zero
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "OptionCell", bundle: nil), forCellReuseIdentifier: OptionCell.identifier)
        tableView.register(UINib(nibName: "SimpleQuestionSection", bundle: nil), forCellReuseIdentifier: SimpleQuestionSection.identifier)
        tableView.register(UINib(nibName: "ImageQuestionSection", bundle: nil), forCellReuseIdentifier: ImageQuestionSection.identifier)
        tableView.register(UINib(nibName: "AudioQuestionSection", bundle: nil), forCellReuseIdentifier: AudioQuestionSection.identifier)
        tableView.register(UINib(nibName: "VideoQuestionSection", bundle: nil), forCellReuseIdentifier: VideoQuestionSection.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAnswers()
    }
    
    func linkPublishers (){
        viewModel
            .$currentQuestion
            .receive(on: RunLoop.main)
            .sink { (question) in
                self.updateUI()
            }.store(in: &cancellables)
    }
    
    func updateUI () {
        if  (viewModel.currentQuestion != nil) {
            btnNext.isHidden = viewModel.answerCounter == viewModel.answers.count-1
            tableView.reloadData()
        }
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        viewModel.nextQuestion()
    }
    
}

extension ResultViewController : UITableViewDelegate,  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _currentQuestion = viewModel.currentQuestion else {return 0}
        return _currentQuestion.options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as! OptionCell
        let _option = viewModel.currentQuestion.options[indexPath.row]
        cell.option = _option
        let isCorrect = viewModel.currentQuestion.correctAnswers.contains(_option)
        let isSubmitted = viewModel.selectedOption.contains(_option)
        cell.showResult(isCorrectAnswer: isCorrect, isSubmittedAnswer: isSubmitted)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let question = viewModel.currentQuestion else { return UIView()}
        switch question.type {
        case .Text:
            return simpleQuestionSection(tableView: tableView, question: question)
        case .Image:
            return imageQuestionSection(tableView: tableView, question: question)
        case .Audio:
            return audioQuestionSection(tableView: tableView, question: question)
        case .Video:
            return videoQuestionSection(tableView: tableView, question: question)
        }
    }

    private func simpleQuestionSection(tableView: UITableView, question: Question) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: SimpleQuestionSection.identifier) as? SimpleQuestionSection else {
            return nil
        }
        headerView.item = question
        return headerView
    }

    private func audioQuestionSection(tableView: UITableView, question: Question) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: AudioQuestionSection.identifier) as? AudioQuestionSection else {
            return nil
        }
        headerView.item = question
        headerView.playMedia()
        return headerView
    }

    private func videoQuestionSection(tableView: UITableView, question: Question) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: VideoQuestionSection.identifier) as? VideoQuestionSection else {
            return nil
        }
        headerView.item = question
        headerView.playMedia()
        return headerView
    }

    private func imageQuestionSection(tableView: UITableView, question: Question) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: ImageQuestionSection.identifier) as? ImageQuestionSection else {
            return nil
        }
        headerView.item = question
        return headerView
    }
}
