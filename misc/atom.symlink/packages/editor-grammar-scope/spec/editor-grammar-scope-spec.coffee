path = require 'path'
{WorkspaceView} = require 'atom'

EditorGrammarScope = require '../lib/editor-grammar-scope'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'EditorGrammarScope', ->
  [editor, editorView, textGrammar, jsGrammar] =  []
  
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model
    
    waitsForPromise ->
      atom.packages.activatePackage('editor-grammar-scope')
      atom.packages.activatePackage('language-text')
      atom.packages.activatePackage('language-javascript')
    
    runs ->
      atom.workspaceView.openSync('sample.js')
      editorView = atom.workspaceView.getActiveView()
      {editor} = editorView
      textGrammar = atom.syntax.grammarForScopeName('text.plain')
      expect(textGrammar).toBeTruthy()
      jsGrammar = atom.syntax.grammarForScopeName('source.js')
      expect(jsGrammar).toBeTruthy()
      expect(editor.getGrammar()).toBe jsGrammar
  
  describe 'upon editor attachment', ->
    it 'assigns the correct grammar scope', ->
      expect(editorView.hasClass('source-js')).not.toBeTruthy()
      editorView.trigger('editor:attached')
      expect(editorView.hasClass('source-js')).toBeTruthy()
  
  describe 'upon grammar change', ->
    beforeEach ->
      editorView.trigger('editor:attached')
    
    it 'assigns the correct grammar scope', ->
      expect(editorView.hasClass('source-js')).toBeTruthy()
      expect(editorView.hasClass('text-plain')).not.toBeTruthy()
      
      editor.setGrammar textGrammar
      
      expect(editorView.hasClass('source-js')).not.toBeTruthy()
      expect(editorView.hasClass('text-plain')).toBeTruthy()
