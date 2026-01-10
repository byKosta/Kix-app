import SwiftUI

struct NotesView: View {
    @StateObject private var notesManager = NotesManager()
    @State private var newNoteText = ""
    @State private var editingNote: Note? = nil
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabSelection: TabSelection
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                // Back to Home
                HStack {
                    Button(action: {
                        tabSelection.selectedTab = 0
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                    .accessibilityIdentifier("notes_back_button")
                    .padding(.leading)
                    Spacer()
                }

                // Input row
                HStack(spacing: 8) {
                    TextField("Enter note...", text: $newNoteText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.sentences)
                        .disableAutocorrection(false)
                        .submitLabel(.done)
                        .onSubmit(addOrUpdateNote)
                        .padding(.horizontal)
                        .accessibilityIdentifier("notes_input_field")

                    Button(action: addOrUpdateNote) {
                        Text(editingNote == nil ? "Add" : "Update")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .foregroundColor(.white)
                            .background(
                                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(12)
                            .shadow(color: .purple.opacity(0.25), radius: 6, y: 3)
                    }
                    .disabled(newNoteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(newNoteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
                    .padding(.trailing)
                    .accessibilityIdentifier("notes_add_update_button")
                }

                // Content
                if notesManager.notes.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "note.text")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)
                        Text("Nothing here yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("notes_empty_label")
                        Text("Add notes to test CRUD behavior")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
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
                                .buttonStyle(.plain)
                                .accessibilityIdentifier("notes_delete_\(note.id.uuidString)")
                            }
                            .accessibilityIdentifier("notes_row_\(note.id.uuidString)")
                        }
                        .onDelete { indices in
                            indices.map { notesManager.notes[$0] }.forEach { notesManager.deleteNote($0) }
                        }
                    }
                    .listStyle(PlainListStyle())
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
                        .accessibilityIdentifier("notes_header")
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
