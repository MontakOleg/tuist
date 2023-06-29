import Foundation
import TSCBasic
@testable import TuistGraph

extension AggregateTarget {
    /// Creates a AggregateTarget with test data
    public static func test(
        name: String = "AggregateTarget",
        scripts: [TargetScript] = []
    ) -> AggregateTarget {
        AggregateTarget(
            name: name,
            scripts: scripts
        )
    }

    /// Creates a bare bones AggregateTarget with as little data as possible
    public static func empty(
        name: String = "AggregateTarget",
        scripts: [TargetScript] = []
    ) -> AggregateTarget {
        AggregateTarget(
            name: name,
            scripts: scripts
        )
    }
}
