//
//  SDActiveBuilder.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/24.
//  Copyright © 2021 奋斗青年. All rights reserved.
//

import UIKit

typealias SDActiveFilterPredicate = ((String) -> Bool)


struct SDActiveBuilder {

    static func createElements(type: SDActiveType, from text: String, range: NSRange, filterPredicate: SDActiveFilterPredicate?) -> [SDElementTuple] {
        switch type {
        case .mention, .hashtag:
            return createElementsIgnoringFirstCharacter(from: text, for: type, range: range, filterPredicate: filterPredicate)
        case .url:
            return createElements(from: text, for: type, range: range, filterPredicate: filterPredicate)
        case .custom:
            return createElements(from: text, for: type, range: range, minLength: 1, filterPredicate: filterPredicate)
        case .email:
            return createElements(from: text, for: type, range: range, filterPredicate: filterPredicate)
        }
    }

    static func createURLElements(from text: String, range: NSRange, maximumLength: Int?) -> ([SDElementTuple], String) {
        let type = SDActiveType.url
        var text = text
        let matches = SDRegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [SDElementTuple] = []

        for match in matches where match.range.length > 2 {
            let word = nsstring.substring(with: match.range)
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

            guard let maxLength = maximumLength, word.count > maxLength else {
                let range = maximumLength == nil ? match.range : (text as NSString).range(of: word)
                let element = SDActiveElement.create(with: type, text: word)
                elements.append((range, element, type))
                continue
            }

            let trimmedWord = word.sd.sub(to: maxLength)
            text = text.replacingOccurrences(of: word, with: trimmedWord)

            let newRange = (text as NSString).range(of: trimmedWord)
            let element = SDActiveElement.url(original: word, trimmed: trimmedWord)
            elements.append((newRange, element, type))
        }
        return (elements, text)
    }

    private static func createElements(from text: String,
                                            for type: SDActiveType,
                                                range: NSRange,
                                                minLength: Int = 2,
                                                filterPredicate: SDActiveFilterPredicate?) -> [SDElementTuple] {

        let matches = SDRegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [SDElementTuple] = []

        for match in matches where match.range.length > minLength {
            let word = nsstring.substring(with: match.range)
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if filterPredicate?(word) ?? true {
                let element = SDActiveElement.create(with: type, text: word)
                elements.append((match.range, element, type))
            }
        }
        return elements
    }

    private static func createElementsIgnoringFirstCharacter(from text: String,
                                                                  for type: SDActiveType,
                                                                      range: NSRange,
                                                                      filterPredicate: SDActiveFilterPredicate?) -> [SDElementTuple] {
        let matches = SDRegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [SDElementTuple] = []

        for match in matches where match.range.length > 2 {
            let range = NSRange(location: match.range.location + 1, length: match.range.length - 1)
            var word = nsstring.substring(with: range)
            if word.hasPrefix("@") {
                word.remove(at: word.startIndex)
            }
            else if word.hasPrefix("#") {
                word.remove(at: word.startIndex)
            }

            if filterPredicate?(word) ?? true {
                let element = SDActiveElement.create(with: type, text: word)
                elements.append((match.range, element, type))
            }
        }
        return elements
    }
}
