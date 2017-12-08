//: [Previous](@previous) | [Contents](Contents)
/*:
 # Advent of Code 2017
 ## Day 4: High-Entropy Passphrases
 
 A new system policy has been put in place that requires all accounts to use a **passphrase** instead of simply a pass**word**. A passphrase consists of a series of words (lowercase letters) separated by spaces.
 
 To ensure security, a valid passphrase must contain no duplicate words.
 
 For example:
 
 * `aa bb cc dd ee` is valid.
 * `aa bb cc dd aa` is not valid - the word `aa` appears more than once.
 * `aa bb cc dd aaa` is valid - `aa` and `aaa` count as different words.
 
 The system's full passphrase list is available as your puzzle input. **How many passphrases are valid?**
 */
func countValidPasswords(passwords: [String], validation: (String) -> Bool) -> Int {
    let results = passwords.map(validation)
    return results.filter { $0 }.count
}

func isPasswordValid1(password: String) -> Bool {
    let words = password.components(separatedBy: .whitespaces)
    let set = Set(words)
    return words.count == set.count
}

let a = isPasswordValid1(password: "aa bb cc dd ee")
assert(a == true)

let b = isPasswordValid1(password: "aa bb cc dd aa")
assert(b == false)

let c = isPasswordValid1(password: "aa bb cc dd aaa")
assert(c == true)

let input = loadInput()
let lines = input.components(separatedBy: .newlines).filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }

let answer1 = countValidPasswords(passwords: lines, validation: isPasswordValid1)
print("Part 1: \(answer1)")
/*:
 ## Part Two
 
 For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.
 
 For example:
 
 * `abcde fghij` is a valid passphrase.
 * `abcde xyz ecdab` is not valid - the letters from the third word can be rearranged to form the first word.
 * `a ab abc abd abf abj` is a valid passphrase, because **all** letters need to be used when forming another word.
 * `iiii oiii ooii oooi oooo` is valid.
 * `oiii ioii iioi iiio` is not valid - any of these words can be rearranged to form any other word.
 
 Under this new system policy, **how many passphrases are valid?**
 */
func isPasswordValid2(password: String) -> Bool {
    let words = password.components(separatedBy: .whitespaces)
    let sortedWords = words.map { String($0.sorted()) }
    let sortedWordsSet = Set(sortedWords)
    return sortedWords.count == sortedWordsSet.count
}

let d = isPasswordValid2(password: "abcde fghij")
assert(d == true)

let e = isPasswordValid2(password: "abcde xyz ecdab")
assert(e == false)

let f = isPasswordValid2(password: "a ab abc abd abf abj")
assert(f == true)

let g = isPasswordValid2(password: "iiii oiii ooii oooi oooo")
assert(g == true)

let h = isPasswordValid2(password: "oiii ioii iioi iiio")
assert(h == false)

let answer2 = countValidPasswords(passwords: lines, validation: isPasswordValid2)
print("Part 2: \(answer2)")
//: [Previous](@previous) | [Contents](Contents)
