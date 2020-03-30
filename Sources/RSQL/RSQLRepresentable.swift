//
//  RSQLRepresentable.swift
//  MolgenisClient
//
//  Created by David van Enckevort on 08-05-18.
//

import Foundation

public protocol RSQLRepresentable {
    var rsql: String { get }
}

extension DateComponents: RSQLRepresentable {
    public var rsql: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if self.hour != nil {
            formatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZZZZZ"
        } else {
            formatter.dateFormat = "yyyy-MM-dd"
        }
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self.date!)
    }
}

extension Predicate: RSQLRepresentable {
    public var rsql: String {
        switch self {
        case .equal(let subject, let object):
            return "\(subject)==\(object)"
        case .notEqual(let subject, let object):
            return "\(subject)!=\(object)"
        case .lessThan(let subject, let object):
            return "\(subject)=lt=\(object)"
        case .greaterThan(let subject, let object):
            return "\(subject)=gt=\(object)"
        case .lessOrEqualTo(let subject, let object):
            return "\(subject)=le=\(object)"
        case .greaterOrEqualTo(let subject, let object):
            return "\(subject)=ge=\(object)"
        case .containedIn(let subject, let object):
            return "\(subject)=in=\(object)"
        case .notContainedIn(let subject, let object):
            return "\(subject)=out=\(object)"
        case .similarTo(let subject, let object):
            return "\(subject)=q=\(object)"
        case .and(let predicates):
            return predicates.map { $0.embeddedRsql }.joined(separator: ";")
        case .or(let predicates):
            return predicates.map { $0.embeddedRsql }.joined(separator: ",")
        }
    }

    private var embeddedRsql: String {
        switch self {
        case .and, .or:
            return "(\(self.rsql))"
        default:
            return self.rsql
        }
    }
}
