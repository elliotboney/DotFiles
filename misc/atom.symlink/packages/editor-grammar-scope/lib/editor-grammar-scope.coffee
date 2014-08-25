module.exports =
  activate: ->
    new EditorGrammarScope()

class EditorGrammarScope
  constructor: ->
    @editorGrammars = {}
    atom.workspaceView.on 'editor:attached', @_alterEditorClass
    atom.workspaceView.on 'editor:grammar-changed', @_alterEditorClass
  
  _alterEditorClass: (event) =>
    view = atom.workspaceView.getActiveView()
    if view? and view.editor
      {editor} = view
      grammar = editor.getGrammar()
      if previousGrammar = @editorGrammars[view]
        view.removeClass @_classFromGrammar(previousGrammar)
      
      view.addClass @_classFromGrammar(grammar)
      @editorGrammars[view] = grammar
  
  _classFromGrammar: (grammar) ->
    grammar.scopeName.replace /\./g, '-'
