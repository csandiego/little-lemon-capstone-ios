//
//  Menu.swift
//  Little Lemon
//
//  Created by Christopher San Diego on 18/7/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text(dish.title! + " " + dish.price!)
                            AsyncImage(url: URL(string: dish.image!)) {
                                $0.resizable()
                            } placeholder: {
                                Color.white
                            }.frame(width: 50, height: 50)
                        }
                    }
                }
            }
        }.onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                let decoder = JSONDecoder()
                let menuList = try? decoder.decode(MenuList.self, from: data)
                menuList?.menu.forEach {
                    let dish = Dish(context: viewContext)
                    dish.title = $0.title
                    dish.image = $0.image
                    dish.price = $0.price
                }
                try? viewContext.save()
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
