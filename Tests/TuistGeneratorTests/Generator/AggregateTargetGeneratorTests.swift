import Foundation
import TSCBasic
import TuistCore
import TuistCoreTesting
import TuistGraph
import TuistGraphTesting
import XcodeProj
import XCTest
@testable import TuistGenerator

final class AggregateTargetGeneratorTests: XCTestCase {
    var path: AbsolutePath!
    var subject: AggregateTargetGenerator!
    var pbxproj: PBXProj!
    var pbxProject: PBXProject!

    override func setUp() {
        super.setUp()

        path = try! AbsolutePath(validating: "/test")
        pbxproj = PBXProj()
        pbxProject = createPbxProject(pbxproj: pbxproj)

        subject = AggregateTargetGenerator()
    }

    override func tearDown() {
        subject = nil
        pbxProject = nil
        pbxproj = nil
        path = nil
        super.tearDown()
    }

    func test_generateTarget_actions() throws {
        // Given
        let graph = Graph.test()
        let graphTraverser = GraphTraverser(graph: graph)
        let target = AggregateTarget.test(
            scripts: [
                TargetScript(
                    name: "post",
                    order: .post,
                    script: .scriptPath(path: path.appending(component: "script.sh"), args: ["arg"])
                ),
                TargetScript(
                    name: "pre",
                    order: .pre,
                    script: .scriptPath(path: path.appending(component: "script.sh"), args: ["arg"])
                ),
            ]
        )
        let project = Project.test(
            path: path,
            sourceRootPath: path,
            xcodeProjPath: path.appending(component: "Project.xcodeproj"),
            aggregateTargets: [target]
        )
        let groups = ProjectGroups.generate(
            project: project,
            pbxproj: pbxproj
        )

        // When
        let pbxTarget = try subject.generateTarget(
            target: target,
            project: project,
            pbxproj: pbxproj,
            pbxProject: pbxProject
        )

        // Then
        let preBuildPhase = pbxTarget.buildPhases.first as? PBXShellScriptBuildPhase
        XCTAssertEqual(preBuildPhase?.name, "pre")
        XCTAssertEqual(preBuildPhase?.shellPath, "/bin/sh")
        XCTAssertEqual(preBuildPhase?.shellScript, "\"$SRCROOT\"/script.sh arg")

        let postBuildPhase = pbxTarget.buildPhases.last as? PBXShellScriptBuildPhase
        XCTAssertEqual(postBuildPhase?.name, "post")
        XCTAssertEqual(postBuildPhase?.shellPath, "/bin/sh")
        XCTAssertEqual(postBuildPhase?.shellScript, "\"$SRCROOT\"/script.sh arg")
    }

    // MARK: - Helpers

    private func createPbxProject(pbxproj: PBXProj) -> PBXProject {
        let configList = XCConfigurationList(buildConfigurations: [])
        pbxproj.add(object: configList)
        let mainGroup = PBXGroup()
        pbxproj.add(object: mainGroup)
        let pbxProject = PBXProject(
            name: "Project",
            buildConfigurationList: configList,
            compatibilityVersion: "0",
            mainGroup: mainGroup
        )
        pbxproj.add(object: pbxProject)
        return pbxProject
    }
}
