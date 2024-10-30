//
//  ContentView.swift
//  SampleNavigation
//
//  Created by Tatiredd.reddy on 30/10/24.
//

import SwiftUI
enum Destination: Hashable {
    case listing
}
struct ContentView: View {
    @StateObject var router: Router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            VStack {
                Button {
                    router.navigate(to: Destination.listing)
                } label: {
                    Text("Show sheet")
                }
            }
            .padding()
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .listing:
                    ListingView().environmentObject(router)
                }
            }
        }
    }
}


/// `AnyIdentifiable` is a type-erasing wrapper class designed to encapsulate any object that conforms to the `Identifiable` protocol.
/// This class allows for the handling of identifiable objects in a type-agnostic way, enabling operations on a collection of diverse `Identifiable` objects without knowing their specific types.
///
/// Properties:
/// - `destination`: Stores the encapsulated `Identifiable` object. It is declared as `any Identifiable`, indicating that it can hold any object that conforms to the `Identifiable` protocol.
///
/// Initialization:
/// - `init(destination: any Identifiable)`: Initializes a new instance of `AnyIdentifiable` with the provided `Identifiable` object. This allows for the dynamic encapsulation of various identifiable objects.
///
/// Usage:
/// - `AnyIdentifiable` is particularly useful in scenarios where you need to store or pass around a mixed collection of `Identifiable` objects without losing their identity information.
/// - It can be used in SwiftUI navigation or presentation contexts, where identifying information is required to manage view hierarchies or perform navigation actions.
public class AnyIdentifiable: Identifiable {
    public let destination: any Identifiable

    public init(destination: any Identifiable) {
        self.destination = destination
    }
}

/// `Router` is a class designed to manage navigation and presentation within a SwiftUI application.
/// It leverages SwiftUI's `NavigationPath` and custom type-erasing wrappers to handle both stack-based navigation and modal presentations in a type-safe manner.
///
/// Properties:
/// - `navPath`: A `NavigationPath` object that represents the current stack of navigable views. It is observed by SwiftUI and updates the UI accordingly when changed.
/// - `presentedSheet`: An optional `AnyIdentifiable` object that represents the currently presented modal view. When set, it triggers the presentation of a modal sheet.
///
/// Initialization:
/// - `init()`: Initializes a new instance of `Router` with empty navigation and presentation states.
///
/// Methods:
/// - `presentSheet(destination: any Identifiable)`: Presents a modal sheet with the given destination. The destination is wrapped in an `AnyIdentifiable` to maintain type-erasure.
/// - `navigate(to destination: any Hashable)`: Navigates to a new view identified by the given destination. The destination is added to the `navPath`.
/// - `navigateBack()`: Navigates back in the navigation stack by removing the last destination from `navPath`.
/// - `navigateToRoot()`: Clears the navigation stack, effectively navigating back to the root view.
///
/// Usage:
/// - `Router` can be used within a SwiftUI application to manage navigation between views and the presentation of modal sheets in a centralized manner.
/// - It abstracts away the details of navigation path manipulation and modal presentation, providing a simple API for view navigation and presentation.
public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()
    @Published public var presentedSheet: AnyIdentifiable?

    public init() {}

    public func presentSheet(destination: any Identifiable) {
        presentedSheet = AnyIdentifiable(destination: destination)
    }

    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
