import UIKit
// https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html

var str = "He-llo, playground"

str.count
str[str.startIndex]
print(str[str.startIndex])
let index = str.firstIndex(of:"-") ?? str.endIndex
let beginning = str[..<index]
let newString = String(beginning)
print(newString)
let end = str[index...]

var userInput = "He-llo, playground"

// userInput = userInput.substringFromIndex(userInput.startIndex.successor())
let index2 = userInput.firstIndex(of:"-") ?? userInput.endIndex
var begin2 = userInput[..<index2]
var begin3 = userInput[...index2]

// var userInput = "non-empty"
if let i = userInput.firstIndex(of: "-") {
    userInput.remove(at: i)
}
print(userInput)


let end2 = userInput[index2...]
// let end3 = userInput[index2...>]

// userInput[userInput.endIndex] // error out of bounds

let rawInput = "126 a.b 22219 zzzzzz"
let numericPrefix = rawInput.prefix(while: { "0"..."9" ~= $0 })
numericPrefix
// numericPrefix is the substring "126"

