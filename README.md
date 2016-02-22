## CompleteMe

A simple textual autocomplete system, implemented in Ruby, using a [Trie](https://en.wikipedia.org/wiki/Trie)

The user can insert words directly with the `.insert` method, and use the `.count` method to see the total number of words loaded into the trie.

```ruby
completion = CompleteMe.new

completion.insert("pizza")

completion.count
# => 1

completion.suggest("piz")
# => ["pizza"]
```

The user can also use the `.populate` method to insert entire files or groups of words.

```ruby

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.count
# => 235886

completion.suggest("piz")
# => ["pizza", "pizzeria", "pizzicato"]

completion.select("piz", "pizzeria")

completion.suggest("piz")
# => ["pizzeria", "pizza", "pizzicato"]
```
