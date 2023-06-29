import Foundation
import TSCBasic

public struct AggregateTarget: Equatable, Hashable, Comparable, Codable {
    // MARK: - Attributes

    public var name: String
    public var scripts: [TargetScript]

    // MARK: - Init

    public init(
        name: String,
        scripts: [TargetScript] = []
    ) {
        self.name = name
        self.scripts = scripts
    }

    /// Returns target's pre scripts.
    public var preScripts: [TargetScript] {
        scripts.filter { $0.order == .pre }
    }

    /// Returns target's post scripts.
    public var postScripts: [TargetScript] {
        scripts.filter { $0.order == .post }
    }

    /// Returns a new copy of the target with the given scripts.
    /// - Parameter scripts: Actions to be set to the copied instance.
    public func with(scripts: [TargetScript]) -> AggregateTarget {
        var copy = self
        copy.scripts = scripts
        return copy
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    // MARK: - Comparable

    public static func < (lhs: AggregateTarget, rhs: AggregateTarget) -> Bool {
        lhs.name < rhs.name
    }
}
