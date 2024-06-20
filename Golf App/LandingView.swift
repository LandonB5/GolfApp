import SwiftUI
import AuthenticationServices

struct LandingView: View {
    @EnvironmentObject private var authenticationService: AuthenticationService
    @State private var isLoading = true
    @State private var isSignedIn = false

    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    ProgressView()
                } else {
                    VStack {
                        Spacer()
                        Text("FourSome")
                            .font(.system(size: 48, weight: .regular, design: .default))
                            .padding(.bottom, 20)
                        Text("Elevate\nYour\nGame")
                            .font(.system(size: 36, weight: .regular, design: .default))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                        
                        if isSignedIn {
                            Button("Sign Out") {
                                Task {
                                    await authenticationService.signOut()
                                    isSignedIn = false
                                }
                            }
                            .font(.system(size: 24, weight: .regular, design: .default))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.bottom, 20)

                            NavigationLink(destination: SecondView()) {
                                Text("Continue")
                                    .font(.system(size: 24, weight: .regular, design: .default))
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                        } else {
                            Button("Get Started!") {
                                Task {
                                    await authenticationService.signIn(presentationAnchor: window)
                                    if authenticationService.isSignedIn {
                                        isSignedIn = true
                                    }
                                }
                            }
                            .font(.system(size: 24, weight: .regular, design: .default))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .navigationBarHidden(true)
                    .opacity(isLoading ? 0.5 : 1)
                    .disabled(isLoading)
                }
            }
            .task {
                isLoading = true
                await authenticationService.fetchSession()
                if authenticationService.isSignedIn {
                    isSignedIn = true
                }
                isLoading = false
            }
        }
    }

    private var window: ASPresentationAnchor {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate,
           let window = delegate.window as? UIWindow {
            return window
        }
        return ASPresentationAnchor()
    }
}

struct SecondView: View {
    var body: some View {
        Text("Welcome to the Second Page")
            .font(.largeTitle)
            .padding()
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().environmentObject(AuthenticationService())
    }
}
