import SwiftUI
import SwiftData

struct hasJournal: View {
    @State private var navigateToWriting = false
    @State private var navigateToHistory = false
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = JournalViewModel()
    
    var visibleJournals: [Journal] {
        viewModel.journals
            .filter { !$0.isHidden }
            .sorted { $0.modifiedDate > $1.modifiedDate }
    }

    var smallJournals: [Journal] {
        if visibleJournals.count == 1 {
            return Array(repeating: visibleJournals[0], count: 2)
        } else {
            return Array(visibleJournals.dropFirst().prefix(2))
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.bg.ignoresSafeArea()

                VStack(spacing: 5) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 27, height: 27)
                                .foregroundColor(Color.lavender)
                        }
                        .padding()
                        Spacer()
                        Button(action: { navigateToWriting = true }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 27, height: 27)
                                .foregroundColor(Color.lavender)
                                .padding()
                        }
                        NavigationLink(destination: writingScreen(), isActive: $navigateToWriting) {
                            EmptyView()
                        }
                    }

                    HStack {
                        Text("حديثاً")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.darkerBlue)
                            .padding()
                        Spacer()
                    }

                    Spacer()

                    if let latest = visibleJournals.first {
                        HStack {
                            Spacer()
                            NavigationLink(destination: readJournal(journal: latest)) {
                                ZStack {
                                    Image("book")
                                        .resizable()
                                        .frame(width: 205, height: 298)
                                        .foregroundColor(Color.lavender)
                                        .padding(.bottom, 30)

                                    Spacer()
                                    Text(latest.title)
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 150, height: 150)
                                }
                            }
                            Spacer()
                        }
                    }

                    HStack {
                        Text("مذكراتي")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.darkerBlue)
                            .padding()
                        Spacer()
                        Button(action: { navigateToHistory = true }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 10, height: 19)
                                .foregroundColor(Color.gray1)
                                .padding()
                        }
                        NavigationLink(destination: hestory(), isActive: $navigateToHistory) {
                            EmptyView()
                        }
                    }

                    Spacer()

                    if !visibleJournals.isEmpty {
                        ZStack {
                            Image("rec")
                                .shadow(radius: 5)

                            HStack(spacing: 40) {
                                ForEach(smallJournals, id: \.modifiedDate) { journal in
                                    NavigationLink(destination: readJournal(journal: journal)) {
                                        ZStack {
                                            Image("book")
                                                .resizable()
                                                .frame(width: 100, height: 133)
                                                .foregroundColor(Color.gray1)
                                                .padding()

                                            Spacer()
                                            Text(journal.title)
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                                .minimumScaleFactor(0.5)
                                                .frame(width: 70, height: 100)
                                        }
                                    }
                                }
                            }
                            .offset(y: -73)
                        }
                        .padding(.top, 40)
                    }

                    Spacer()
                }
            }
            .onAppear {
                viewModel.fetchJournals(context: modelContext)
            }
        }
    }
}

#Preview {
    hasJournal()
}
