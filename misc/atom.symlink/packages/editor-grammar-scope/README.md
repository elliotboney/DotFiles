# editor-grammar-scope package

Themes in Atom assume that there will be one background color for all files, no matter the selected grammar. Some people don't mind that, but I do.

This package adds a class to the editor view element to allow for better styling of themes.

### Example

Without this package, the editor will generally have an HTML class attribute equal to `"editor editor-colors"`.

With this package enabled, selecting the grammar "Ruby" will cause the editor to have `"editor editor-colors source-ruby"`.

### Class names

The class name added to the editor view is the `Grammar#scopeName` with all periods replaced with `-`.

So, the Ruby grammar object has a `scopeName` of "source.ruby", which is added as "source-ruby" to the editor-view class attribute.
