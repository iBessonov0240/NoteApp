import SwiftUI

struct Main: View {

    // MARK: - Property

    @ObservedObject var presenter: MainPresenter

    // MARK: - View

    var body: some View {
        NavigationStack {
            VStack {

                Text("Задачи")
                    .foregroundColor(ColorManager().white)
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 15)

                TextField("", text: $presenter.text)
                    .padding(.vertical, 10)
                    .padding(.leading, 40)
                    .background(ColorManager().gray)
                    .foregroundColor(ColorManager().white)
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(ColorManager().whiteAlpha)
                                .padding(.leading, 6)

                            if presenter.text.isEmpty {
                                Text("Search")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(ColorManager().whiteAlpha)
                                    .padding(.leading, 3)
                            }

                            Spacer()

                            Button {
                                // TODO: - Add speaker
                            } label: {
                                Image("microphone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 17, height: 22)
                                    .padding(8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()

                            Button {
                                UIApplication.shared.sendAction(
                                    #selector(UIResponder.resignFirstResponder),
                                    to: nil,
                                    from: nil,
                                    for: nil
                                )
                            } label: {
                                Text("Done")
                                    .foregroundStyle(ColorManager().white)
                            }
                        }
                    }

                List {
                    ForEach(presenter.filteredNotes) { note in
                        MainListCell(
                            title: note.todo,
                            description: note.description,
                            date: note.timestemp,
                            completed: note.completed
                        )
                        .listRowInsets(EdgeInsets())
                        .contentShape(Rectangle())
                        .onTapGesture {
                            presenter.didSelectNote(note)
                        }
                        .listRowSeparator(.hidden)
                        .contextMenu {
                            Button {
                                presenter.didSelectNote(note)
                            } label: {
                                Label("Редактировать", image: "edit")
                            }

                            Button {
                                presenter.selectedNote = note
                                presenter.isShareSheetPresented = true
                            } label: {
                                Label("Поделиться", image: "export")
                            }

                            Button(role: .destructive) {
                                presenter.deleteNote(note)
                            } label: {
                                Label("Удалить", image: "trash")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let note = presenter.filteredNotes[index]
                            presenter.deleteNote(note)
                        }
                    }
                }
                .sheet(isPresented: $presenter.isShareSheetPresented) {
                    if let note = presenter.selectedNote {
                        ShareSheet(activityItems: [note.todo ?? "No title", note.description ?? "Description"])
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.visible)
                    }
                }
                .scrollContentBackground(.hidden)
                .padding(.top, 16)
                .padding(.bottom, 25)
                .scrollIndicators(.hidden)
                .listStyle(.plain)

                Spacer()

                HStack {

                    Text("\(presenter.notes.count) задач")
                        .foregroundColor(ColorManager().white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.leading, 68)

                    Button(action: {
                        presenter.addNote()
                    }) {
                        Image("newNote")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 68, height: 28)
                    }
                }
                .padding(.horizontal)
                .frame(height: 49)
                .background(ColorManager().gray)
            }
            .navigationDestination(
                isPresented: $presenter.isDetailPresented
            ) {
                presenter.navigateToDetail()
            }
            .background(ColorManager().background)
            .onAppear {
                if presenter.isFirstLaunch {
                    Task {
                        await presenter.fetchNotesFromAPI()
                    }
                    presenter.isFirstLaunch = false
                }
                presenter.loadNotes()
            }
        }
    }
}

#Preview {
    Main(presenter: MainPresenter(interactor: MainInteractor(persistenceController: PersistenceController.shared), router: MainRouter()))
}
