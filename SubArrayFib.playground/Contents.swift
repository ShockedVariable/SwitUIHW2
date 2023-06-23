import Foundation

var cache = [Int : Int]()

func isPerfectSquare(_ n: Double) -> Bool {
    let temp = floor(sqrt(n))
    return (temp * temp) == n
}

func isFibonacci(_ n: Double) -> Bool {
    return isPerfectSquare((5 * n * n) + 4) || isPerfectSquare((5 * n * n) - 4)
}

func calcTerm(_ n: Double) -> Int {
    Int(round(2.078087 * log(n) + 1.672276))
}

func fib(_ n: Int) -> Int {
    if let t = cache[n] {
        return t
    }
    else {
        if n == 0 {
            return 0
        }
        else if n == 1 || n == 2 {
            return 1
        }
        else {
            var a = fib(n - 1)
            var b = fib(n - 2)
            cache[n - 1] = a
            cache[n - 2] = b
            return a + b
        }
    }
}

func noCacheFib(_ n: Int) -> Int {
    if n == 0 {
        return 0
    }
    else if n == 1 || n == 2 {
        return 1
    }
    else {
        var a = fib(n - 1)
        var b = fib(n - 2)
        return a + b
    }
}

func subArrayFib(_ starting: Double, _ step: Int) -> [Int] {
    var ans = [Int]()

    if !isFibonacci(starting) {
        return ans
    }
    else {
        ans.append(Int(starting))
        var term = calcTerm(starting)
        
        for i in (term + 1)..<(term + step) {
            ans.append(fib(i))
        }
        
        return ans
    }
}

print(subArrayFib(1, 91))
