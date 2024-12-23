//
//  FullscreenView.swift
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

struct FullscreenView: View {
    
    typealias ViewModel = FullscreenViewModel
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            
            Color.blue.ignoresSafeArea()
            
            VStack {
                Text("Hello, FullscreenView!")
                    .font(.largeTitle)
                
                VStack {
                    Button("Presents FullscreenView") {
                        Task { await viewModel.presentFullscreen() }
                    }.buttonStyle(.borderedProminent)
                    
                    Button("Presents SheetView") {
                        Task { await viewModel.presentSheetView() }
                    }.buttonStyle(.borderedProminent)
                    
                    Button("Presents DetentsView") {
                        Task { await viewModel.presentDetentsView() }
                    }.buttonStyle(.borderedProminent)
                    
                    Button("Close view") {
                        Task { await viewModel.close() }
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    FullscreenView(viewModel: .init(coordinator: .init()))
}
