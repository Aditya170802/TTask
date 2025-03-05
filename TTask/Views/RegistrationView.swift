import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: $viewModel.name)
                        .autocapitalization(.words)
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    TextField("Age", text: $viewModel.age)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: viewModel.submitRegistration) {
                        HStack {
                            Text("Register")
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(!viewModel.isFormValid || viewModel.isLoading)
                    .buttonStyle(.borderedProminent)
                }
                
                
                if let errorMessage = viewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("User Registration")
            .alert(isPresented: $viewModel.registrationSuccess) {
                Alert(
                    title: Text("Success"),
                    message: Text("Registration completed successfully!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    RegistrationView()
}
