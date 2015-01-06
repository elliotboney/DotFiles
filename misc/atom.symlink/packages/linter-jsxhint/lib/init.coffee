path = require 'path'

module.exports =
  configDefaults:
    #jsxhintExecutablePath: path.join __dirname, '..', 'node_modules', 'jsxhint'
    jsxhintExecutablePath: path.join __dirname, '..', 'node_modules', '.bin'
    use_6to5_transform: false

  activate: ->
    console.log 'activate linter-jsxhint'
