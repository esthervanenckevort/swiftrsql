//
//  Predicate.swift
//  MolgenisClient
//
//  Created by David van Enckevort on 08-05-18.
//
import Foundation

public enum Predicate {
    case and(predicates: [Predicate])
    case or(predicates: [Predicate])
    case equal(subject: String, object: Any)
    case notEqual(subject: String, object: Any)
    case lessThan(subject: String, object: Any)
    case greaterThan(subject: String, object: Any)
    case lessOrEqualTo(subject: String, object: Any)
    case greaterOrEqualTo(subject: String, object: Any)
    case containedIn(subject: String, object: Any)
    case notContainedIn(subject: String, object: Any)
    case similarTo(subject: String, object: Any)
}
