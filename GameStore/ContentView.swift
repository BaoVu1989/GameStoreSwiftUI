//
//  ContentView.swift
//  GameStore
//
//  Created by Bao Vu on 7/7/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var search = ""
    @State var index = 0
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                HStack{
                    Text("Game Store")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal)
                
                // This is a Search Bar.....
                
                TextField("Search", text: self.$search)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(10)
                    .padding(.horizontal)
                // Carousel List...
                
                TabView(selection: self.$index){
                    ForEach(0...4, id:\.self){index in
                         Image("g\(index)")
                            .resizable()
                            // adding animation...
                            .frame(height: self.index == index ? 230 : 180)
                                    .cornerRadius(15)
                                    .padding(.horizontal)
                        // for identifying current index...
                                    .tag(index)
                    }
                }.frame(height: 230)
                .padding(.top)
                .tabViewStyle(PageTabViewStyle())
                .animation(.easeOut)
                
                // Adding custom Grid....
                HStack{
                    Text("Popular")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Button(action: {
                        
                        // reducing to row....
                        
                        withAnimation(.easeOut) {
                            if self.columns.count == 2 {
                                
                                self.columns.removeLast()
                            }else{
                                self.columns.append(GridItem(.flexible(), spacing: 15))
                            }
                        }
                    }, label: {
                        Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    })
                }.padding(.horizontal)
                .padding(.top, 10)
                
                LazyVGrid(columns: self.columns, spacing: 25){
                    
                    ForEach(data){game in
                        
                        // GridView....
                        GridView(game: game,columns: self.$columns)
                    }
                }.padding([.horizontal,.top])
                
            }.padding(.vertical)
        }.background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))
    }
}
//GridView....

struct GridView : View {
    
    var game : Game
    @Binding var columns: [GridItem]
    
    var body: some View{
        
        VStack{
            if self.columns.count == 2 {
                VStack{
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        Image(game.image)
                            .resizable()
                            .frame(height: 250)
                            .cornerRadius(15)
                        
                        Button{
                            
                        } label: {
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.all, 10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }.padding(.all, 10)
                    }
                    
                    Text(game.name)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Buy Now")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }
            }else{
               // Row View.....
               // Adding animation
                HStack(spacing: 15){
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        Image(game.image)
                            .resizable()
                            .frame(height: 250)
                            .cornerRadius(15)
                        
                        Button{
                            
                        } label: {
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.all, 10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }.padding(.all, 10)
                    }
                    VStack(alignment: .leading, spacing: 10){
                        Text(game.name)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                        // Rating Bar...
                        
                        HStack(spacing: 10){
                            
                            ForEach(1...5, id: \.self){rating in
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(self.game.rating >= rating ? .yellow : .gray)
                            }
                            Spacer(minLength: 0)
                        }
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Buy Now")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .background(Color.red)
                                .cornerRadius(10)
                        })
                        .padding(.top, 10)
                        Spacer(minLength: 0)
                    }
                }
            }
        }
    }
}
// sample Data Mode...

struct Game: Identifiable{
    
    var id: Int
    var name: String
    var image: String
    var rating: Int
}

var data = [
   Game(id: 0, name: "Call of Duty", image: "g0", rating: 3),
   Game(id: 1, name: "Fifa", image: "g1", rating: 4),
   Game(id: 2, name: "Warcraft", image: "g2", rating: 2),
   Game(id: 3, name: "War World Z", image: "g3", rating: 5),
   Game(id: 4, name: "Pubgi", image: "g4", rating: 3),
]
