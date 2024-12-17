import Foundation

if let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt") {
    do {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        main(file: content)
    } catch {
        print("Error reading file: \(error.localizedDescription)")
    }
} else {
    print("File not found.")
}


func main(file: String) {
    var firstColumn = [Int]()
    var secondColumn = [Int]()
    var frequencyMap: [Int: Int] = [:]
    
    file.split(separator: "\n").forEach { line in
        let splitLine = line.split(separator: "   ")
        
        guard splitLine.count == 2 else {
            print("Invalid line: \(line)")
            return
        }
        
        let firstValue = Int(splitLine[0])!
        let secondValue = Int(splitLine[1])!
        
        firstColumn.append(Int(splitLine[0])!)
        secondColumn.append(Int(splitLine[1])!)
    }
    
    for int in firstColumn {
        if frequencyMap[int] != nil {
            continue
        }
        for int2 in secondColumn {
            if int == int2 {
                frequencyMap[int, default: 0] += 1
            }
        }
    }
    
    print(findDifferencesBetweenArrays(firstColumn.sorted(), secondColumn.sorted()))
    print(findSimilarityScore(array1: firstColumn, freq: frequencyMap))
}

// MARK: - Part 1
func findDifferencesBetweenArrays(_ array1: [Int], _ array2: [Int]) -> Int {
    var totalDifference = 0
    let minCount = min(array1.count, array2.count)
    
    for i in 0..<minCount {
        totalDifference += Int(abs(array1[i] - array2[i]))
    }
    
    return totalDifference
}

// MARK: - Part 2
func findSimilarityScore(array1: [Int], freq: [Int: Int]) -> Int {
    var similarityScore = 0
    
    for int in array1 {
        let frequency = freq[int] ?? 0
        similarityScore += frequency * int
    }
    
    return similarityScore
}
