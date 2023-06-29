import Foundation
import TSCBasic

public struct GraphAggregateTarget: Equatable, Hashable, Comparable, CustomDebugStringConvertible, CustomStringConvertible,
    Codable
{
    /// Path to the directory that contains the project where the target is defined.
    public let path: AbsolutePath

    /// Target representation.
    public let target: AggregateTarget

    /// Project that contains the target.
    public let project: Project

    public init(path: AbsolutePath, target: AggregateTarget, project: Project) {
        self.path = path
        self.target = target
        self.project = project
    }

    public static func < (lhs: GraphAggregateTarget, rhs: GraphAggregateTarget) -> Bool {
        (lhs.path, lhs.target) < (rhs.path, rhs.target)
    }

    // MARK: - CustomDebugStringConvertible/CustomStringConvertible

    public var debugDescription: String {
        description
    }

    public var description: String {
        "AggregateTarget '\(target.name)' at path '\(project.path)'"
    }
}
