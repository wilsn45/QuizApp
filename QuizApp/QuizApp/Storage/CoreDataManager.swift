//
//  CoreDataManager.swift
//  QuizApp
//
//  Created by Wilson Shakya on 03/05/21.
//

import CoreData

protocol CoreDataManagerType {
    func recordAnswer(answer : Answer)
    func getAnswers() -> [Answer]
}

final class CoreDataManager : CoreDataManagerType {
    
    private final let persistentContainerIdentifier = "QuizApp"
    private final let cdAnswerEntityIdentifier = "CDAnswer"
    
    private lazy var persistentContainer : NSPersistentContainer = {
        let persistenContainer = NSPersistentContainer(name: persistentContainerIdentifier)
        persistenContainer.loadPersistentStores { (_, error) in
            print(error?.localizedDescription ?? "")
        }
        return persistenContainer
    }()
    
    private var managedObjectContext : NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func recordAnswer(answer : Answer) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: cdAnswerEntityIdentifier)
        fetchRequest.predicate = NSPredicate(format: "id == \(answer.question.id)")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
        } catch {
            print(error)
        }
        
        let newAnswer = CDAnswer(context: managedObjectContext)
        newAnswer.setValue(Int16(answer.question.id), forKey: "id")
        newAnswer.setValue(answer.question.question, forKey: "question")
        newAnswer.setValue(answer.question.contentUrl, forKey: "contentUrl")
        newAnswer.setValue(answer.question.type.rawValue, forKey: "type")
        newAnswer.setValue(answer.question.options, forKey: "options")
        newAnswer.setValue(answer.question.correctAnswers, forKey: "correctAnswers")
        newAnswer.setValue(answer.submitedAnswers, forKey: "submitedAnswers")
        
        do {
           try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func getAnswers() -> [Answer] {
        do {
            let fetchRequest = NSFetchRequest<CDAnswer>(entityName: cdAnswerEntityIdentifier)
            let answers = try managedObjectContext.fetch(fetchRequest)
            var answerArray = [Answer]()
            
            answerArray = answers.map({
                return Answer(question: Question(id :Int($0.id), type : QuestionType(rawValue : $0.type!)!, question : $0.question!, contentUrl : $0.contentUrl!, options : ($0.options as! [String]), correctAnswers : ($0.correctAnswers as! [String])), submitedAnswers : $0.submitedAnswers as! [String])
            })
            return answerArray
        } catch {
            print(error)
            return []
        }
    }
    
}
