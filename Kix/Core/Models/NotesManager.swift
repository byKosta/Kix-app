import Foundation
import Combine

class NotesManager: ObservableObject {
    @Published var notes: [Note] = [] {
        didSet {
            saveNotes()
        }
    }
    
    private let notesFileName = "notes.json"
    
    init() {
        loadNotes()
    }
    
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
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func saveNotes() {
        let url = getDocumentsDirectory().appendingPathComponent(notesFileName)
        if let encoded = try? JSONEncoder().encode(notes) {
            try? encoded.write(to: url)
        }
    }
    
    private func loadNotes() {
        let url = getDocumentsDirectory().appendingPathComponent(notesFileName)
        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            self.notes = decoded
        }
    }
}
