import SwiftUI

struct NotesView: View {
    @StateObject private var notesManager = NotesManager()
    @State private var newNoteText = ""
    @State private var editingNote: Note? = nil
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabSelection: TabSelection
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        // Переключение на вкладку Home
                        tabSelection.selectedTab = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                    .padding(.leading)
                    Spacer()
                }
                HStack {
                    TextField("Enter note...", text: $newNoteText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Button(action: addOrUpdateNote) {
                        Text(editingNote == nil ? "Add" : "Update")
                    }
                    .disabled(newNoteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .padding(.trailing)
                }
                List {
                    ForEach(notesManager.notes) { note in
                        HStack {
                            Text(note.text)
                                .onTapGesture {
                                    editingNote = note
                                    newNoteText = note.text
                                }
                            Spacer()
                            Button(action: {
                                notesManager.deleteNote(note)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Notes")
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .italic()
                        .foregroundStyle(
                            LinearGradient(colors: [.blue, .purple, .pink], startPoint: .leading, endPoint: .trailing)
                        )
                }
            }
        }
    }
    
    private func addOrUpdateNote() {
        let trimmedText = newNoteText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        if let note = editingNote {
            notesManager.updateNote(note, newText: trimmedText)
            editingNote = nil
        } else {
            notesManager.addNote(text: trimmedText)
        }
        newNoteText = ""
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView().environmentObject(TabSelection())
    }
}
