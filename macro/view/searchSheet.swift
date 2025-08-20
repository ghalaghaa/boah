import SwiftUI
import SwiftData
import LocalAuthentication

struct searchSheet: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = JournalViewModel()
    @State var searchText: String = ""
    @State private var showHiddenJournals: Bool = false

    var filteredJournals: [Journal] {
        let base = showHiddenJournals ? viewModel.journals : viewModel.journals.filter { !$0.isHidden }
        return base.filter {
            searchText.isEmpty ||
            $0.title.lowercased().contains(searchText.lowercased()) ||
            $0.journal.lowercased().contains(searchText.lowercased())
        }
        .sorted(by: { $0.modifiedDate > $1.modifiedDate })
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
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
                List {
                    ForEach(filteredJournals, id: \.id) { journal in
                        HStack(alignment: .top, spacing: 12) {
                            Image("book")
                                .resizable()
                                .frame(width: 40, height: 60)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(journal.title)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(.darkerBlue)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(journal.date, formatter: dateFormatter)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.lightGray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("مذكراتي")
        .onAppear {
            viewModel.fetchJournals(context: modelContext)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    authenticateWithFaceID()
                }) {
                    Label("عرض المخفية", systemImage: "lock.open")
                        .labelStyle(.titleAndIcon)
                }
            }
        }
    }

    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "الرجاء استخدام Face ID لعرض المذكرات المخفية"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    if success {
                        showHiddenJournals = true
                    }
                }
            }
        }
    }
}
