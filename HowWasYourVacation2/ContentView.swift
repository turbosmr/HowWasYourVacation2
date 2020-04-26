//
//  ContentView.swift
//  HowWasYourVacation2
//
//  Created by STEVE RENTSCHLER on 3/25/20.
//  Copyright © 2020 STEVE RENTSCHLER. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font : UIFont(name:"Savoye LET", size: 60)!]
                
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "HelveticaNeue-Thin", size: 20)!]
    }
    
    @State var cities = ["San Francisco, CA, US","Oakland, CA, US","Palm Beach, CA, US","Las Vegas, NV, US"]
    @State var txt = ""
    
    var body: some View {
    
        TabView {
            
            NavigationView {
                VStack{
                    SearchView(txt: $txt)
                    List(cities.filter{ txt == "" ? true : $0.localizedCaseInsensitiveContains(txt)},id: \.self) {
                        i in  NavigationLink(
                            destination: FeedView()) {
                            Text(i)
                            }
                    }
                }
                .navigationBarTitle(Text("Search"))
               
            }.tabItem {
               Image(systemName: "magnifyingglass")
               .font(Font.system(.largeTitle))
               Text("Search")
            }
            NavigationView {
                Profile()
            }
            .tabItem {
                Image(systemName: "house")
                .font(Font.system(.largeTitle))
                Text("Home")
            }
            NavigationView {
                Bookmarks()
            }
            .tabItem {
                Image(systemName: "book")
                .font(Font.system(.largeTitle))
                Text("Bookmarks")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchView : UIViewRepresentable {
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    
    @Binding var txt : String
    
    func makeCoordinator() -> SearchView.Coordinator {
        return SearchView.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchView>) -> UISearchBar {
        
        let searchbar = UISearchBar()
        searchbar.barStyle = .default
        searchbar.autocapitalizationType = .none
        searchbar.delegate = context.coordinator
        return searchbar
    }
  
    
    class Coordinator : NSObject, UISearchBarDelegate {
        var parent : SearchView!
        init(parent1 : SearchView) {
            parent = parent1
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            parent.txt = searchText
        }
    }
}

struct Profile : View {

       let menuItems = ["Vacations", "Questions Asked"]
    
       struct DetailView: View {
        
            let menuItem: String
            var body: some View {
                
                VStack(alignment: .leading) {
                
                HStack{
                
                Image(systemName: "person.crop.circle.fill").resizable().frame(width: 50, height: 50) .offset(x: 20).foregroundColor(Color.gray)
                
                Text("Steve")
                    .font(.system(size: 25))
                    .padding(.bottom, 40)
                    .padding(.top, 40)
                    .offset(x: 25)
                }
                List {
                  Text("Item 1")
                  Text("Item 2")
                  Text("Item 3")
                    }
                }
                .navigationBarTitle(Text(menuItem))
                .navigationBarItems(trailing:
                    NavigationLink(destination: AddAVacationView()) {
                    Text("Add a Vacation")})
            }
       }
       var body : some View {
       
        VStack(alignment: .leading) {
            
            HStack{
                
                Image(systemName: "person.crop.circle.fill").resizable().frame(width: 50, height: 50) .offset(x: 20).foregroundColor(Color.gray)
                
                Text("Steve")
                    .font(.system(size: 25))
                    .padding(.bottom, 40)
                    .padding(.top, 40)
                    .offset(x: 25)
            }
            List(menuItems, id: \.self) { menuItem in
              NavigationLink(
                destination: DetailView(menuItem: menuItem)) {
                  Text(menuItem)
                }
            }.listStyle(GroupedListStyle())
             .environment(\.horizontalSizeClass, .compact)
             .navigationBarTitle(Text("Home"))
        }
    }
}
struct Bookmarks : View {
    var body : some View {
        
        VStack(alignment: .leading) {
                   
        HStack{
           
         Image(systemName: "person.crop.circle.fill").resizable().frame(width: 50, height: 50) .offset(x: 20).foregroundColor(Color.gray)
       
         Text("Steve")
           .font(.system(size: 25))
           .padding(.bottom, 40)
           .padding(.top, 40)
           .offset(x: 25)
         }
         List {
           Text("Item 1")
           Text("Item 2")
           Text("Item 3")
            }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .compact)
            }
          .navigationBarTitle(Text("Bookmarks"))
    }
}

struct FeedView : View {
    var body : some View {
      
       VStack(alignment: .leading){
                   
        HStack{
                Image(systemName: "person.crop.circle.fill")
                   .resizable().frame(width: 50, height: 50)
                   .foregroundColor(Color.gray)
                    .padding(.leading, 10)
            VStack(alignment: .leading){
                Text("Steve")
                   .font(.system(size: 20))
                Text("3/29/2020")
                    .font(.system(size: 15))
            }
        }
        HStack{
                Image("c0")
                   .resizable().frame(height: 125)
                   .scaledToFit()
                   .padding(.leading, 10)
            
                Image("New_york_times_square-terabass")
                   .resizable().frame(height: 125)
                   .scaledToFit()
                   .padding(.trailing, 10)
        }
        HStack{
            NavigationLink(destination: DetailedFeedView()) {
                Image("195334431")
                   .resizable().frame(height: 125)
                   .scaledToFit()
                    .padding(.leading, 10)
            }.buttonStyle(PlainButtonStyle())
                Image("chicago-hero")
                    .resizable().frame(height: 125)
                    .scaledToFit()
                    .padding(.trailing, 10)
        }
        NavigationLink(destination: QuestionsView()) {
            Text("View Questions")
               .font(.system(size: 20))
               .padding(.top, 5)
               .padding(.leading, 10)
            }
        }
        
        .navigationBarTitle(Text("San Francisco"))
        .navigationBarItems(trailing:
                   Button(action: {
                       print("Edit button pressed...")
                   }) {
                       Text("Add to Bookmarks")
                   })
    }
}
struct DetailedFeedView : View {
    var body : some View {
      
       VStack(alignment: .leading){
                   
        HStack{
                Image(systemName: "person.crop.circle.fill")
                   .resizable().frame(width: 50, height: 50)
                   .foregroundColor(Color.gray)
                   .padding(.leading, 10)
            VStack(alignment: .leading){
                Text("Steve")
                   .font(.system(size: 20))
                Text("3/29/2020")
                    .font(.system(size: 15))
            }
        }
                Image("195334431")
                   .resizable()
                   .scaledToFit()
                   .padding(.leading, 10)
                   .padding(.trailing, 10)
                Text("This was my favorite spot in San Francisco! We went here after getting kicked out of a bar near by.")
                   .padding(.leading, 10)
                   .padding(.trailing, 10)
        }
        .navigationBarTitle(Text("San Francisco"))
    }
}
struct QuestionsView : View {
    
    @State var composedMessage: String = ""

    var body : some View {
        
        
        VStack(alignment: .leading){
               
        Text("Question: How was it like in San Francisco? Did you get to see the Salesforce Tower?")
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
        
        VStack(alignment: .leading){
            
            HStack (alignment: .top) {
                Text("Bill")
                   .font(.system(size: 15))
                   .padding(.leading, 20)
                   .foregroundColor(Color.orange)
                Text("3/30/2020")
                    .font(.system(size: 15))
                    .foregroundColor(Color.orange)
            }
        }
     Text("Answer: I loved San Francisco! Yes, The Salesforce tower was paying this really cool light show at the top of the tower!")
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 20)
            
            VStack(alignment: .leading){
                
                HStack (alignment: .top) {
                    Text("Steve")
                       .font(.system(size: 15))
                       .padding(.leading, 20)
                       .foregroundColor(Color.orange)
                    Text("3/30/2020")
                        .font(.system(size: 15))
                        .foregroundColor(Color.orange)
                }
            }
        Spacer()
        .navigationBarTitle(Text("Questions"))
     
            HStack {
                // this textField generates the value for the composedMessage @State var
                TextField("Ask a Question", text: $composedMessage).frame(minHeight: CGFloat(40))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "arrow.up.circle.fill").resizable().frame(width: 30, height: 30)
                        .foregroundColor(Color.orange)
            
            }.frame(minHeight: CGFloat(50)).padding()
        }
    }
}
struct AnswerQuestionsView : View {
    
