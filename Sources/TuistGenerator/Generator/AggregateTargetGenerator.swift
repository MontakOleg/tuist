import Foundation
import TSCBasic
import TuistCore
import TuistGraph
import TuistSupport
import XcodeProj

protocol AggregateTargetGenerating: AnyObject {
    func generateTarget(
        target: AggregateTarget,
        project: Project,
        pbxproj: PBXProj,
        pbxProject: PBXProject
    ) throws -> PBXAggregateTarget
}

final class AggregateTargetGenerator: AggregateTargetGenerating {
    // MARK: - Attributes

    let buildPhaseGenerator: BuildPhaseGenerating

    // MARK: - Init

    init(
        buildPhaseGenerator: BuildPhaseGenerating = BuildPhaseGenerator()
    ) {
        self.buildPhaseGenerator = buildPhaseGenerator
    }

    // MARK: - TargetGenerating

    func generateTarget(
        target: AggregateTarget,
        project: Project,
        pbxproj: PBXProj,
        pbxProject: PBXProject
    ) throws -> PBXAggregateTarget {
        /// Target
        let pbxTarget = PBXAggregateTarget(
            name: target.name
        )

        pbxproj.add(object: pbxTarget)
        pbxProject.targets.append(pbxTarget)

        /// Pre actions
        try buildPhaseGenerator.generateScripts(
            target.scripts.preScripts,
            pbxTarget: pbxTarget,
            pbxproj: pbxproj,
            sourceRootPath: project.sourceRootPath
        )

        /// Post actions
        try buildPhaseGenerator.generateScripts(
            target.scripts.postScripts,
            pbxTarget: pbxTarget,
            pbxproj: pbxproj,
            sourceRootPath: project.sourceRootPath
        )

        return pbxTarget
    }
}
