## CompleteMe

A simple textual autocomplete system, implemented in Ruby, using a [Trie](https://en.wikipedia.org/wiki/Trie)

```ruby
completion = CompleteMe.new

completion.insert("pizza")

completion.count
# => 1

completion.suggest("piz")
# => ["pizza"]

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.count
# => 235886

completion.suggest("piz")
# => ["pizza", "pizzeria", "pizzicato"]
```

### Usage Weighting

```ruby
require "./lib/complete_me"

completion = CompleteMe.new

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.suggest("piz")
# => ["pizza", "pizzeria", "pizzicato"]

completion.select("piz", "pizzeria")

completion.suggest("piz")
# => ["pizzeria", "pizza", "pizzicato"]
```
