//
//  ActionListView.swift
//
//  Copyright (c) Andres F. Lozano
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import SwiftUI

struct NavigationActionListView: View {
    
    typealias ViewModel = ActionListViewModel
    
    @Environment(\.isPresented) private var isPresented
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Button("Push NavigationView") {
                Task { await viewModel.navigateToPushView() }
            }
            
            Button("Presents SheetView") {
                Task { await viewModel.presentSheet() }
            }
            
            Button("Presents FullscreenView") {
                Task { await viewModel.presentFullscreen() }
            }
            
            Button("Presents DetentsView") {
                Task { await viewModel.presentDetents() }
            }
            
            Button("present view with custom presentation") {
                Task { await viewModel.presentViewWithCustomPresentation() }
            }
            
            Button("Presents Tabbar Coordinator") {
                Task { await viewModel.presentTabbarCoordinator() }
            }
        }
        .toolbar {
            if isPresented && viewModel.showFinishButton() {
                Button {
                    Task { await viewModel.finish() }
                } label: {
                    Text("Finish flow")
                }
            }
        }
        .navigationTitle("Navigation Action List")
    }
}

#Preview {
    NavigationActionListView(viewModel: .init(coordinator: .init()))
}
