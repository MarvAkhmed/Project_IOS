//
//  DetailView.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 26/05/2024.
//
import SwiftUI


class DetailViewModel: ObservableObject {
    @Published var car: Car
    @Published var isLiked: Bool
    
    init(car: Car, isLiked: Bool = false) {
        self.car = car
        self.isLiked = isLiked
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: DetailViewModel
    @State private var isLiked: Bool
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        _isLiked = State(initialValue: viewModel.isLiked)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.car.model.rawValue)
                .font(.title)
                .padding()

            Text("Color: \(viewModel.car.color.rawValue.capitalized)")
                .padding()

            Text("Price: \(viewModel.car.price) / month")
                .padding()

            Text("Rating: \(viewModel.car.rating) / 5")
                .padding()

            if let imageURL = URL(string: viewModel.car.avatar) {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .padding()
            }
            
            Spacer()
            
            Button(action: {
                isLiked.toggle()
                viewModel.isLiked = isLiked
            }) {
                Text(isLiked ? "Unlike" : "Like")
            }
            .padding()
            
            Button("Back To the Store") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .padding()
    }
}
