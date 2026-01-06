import SwiftUI

struct NotesView: View {
    @StateObject private var notesManager = NotesManager()
    @State private var newNoteText: String = ""
    @State private var editingNote: Note? = nil
    @State private var editingText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Notes")
                    .font(.largeTitle)
                    .padding(.top, 24)
                    .padding(.leading, 16)
                HStack {
                    TextField("Add a note...", text: $newNoteText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityIdentifier("add_note_textfield")
                    Button(action: {
                        guard !newNoteText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        notesManager.addNote(text: newNoteText)
                        newNoteText = ""
                    }) {
                        Image(systemName: "plus")
                            .padding(8)
                            .background(Color.accentGreen)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .accessibilityIdentifier("add_note_button")
                }
                .padding([.horizontal, .bottom])
                if notesManager.notes.isEmpty {
                    Text("No notes yet.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(notesManager.notes) { note in
                            VStack(alignment: .leading, spacing: 4) {
                                if editingNote?.id == note.id {
                                    TextField("Edit note", text: $editingText)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .accessibilityIdentifier("edit_note_textfield_\(note.id)")
                                    HStack {
                                        Button("Save") {
                                            notesManager.updateNote(note, newText: editingText)
                                            editingNote = nil
                                            editingText = ""
                                        }
                                        .accessibilityIdentifier("save_note_button_\(note.id)")
                                        Button("Cancel") {
                                            editingNote = nil
                                            editingText = ""
                                        }
                                        .accessibilityIdentifier("cancel_edit_note_button_\(note.id)")
                                    }
                                } else {
                                    Text(note.text)
                                        .font(.body)
                                    Text(note.date, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    HStack {
                                        Button(action: {
                                            editingNote = note
                                            editingText = note.text
                                        }) {
                                            Image(systemName: "pencil")
                                        }
                                        .accessibilityIdentifier("edit_note_button_\(note.id)")
                                        Button(action: {
                                            notesManager.deleteNote(note)
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                        .accessibilityIdentifier("delete_note_button_\(note.id)")
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { i in
                                let note = notesManager.notes[i]
                                notesManager.deleteNote(note)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    NotesView()
}
