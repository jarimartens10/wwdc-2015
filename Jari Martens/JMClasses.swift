//
//  JMClasses.swift
//  Jari Martens
//
//  Created by Jari Martens on 16-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import Foundation

enum JMClasses {
    case MathB
    case MathD
    case Dutch
    case German
    case IB
    case Latin
    case Physics
    case Chemistry
    case Philosophy
    case ANW
    case MO
    case PE
    case RE
    case Civics
    
    
    static var all_values: [JMClasses] {
        return [.MathB, .MathD, .Dutch, .German, .IB, .Latin, .Physics, .Chemistry, .Philosophy, .ANW, .MO, .PE, .RE, .Civics]
    }
    
    var description: String {
        switch self{
        case .MathB:
            return "Math B is math with the focus on exact sciences, instead of social sciences."
        case .MathD:
            return "Math D is extra math, and is for example about probability and combinatorics."
        case .Dutch:
            return "Dutch is my native language, and is a mandatory class."
        case .German:
            return "German is, well, German."
        case .IB:
            return "International Baccalaureate, or simple IB, is a higher level of English than most people get taught in the class English. For example, this year we have to write an extended essay about a poem. \nI have a certificate of the Anglia exam, that my level of English is near-native."
        case .Latin:
            return "Latin is the study of ancient Latin texts, such as translating Caesar's De Bello Gallico. We are also taught about the culture of the Romans."
        case .Physics:
            return "In Physics we are taught formulas and theory about several subjects, such as electricity, Newton's laws, characteristics of matirials, et cetera."
        case .Chemistry:
            return "In Chemistry we are taught about atoms, salts, ions and the naming of hydrocarbons and other substances."
        case .Philosophy:
            return "At Philosophy we study great philosophers of the past. We also develop an own opinion and learn how to support these with valid arguments."
        case .ANW:
            return "Natural Science is a mandatory class that is all about general information of for example Physics and Chemistry."
        case .MO:
            return "Management and Organization is all about organizations. Currently, we are learning about non-profit organizations, but next year it will be all about profit organizations. It could be compared with Business Science."
        case .PE:
            return "Physical Education is a mandatory class."
        case .RE:
            return "Religious Education is a mandatory class that is comparable with Philosophy, except for the fact that we are taught less about the visions of philosophers, and more about the visions of various religions."
        case .Civics:
            return "Social Sciences is a mandatory class that is all about the politics in the Netherlands, my home country."
        }
    }
    
    var name: String {
        switch self {
        case .MathB:
            return "Math B"
        case .MathD:
            return "Math D"
        case .Dutch:
            return "Dutch"
        case .German:
            return "German"
        case .IB:
            return "International Baccalaureate"
        case .Latin:
            return "Latin"
        case .Physics:
            return "Physics"
        case .Chemistry:
            return "Chemistry"
        case .Philosophy:
            return "Philosophy"
        case .ANW:
            return "Natural science"
        case .MO:
            return "Management & Organization"
        case .PE:
            return "Physical Education"
        case .RE:
            return "Religious Education"
        case .Civics:
            return "Social studies"
        }
    }
    
    var mark: Double {
        switch self {
        case .MathB:
            return 8.8
        case .MathD:
            return 8.9
        case .Dutch:
            return 7.1
        case .Latin:
            return 7.0
        case .German:
            return 7.8
        case .IB:
            return 6.9
        case .Physics:
            return 7.7
        case .Chemistry:
            return 8.5
        case .Philosophy:
            return 8.0
        case .MO:
            return 9.7
        case .PE:
            return 6.3
        case .Civics:
            return 6.0
        case .ANW:
            return 7.5
        case .RE:
            return 7.9
        }
    }
    
    var convertedMark: String {
        if mark >= 9.0 {
            return "A+"
        }
        else if mark >= 8.5 {
            return "A"
        }
        else if mark >= 7.8 {
            return "B+"
        }
        else if mark >= 7.3 {
            return "B"
        }
        else if mark >= 6.8 {
            return "C+"
        }
        else if mark >= 6.3 {
            return "C"
        }
        else if mark >= 5.0 {
            return "D"
        }
        else {
            return "F"
        }
    }
    
}