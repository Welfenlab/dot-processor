# more-markdown / dot-processor

A plugin for `more-markdown` that renders graphs in dot notation.

# Installation

You first need a [more-markdown](https://github.com/Welfenlab/more-markdown) setup.
Then you can install it via:

```
npm install @more-markdown/dot-processor
```

# Usage

```
var moreMarkdown = require('more-markdown');
var dotProcessor = require('@more-markdown/dot-processor');

// create a processor that writes the final html
// to the element with the id 'output'
var proc = moreMarkdown.create('output', processors: [dotProcessor]);

proc.render("```dot" +
"digraph graphname {"+
"      a -> b -> c;"+
"      b -> d;" +
"}"+
"```");
```
