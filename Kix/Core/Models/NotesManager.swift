import Foundation
import Combine

class NotesManager: ObservableObject {
    @Published var notes: [Note] = []
    
    func addNote(text: String) {
        let note = Note(text: text)
        notes.insert(note, at: 0)
    }
    
    func updateNote(_ note: Note, newText: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].text = newText
        }
    }
    
    func deleteNote(_ note: Note) {
        notes.removeAll { $0.id == note.id }
    }
}
