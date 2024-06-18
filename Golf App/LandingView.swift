import SwiftUI
import AuthenticationServices

struct LandingView: View {
    @EnvironmentObject private var authenticationService: AuthenticationService
    @State private var isLoading = true

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
                        if authenticationService.isSignedIn {
                            NavigationLink(destination: NotesView()) {
                                Text("Get Started!")
                                    .font(.system(size: 24, weight: .regular, design: .default))
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                        } else {
                            Button("Sign in") {
                                Task {
                                    await authenticationService.signIn(presentationAnchor: window)
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
                    .background(Color.green)
                    .navigationBarHidden(true)
                    .opacity(isLoading ? 0.5 : 1)
                    .disabled(isLoading)
                }
            }
            .task {
                isLoading = true
                await authenticationService.fetchSession()
                if !authenticationService.isSignedIn {
                    await authenticationService.signIn(presentationAnchor: window)
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



struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().environmentObject(AuthenticationService())
    }
}
