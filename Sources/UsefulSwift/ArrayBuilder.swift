import Foundation

//@_functionBuilder
@resultBuilder
public struct ArrayBuilder<T> {
    // Empty Case
    public static func buildBlock() -> [T] { [] }
    // Single case
    public static func buildBlock(_ expression: T) -> [T] { [expression] }
    // Multple items
    public static func buildBlock(_ elements: T...) -> [T] { elements }
    // Multiple function builders
    public static func buildBlock(_ elementss: [T]...) -> [T] { elementss.flatMap({ $0 }) }
    // If/Else
    public static func buildBlock(_ elements: [T]) -> [T] { elements }
    public static func buildEither(first: [T]) -> [T] { first }
    public static func buildEither(second: [T]) -> [T] { second }
    // Just ifs
    public static func buildIf(_ element: [T]?) -> [T] { element ?? [] }
    // fatalError()
    public static func buildBlock(_ element: Never) -> [T] {}
    
////    static func buildBlock(_ element: T, _ elements: T...) -> [T] { [element] + elements }
//    // 1x Single + 1x Array
////    static func buildBlock(_ e1: T, _ elements: [T]) -> [T] { [e1] + elements }
//    static func buildBlock(_ e1: T, _ elements1: [T], _ elements2: T...) -> [T] { [e1] + elements1 + elements2 }
////    static func buildBlock(_ elements: [T], _ e1: T) -> [T] { [e1] + elements }
//
//    // 2x Singles + 1x Array
//    static func buildBlock(_ e1: T, _ e2: T, _ elements: [T]) -> [T] { [e1, e2] + elements }
////    static func buildBlock(_ es: T..., _ elements: [T]) -> [T] { es... + elements } // A parameter following a variadic parameter requires a label
////    static func buildBlock(_ e1: T, _ elements: [T], _ e2: T) -> [T] { [e1] + elements + [e2] }
////    static func buildBlock(_ elements: [T], _ e1: T, _ e2: T) -> [T] { elements + [e1, e2] }
//    static func buildBlock(_ elements1: [T], _ elements2: T...) -> [T] { elements1 + elements2 }
//
//    // 3x Singles + 1x Array
//    static func buildBlock(_ e1: T, _ e2: T, _ e3: T, _ elements: [T]) -> [T] { [e1, e2, e3] + elements }
//    static func buildBlock(_ e1: T, _ e2: T, _ elements: [T], _ e3: T) -> [T] { [e1, e2] + elements + [e3] }
//    static func buildBlock(_ e1: T, _ elements: [T], _ e2: T, _ e3: T) -> [T] { [e1] + elements + [e2, e3] }
//    static func buildBlock(_ elements: [T], _ e1: T, _ e2: T, _ e3: T) -> [T] { elements + [e1, e2, e3] }
//
//    // 1x Single + 2x Arrays
//    static func buildBlock(_ elements1: [T], _ e1: T, _ elements2: [T]) -> [T] { elements1 + [e1] + elements2 }
//
//    // 2x Singles + 2x Arrays
//    static func buildBlock(_ elements1: [T], _ e1: T, _ elements2: [T], _ e2: T) -> [T] { elements1 + [e1] + elements2 + [e2] }
//    static func buildBlock(_ elements1: [T], _ e1: T, _ e2: T, _ elements2: [T]) -> [T] { elements1 + [e1, e2] + elements2 }
//    static func buildBlock(_ e1: T, _ elements1: [T], _ e2: T, _ elements2: [T]) -> [T] { [e1] + elements1 + [e2] + elements2 }
//
//    // 2x Singles + 3x Arrays
//    static func buildBlock(_ elements1: [T], _ e1: T, _ elements2: [T], _ e2: T, _ elements3: [T]) -> [T] { elements1 + [e1] + elements2 + [e2] + elements2 }
    
    // Mix Arrays and Singles.
    // But this is a work around for "A parameter following a variadic parameter requires a label"
    
    // 1x Arrays (up to 3x singles)
    public static func buildBlock(_ array1: [T], _ trailing: T...) -> [T] { array1 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ trailing: T...) -> [T] { [e1] + array1 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ array1: [T], _ trailing: T...) -> [T] { [e1, e2] + array1 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ e3: T, _ array1: [T], _ trailing: T...) -> [T] { [e1, e2, e3] + array1 + trailing }
    
    // 2x Arrays (up to 3x singles)
    public static func buildBlock(_ array1: [T], _ array2: [T], _ e1: T, _ trailing: T...) -> [T] { array1 + array2 + [e1] + trailing } // to avoid ambiguity ([T]...)
    public static func buildBlock(_ array1: [T], _ e1: T, _ array2: [T], _ trailing: T...) -> [T] { array1 + [e1] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ array2: [T], _ trailing: T...) -> [T] { [e1] + array1 + array2 + trailing }
    
    public static func buildBlock(_ array1: [T], _ e1: T, _ e2: T, _ array2: [T], _ trailing: T...) -> [T] { array1 + [e1, e2] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ e2: T, _ array2: [T], _ trailing: T...) -> [T] { [e1] + array1 + [e2] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ array1: [T], _ array2: [T], _ trailing: T...) -> [T] { [e1, e2] + array1 + array2 + trailing }
    
    public static func buildBlock(_ array1: [T], _ e1: T, _ e2: T, _ e3: T, _ array2: [T], _ trailing: T...) -> [T] { array1 + [e1, e2, e3] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ e2: T, _ e3: T, _ array2: [T], _ trailing: T...) -> [T] { [e1] + array1 + [e2, e3] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ array1: [T], _ e3: T, _ array2: [T], _ trailing: T...) -> [T] { [e1, e2] + array1 + [e3] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ e3: T, _ array1: [T], _ array2: [T], _ trailing: T...) -> [T] { [e1, e2, e3] + array1 + array2 + trailing }
    
//    static func buildBlock(_ expression: T?) -> [T] { expression.map({ [$0] }) ?? [] }
//    static func buildBlock(_ elements: [T]?) -> [T] { elements ?? [] }
//    static func buildBlock(_ elements: T?...) -> [T] { elements.compactMap({ $0 }) }
//    static func buildBlock(_ elementss: [[T]?]) -> [T] { elementss.flatMap({ $0 ?? [] }) }
//    static func buildBlock(_ elementss: [T]?...) -> [T] { elementss.flatMap({ $0 ?? [] }) }
//    static func buildBlock(_ elementss: [T?]...) -> [T] { elementss.flatMap({ $0.compactMap({ $0 }) }) }
    
//    static func buildIf(_ element: T?) -> [T] { element.map { [$0] } ?? [] }
//    static func buildIf(_ elements: [T]?) -> [T] { elements ?? [] }
//    static func buildEither(first: T) -> [T] { [first] }
//    static func buildEither(second: T) -> [T] { [second] }
//    static func buildEither(first: T...) -> [T] { first }
//    static func buildEither(second: T...) -> [T] { second }
    
//    static func buildBlock(_ either: Either<T>...) -> [T] { either.flatMap { $0.asArray } }
//
//    enum Either<T> {
//        case single(T)
//        case array([T])
//
//        var asArray: [T] {
//            switch self {
//            case .single(let el): return [el]
//            case .array(let els): return els
//            }
//        }
//    }
}
