import Foundation
import ProjectDescription
import TSCBasic
import TuistCore
import TuistGraph
import TuistSupport

extension TuistGraph.AggregateTarget {
    /// Maps a ProjectDescription.Target instance into a TuistGraph.Target instance.
    /// - Parameters:
    ///   - manifest: Manifest representation of  the target.
    ///   - generatorPaths: Generator paths.
    static func from(
        manifest: ProjectDescription.AggregateTarget,
        generatorPaths: GeneratorPaths
    ) throws -> TuistGraph.AggregateTarget {
        let name = manifest.name

        let scripts = try manifest.scripts.map {
            try TuistGraph.TargetScript.from(manifest: $0, generatorPaths: generatorPaths)
        }

        return TuistGraph.AggregateTarget(
            name: name,
            scripts: scripts
        )
    }
}
