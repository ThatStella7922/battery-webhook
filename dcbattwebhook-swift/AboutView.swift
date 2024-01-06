//
//  AboutView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI

struct AboutView: View {
    @State private var isShowingDebugSheet = false
    
    var body: some View {
        VStack {
            VStack {

                Form {
                    #if os(watchOS)
                    Section(header: Text("Info"), footer: Text("Battery Webhook - send your battery info to popular services using webhooks!")) {
                        VStack {
                            HStack{
                                Image("icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 40)
                                    .padding(.bottom, 5)
                                    .onTapGesture(count: 5, perform: {
                                        isShowingDebugSheet = true
                                    })
                                Text(prodName).font(.title3)
                                    .padding()
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .minimumScaleFactor(0.7)
                            }
                            Text("Version " + version)
                            Text("with 💜 by ThatStella7922").padding(.bottom, 5)
                        }.multilineTextAlignment(.center)
                    }
                    #else
                    Section(header: Text("Info"), footer: Text("Battery Webhook - send your battery info to popular services using webhooks!")) {
                        VStack{
                            Image("icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 80)
                                .padding(.bottom, 5)
                                .onTapGesture(count: 5, perform: {
                                    isShowingDebugSheet = true
                                })
                            Text(prodName).font(.title)
                            Text("Version " + version)
                            Text("with 💜 by ThatStella7922").frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    #endif
                    
                    #if os(tvOS) || os(watchOS)
                    Section(header: Text("Battery Webhook on GitHub"), footer: Text("Visit the About page of Battery Webhook from an iOS, iPadOS or macOS device to view the link.")) {
                        Text("Source code, contributions, bug reports, feature requests and more. All on the project's GitHub repository.")
                    }
                    #else
                    Section(header: Text("Battery Webhook on GitHub"), footer: Text("Source code, contributions, bug reports, feature requests and more. All on the project's GitHub repository.")) {
                        Link("View Source on GitHub", destination: URL(string: "https://github.com/ThatStella7922/battery-webhook")!)
                    }
                    #endif
                    
                    #if os(tvOS) || os(watchOS)
                    EmptyView()
                    #else
                    Section(header: Text("ThatStella7922's Links")) {
                        Link("Website", destination: URL(string: "https://thatstel.la")!)
                        Link("Twitter", destination: URL(string: "https://twitter.com/ThatStella7922")!)
                        Link("GitHub", destination: URL(string: "https://github.com/ThatStella7922")!)
                    }
                    #endif
                }
                #if os(macOS)
                .formStyle(.grouped)
                #endif
            }
        }
        .navigationTitle("About")
        .onAppear() {
            
        }.sheet(isPresented: $isShowingDebugSheet, content: {
            DebugView()
            Button {
                self.isShowingDebugSheet = false
            } label: {
                Text("Done").font(.title3)
            }.padding()
        })
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
