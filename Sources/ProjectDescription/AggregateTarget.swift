import Foundation

/// A aggregate target of a project.
public struct AggregateTarget: Codable, Equatable {
    /// The name of the target.
    public let name: String

    /// The build phase scripts actions for the target.
    public let scripts: [TargetScript]

    public init(
        name: String,
        scripts: [TargetScript] = []
    ) {
        self.name = name
        self.scripts = scripts
    }
}
