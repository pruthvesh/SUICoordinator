//
//  CoordinatorType.swift
//
//  Copyright (c) Andres F. Lozano
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public extension CoordinatorType {
    
    /// Retrieves the top coordinator in the hierarchy, optionally starting from a specified coordinator.
    ///
    /// - Parameters:
    ///   - pCoodinator: The optional starting point for finding the top coordinator.
    /// - Returns: The top coordinator in the hierarchy or nil if none is found.
    /// - Throws: An error if the top coordinator retrieval fails.
    func topCoordinator(pCoodinator: TCoordinatorType? = nil) throws -> TCoordinatorType? {
        guard children.last != nil else { return self }
        var auxCoordinator = pCoodinator ?? self.children.last
        return try getDeepCoordinator(from: &auxCoordinator)
    }
    
    /// Navigates to a new coordinator with a specified presentation style.
    ///
    /// - Parameters:
    ///   - coordinator: The coordinator to navigate to.
    ///   - presentationStyle: The transition presentation style for the navigation.
    ///   - animated: A boolean value indicating whether to animate the navigation.
    func navigate(to coordinator: TCoordinatorType, presentationStyle: TransitionPresentationStyle, animated: Bool = true ) async -> Void {
        startChildCoordinator(coordinator)
        
        let item = SheetItem(
            id: "\(coordinator.uuid) - \(presentationStyle.id)",
            animated: animated,
            presentationStyle: (presentationStyle != .push) ? presentationStyle : .sheet,
            view: { [weak coordinator] in coordinator?.getView() }
        )
        
        swipedAway(coordinator: coordinator)
        router.presentSheet(item: item)
    }
    
    /// Finishes the flow of the coordinator.
    ///
    /// - Parameters:
    ///   - animated: A boolean value indicating whether to animate the finish flow process.
    func finishFlow(animated: Bool = true) async -> Void {
        await finish(animated: animated, withDismiss: true)
    }
    
    /// Starts a flow in the coordinator with a specified route and transition style.
    ///
    /// - Parameters:
    ///   - route: The route to start the flow.
    ///   - transitionStyle: The transition presentation style for the flow.
    ///   - animated: A boolean value indicating whether to animate the start flow process.
    func startFlow(route: Route, transitionStyle: TransitionPresentationStyle? = nil, animated: Bool = true) async -> Void {
        router.mainView = route
    }
    
    /// Forces the presentation of the coordinator.
    ///
    /// - Parameters:
    ///   - animated: A boolean value indicating whether to animate the presentation.
    ///   - presentationStyle: The transition presentation style for the forced presentation.
    ///   - mainCoordinator: The main coordinator associated with the forced presentation.
    ///   - Throws: An error if the presentation cannot be forced.
    ///   SeeAlso: TransitionPresentationStyle
    func forcePresentation(
        animated: Bool = true,
        presentationStyle: TransitionPresentationStyle = .sheet,
        mainCoordinator: (any CoordinatorType)? = nil
    ) async throws {
        let topCoordinator = try mainCoordinator?.topCoordinator()
        await topCoordinator?.navigate(to: self, presentationStyle: presentationStyle)
    }
    
    /// Restarts the current view or coordinator, optionally animating the restart.
    ///
    /// - Parameters:
    ///   - animated: A boolean value indicating whether to animate the restart action.
    func restart(animated: Bool = true) async {
        await router.restart(animated: animated)
    }
}
