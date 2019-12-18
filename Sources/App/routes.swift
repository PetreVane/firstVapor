import Routing
import Vapor
import Leaf
import Foundation

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)

public func routes(_ router: Router) throws {
    
    router.get { request -> Future<View> in
        
        let context = [String : String]()
        
        return try request.view().render("home", context)
    }
    
    router.get("contact") { request -> Future<View> in
        
        let context = [String: String]()
        
        return try request.view().render("contact", context)
    }
    
}
