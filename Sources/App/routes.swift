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
    
    router.get("staff", String.parameter) { request -> Future<View> in
        
        // getting the name the user has typed in
        let name = try request.parameters.next(String.self)
        
        // create some dummy data to work with
        let bios = ["kirk" : "My name is James Kirk and I love snakes.",
                    "picard": "My name is Jean-Luc Picard and I'm mad for fish.",
                    "sisko": "My name is Benjamin Sisko and I'm all about the budgies.",
                    "janeway": "My name is Kathryn Janeway and I want to hug every hamster.",
                    "archer": "My name is Jonathan Archer and beagles are my thing."
                    ]
        // define the struct we'll pass to the template
        struct StaffMembers: Codable {
            let name: String?
            let bios: String?
            var names: [String]
        }
        
        let context: StaffMembers
        
        // attempting to find a staff member by this name and fill in our struct
        if let bio = bios[name] {
            context = StaffMembers(name: name, bios: bio, names: bios.keys.sorted())
            print("Bio found for \(name): \(bio)")
        } else {
            context = StaffMembers(name: nil, bios: nil, names: bios.keys.sorted())
        }
        
        return try request.view().render("staff", context)
    }
}