    @State var composedMessage: String = ""

    var body : some View {
        
        
        VStack(alignment: .leading){
               
        Text("Question: How was it like in San Francisco? Did you get to see the Salesforce Tower?")
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
        
        VStack(alignment: .leading){
            
            HStack (alignment: .top) {
                Text("Bill")
                   .font(.system(size: 15))
                   .padding(.leading, 20)
                   .foregroundColor(Color.orange)
                Text("3/30/2020")
                    .font(.system(size: 15))
                    .foregroundColor(Color.orange)
            }
        }
        Spacer()
        .navigationBarTitle(Text("Questions"))
     
            HStack {
                // this textField generates the value for the composedMessage @State var
                TextField("Answer", text: $composedMessage).frame(minHeight: CGFloat(40))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "arrow.up.circle.fill").resizable().frame(width: 30, height: 30)
                        .foregroundColor(Color.orange)
            
            }.frame(minHeight: CGFloat(50)).padding()
        }
    }
}
struct AddAVacationView : View {
    
    @State var composedMessage: String = ""
    
var body : some View {
    
    VStack {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(height: 125)
                    .padding(.leading, 10)
                    
                Text("Add a photo")
                    .foregroundColor(Color.white)
              }
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(height: 125)
                    .padding(.trailing, 10)
                    
                Text("Add a photo")
                    .foregroundColor(Color.white)
            }
        }
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(height: 125)
                    .padding(.leading, 10)
                    
                Text("Add a photo")
                    .foregroundColor(Color.white)
            }
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(height: 125)
                    .padding(.trailing, 10)
                    
                Text("Add a photo")
                    .foregroundColor(Color.white)
            }
        }
        VStack {
             TextField("City", text: $composedMessage)
                .frame(minHeight: CGFloat(40))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minHeight: CGFloat(50))
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 20)

             TextField("State", text: $composedMessage)
                .frame(minHeight: CGFloat(40))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minHeight: CGFloat(50))
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
             TextField("County", text: $composedMessage)
                .frame(minHeight: CGFloat(40))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minHeight: CGFloat(50))
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
            TextField("Description", text: $composedMessage)
                .frame(minHeight: CGFloat(40))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minHeight: CGFloat(50))
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
            Text("Submit")
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding(.top, 20)
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
    }
    .navigationBarTitle(Text("Add a Vacation"))
    }
}
