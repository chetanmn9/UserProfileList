//
//  UserListView.swift
//  UserList

import SwiftUI
import Foundation

struct UserListView: View {
    @StateObject var viewModel: UserListViewModel
    let useCase: ImageFetcherUseCase
    
    let fixedWidth: CGFloat = 150 // Adjust as needed
    let gridItemHeight: CGFloat = 190 // Fixed height
    let horizontalTileSpacing: CGFloat = 30 // Increased horizontal spacing between tiles
    let verticalTileSpacing: CGFloat = 20
    
    let columns: [GridItem] = [
        GridItem(.fixed(160), spacing: 30), // First column with fixed width
        GridItem(.fixed(160), spacing: 30)  // Second column with fixed width
    ]
    
    init(viewModel: UserListViewModel,
         useCase: ImageFetcherUseCase) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.useCase = useCase
        }
        
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: verticalTileSpacing) {
                    if let users = viewModel.user?.user {
                        ForEach(users) { user in
                            VStack(alignment: .center, spacing: 2) {
                                if let url = URL(string: user.avatar) {
                                    let viewModel = ImageViewModel(url: url, useCase: useCase)
                                    ImageView(viewModel: viewModel)
                                }
                                name(firstName: user.firstName, lastName: user.lastName)
                                email(email: user.email)
                            }
                            .frame(width: fixedWidth, height: gridItemHeight)
                            .padding(12)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                    }
                }
                .navigationTitle("User Directory")
            }
            .task {
                await viewModel.fetchUser()
            }
        }
    }
    
    private func name(firstName: String, lastName: String) -> some View {
        Text("\(firstName) \(lastName)")
            .font(.headline)
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }
    
    private func email(email: String) -> some View {
        Text(email)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }

}
