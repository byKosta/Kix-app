import SwiftUI

struct NotesView: View {
    @StateObject private var notesManager = NotesManager()
    @State private var newNoteText: String = ""
    @State private var editingNote: NoteItem? = nil
    @State private var editingText: String = ""
    @State private var searchText: String = ""

    private var filteredNotes: [NoteItem] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty { return notesManager.notes }
        return notesManager.notes.filter { $0.text.localizedCaseInsensitiveContains(query) }
    }
    private var pinnedNotes: [NoteItem] {
        filteredNotes.filter { $0.isPinned }
    }
    private var regularNotes: [NoteItem] {
        filteredNotes.filter { !$0.isPinned }
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Add a note...", text: $newNoteText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityIdentifier("add_note_textfield")
                    Button(action: {
                        let text = newNoteText.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !text.isEmpty else { return }
                        notesManager.addNote(text: text)
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

                if filteredNotes.isEmpty {
                    Text("No notes yet.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        if !pinnedNotes.isEmpty {
                            Section("Pinned") {
                                ForEach(pinnedNotes) { note in
                                    noteRow(note)
                                }
                            }
                        }
                        Section("All Notes") {
                            ForEach(regularNotes) { note in
                                noteRow(note)
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { i in
                                    let note = regularNotes[i]
                                    notesManager.deleteNote(note)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let text = newNoteText.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !text.isEmpty else { return }
                        notesManager.addNote(text: text)
                        newNoteText = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .accessibilityIdentifier("add_note_toolbar_button")
                }
            }
            .searchable(text: $searchText, prompt: "Search notes")
            .sheet(item: $editingNote) { note in
                NoteEditView(note: note, text: $editingText) { newText in
                    notesManager.updateNote(note, newText: newText)
                }
            }
        }
    }

    @ViewBuilder
    private func noteRow(_ note: NoteItem) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.text)
                .font(.body)
            HStack(spacing: 8) {
                if note.isPinned {
                    Image(systemName: "pin.fill").foregroundColor(.orange)
                }
                Text(note.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                notesManager.deleteNote(note)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            Button {
                editingNote = note
                editingText = note.text
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
            Button {
                notesManager.togglePin(note)
            } label: {
                Label(note.isPinned ? "Unpin" : "Pin", systemImage: note.isPinned ? "pin.slash" : "pin")
            }
            .tint(.orange)
        }
    }
}

struct NoteEditView: View {
    let note: NoteItem
    @Binding var text: String
    var onSave: (String) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $text)
                    .padding()
            }
            .navigationTitle("Edit Note")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let t = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !t.isEmpty else { dismiss(); return }
                        onSave(t)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    NotesView()
}
