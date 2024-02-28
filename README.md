# Crystal Lang Learning

## Some Links

- https://www.slideshare.net/crystallanguage/crystal-internals-part-1-70673255
- https://www.slideshare.net/crystallanguage/crystal-presentation-at-recurse-center-ny
- https://lbarasti.com/post/json_beyond_basics
- https://lbarasti.com/post/select_statement


## Enumerable/Iterable

```mermaid
classDiagram
class Enumerable["Enumerable(T)"] {
    << module >>
}
link Enumerable "https://crystal-lang.org/api/master/Enumerable.html"

class Iterable["Iterable(T)"] {
    << module >>
}
link Iterable "https://crystal-lang.org/api/master/Iterable.html"

class Indexable["Indexable(T)"] {
    << module >>
}
link Indexable "https://crystal-lang.org/api/master/Indexable.html"

class Indexable_Mutable["Indexable::Mutable(T)"] {
    << module >>
}
link Indexable_Mutable "https://crystal-lang.org/api/master/Indexable/Mutable.html"

class Array["Array(T)"] {
    << class >>
}
link Array "https://crystal-lang.org/api/master/Array.html"

class StaticArray["StaticArray(T,N)"] {
    << struct >>
}
link StaticArray "https://crystal-lang.org/api/master/StaticArray.html"

class BitArray["BitArray"] {
    << struct >>
}
link BitArray "https://crystal-lang.org/api/master/BitArray.html"

class Deque["Deque(T)"] {
    << class >>
}
link Deque "https://crystal-lang.org/api/master/Deque.html"

class Slice["Slice(T)"] {
    << struct >>
}
link Slice "https://crystal-lang.org/api/master/Slice.html"

class Range["Range(B,E)"] {
    << struct >>
}
link Range "https://crystal-lang.org/api/master/Range.html"

class Hash["Hash(K,V)"] {
    << class >>
}
link Hash "https://crystal-lang.org/api/master/Hash.html"

class Set["Set(T)"] {
    << struct >>
}
link Set "https://crystal-lang.org/api/master/Set.html"

class Dir["Dir"] {
    << class >>
}
link Dir "https://crystal-lang.org/api/master/Dir.html"

class Tuple["Tuple(*T)"] {
    << struct >>
}
link Tuple "https://crystal-lang.org/api/master/Tuple.html"

Enumerable <|-- Indexable : include
Iterable <|-- Indexable : include
Indexable <|-- Indexable_Mutable : include
Indexable <|-- Tuple : include
Indexable_Mutable <|-- Array : include
Indexable_Mutable <|-- StaticArray : include
Indexable_Mutable <|-- BitArray : include
Indexable_Mutable <|-- Deque : include
Indexable_Mutable <|-- Slice : include
Enumerable <|-- Hash : include
Enumerable <|-- Set : include
Enumerable <|-- Range : include
Enumerable <|-- Dir : include
Iterable <|-- Hash : include
Iterable <|-- Set : include
Iterable <|-- Range : include
Iterable <|-- Dir : include
```
