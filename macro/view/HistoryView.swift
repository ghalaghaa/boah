import SwiftUI
import SwiftData

struct hestory: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = JournalHistoryViewModel()
    
    var filteredJournals: [Journal] {
        viewModel.journals
            .filter { !$0.isHidden }
            .sorted { $0.modifiedDate > $1.modifiedDate }
    }

    @State var showSearchSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    Color.bg.ignoresSafeArea(edges: .all)
                    
                    VStack {
                        if filteredJournals.isEmpty {
                            HStack {
                                Spacer()
                                VStack(alignment: .center, spacing: 14) {
                                    Image("bookIcon")
                                    Text("لا يوجد لديك أي مذكرات")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.darkBlue)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        } else {
                            VStack(alignment: .leading, spacing: 14) {
                                ForEach(0..<(filteredJournals.count + 1) / 2, id: \.self) { rowIndex in
                                    VStack(spacing: 8) {
                                        HStack {
                                            let leftIndex = rowIndex * 2
                                            
                                            NavigationLink(destination: readJournal(journal: filteredJournals[leftIndex])) {
                                                ZStack {
                                                    Image("book")
                                                        .resizable()
                                                        .frame(width: 91, height: 133)
                                                        .shadow(radius: 5)
                                                    
                                                    Text(filteredJournals[leftIndex].title)
                                                        .font(.system(size: 12, weight: .bold))
                                                        .foregroundColor(.background)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                        .minimumScaleFactor(0.5)
                                                        .frame(width: 70, height: 133, alignment: .center)
                                                }
                                            }
                                            .padding(.leading, 16)
                                            
                                            Spacer()
                                            
                                            if leftIndex + 1 < filteredJournals.count {
                                                NavigationLink(destination: readJournal(journal: filteredJournals[leftIndex + 1])) {
                                                    ZStack {
                                                        Image("book")
                                                            .resizable()
                                                            .frame(width: 91, height: 133)
                                                            .shadow(radius: 5)
                                                        
                                                        Text(filteredJournals[leftIndex + 1].title)
                                                            .font(.system(size: 12, weight: .bold))
                                                            .foregroundColor(.background)
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(2)
                                                            .minimumScaleFactor(0.5)
                                                            .frame(width: 70, height: 133, alignment: .center)
                                                    }
                                                }
                                                .padding(.trailing, 16)
                                            }
                                        }
                                        .offset(y: 16)
                                        .padding(.horizontal)
                                        
                                        Image("rec")
                                            .shadow(radius: 5)
                                            .frame(width: 366, height: 20)
                                    }
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("مذكراتي")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.darkerBlue)
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showSearchSheet = true
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.lavender)
                            }
                            .sheet(isPresented: $showSearchSheet) {
                                NavigationStack {
                                    searchSheet()
                                }
                            }
                        }
                    }
                    .background(Color.bg)
                }
            }
            .onAppear {
                viewModel.fetchJournals(context: modelContext)
            }
        }
    }
}

#Preview {
    hestory()
}
