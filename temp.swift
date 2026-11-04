import Foundation

// Mean: sum of all values divided by how many there are
func calcMean(_ arr: [Int]) -> Double {
    var sum = 0
    for n in arr {
        sum += n
    }
    return Double(sum) / Double(arr.count)
}

// Median: middle value of a sorted array (average of the two middle values if even)
func calcMedian(_ arr: [Int]) -> Double {
    let mid = arr.count / 2
    if arr.count % 2 == 1 {
        return Double(arr[mid])
    }
    return Double(arr[mid - 1] + arr[mid]) / 2.0
}

// BONUS: Mode - returns 1 or more values (array must already be sorted)
func calcMode(_ arr: [Int]) -> [Int] {
    var bestCount = 0
    var modes: [Int] = []

    var i = 0
    while i < arr.count {
        var j = i
        while j < arr.count && arr[j] == arr[i] {
            j += 1
        }
        let count = j - i
        if count > bestCount {
            bestCount = count
            modes = [arr[i]]
        } else if count == bestCount {
            modes.append(arr[i])
        }
        i = j
    }
    return modes
}

// Put the three text files in the folder you run the program from
let files = ["Unit2-07-Set1.txt", "Unit2-07-Set2.txt", "Unit2-07-Set3.txt"]

for fileName in files {
    print("   ")
    print("File: \(fileName)")

    // 1. Read the file (we don't know how many items there are, so use an array that grows)
    guard let contents = try? String(contentsOfFile: fileName, encoding: .utf8) else {
        print("Error: could not find or read \(fileName)")
        continue
    }

    var list: [Int] = []
    let tokens = contents.split(whereSeparator: { $0 == " " || $0 == "\n" || $0 == "\r" || $0 == "\t" })
    for token in tokens {
        if let value = Int(token) {
            list.append(value)
        } else {
            print("Warning: skipping non-integer value '\(token)'")
        }
    }

    // Error check: empty file
    if list.isEmpty {
        print("Error: no integers found in \(fileName)")
        continue
    }

    // 2. Display each number on one line
    for n in list {
        print(n)
    }

    // 3. Sort (a copy is passed to each function, since arrays are passed by value in Swift)
    let sorted = list.sorted()

    // 4. Display results
    print("Count:  \(sorted.count)")
    print("Mean:   \(calcMean(sorted))")
    print("Median: \(calcMedian(sorted))")

    let modes = calcMode(sorted)
    if modes.count == sorted.count {
        print("Mode:   none (every value appears once)")
    } else {
        print("Mode:   \(modes)")
    }
}