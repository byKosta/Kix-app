import Foundation
import Combine

struct NoteItem: Identifiable, Codable, Equatable {
    var id: UUID
    var text: String
    var date: Date
    var isPinned: Bool = false
}

class NotesManager: ObservableObject {
    @Published var notes: [NoteItem] = []
    
    private let storageKey = "notes_storage_key"
    
    init() {
        load()
        sortNotes()
    }
    
    func addNote(text: String) {
        let note = NoteItem(id: UUID(), text: text, date: Date())
        notes.insert(note, at: 0)
        sortNotes()
        save()
    }
    
    func updateNote(_ note: NoteItem, newText: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].text = newText
            notes[index].date = Date()
            sortNotes()
            save()
        }
    }
    
    func deleteNote(_ note: NoteItem) {
        notes.removeAll { $0.id == note.id }
        sortNotes()
        save()
    }
    
    func togglePin(_ note: NoteItem) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isPinned.toggle()
            sortNotes()
            save()
        }
    }
    
    private func sortNotes() {
        notes.sort { lhs, rhs in
            if lhs.isPinned != rhs.isPinned { return lhs.isPinned && !rhs.isPinned }
            return lhs.date > rhs.date
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            #if DEBUG
            assertionFailure("Failed to save notes: \(error)")
            #else
            print("Failed to save notes: \(error)")
            #endif
        }
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            let saved = try JSONDecoder().decode([NoteItem].self, from: data)
            self.notes = saved
            sortNotes()
        } catch {
            #if DEBUG
            assertionFailure("Failed to load notes: \(error)")
            #else
            print("Failed to load notes: \(error)")
            #endif
        }
    }
}
