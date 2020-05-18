import Foundation

extension Int {
    func alphabetize() -> String? {
        let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        
        if self < alphabet.count {
            return alphabet[self]
        }
        
        return nil
    }
}
