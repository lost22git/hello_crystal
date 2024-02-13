#!/usr/bin/env crystal

def __(t : String)
  puts ""
  puts "------\e[1;33m " + t + " \e[m" + ("-" * (50 - 8 - t.size))
  puts ""
end

__ "referenced ptr"

class Book
  property name : String
  property price : Float32

  def initialize(@name, @price)
  end
end

book = Book.new "fo", 23

p! instance_sizeof(Book)  # (TYPEID 4 + padding 4) + name 8 + price 4 + padding 4
p! offsetof(Book, @name)  # 8
p! offsetof(Book, @price) # 16

p! pointerof(book).address # 变量 book 在 stack 中的地址
p! book.object_id          # heap 中的地址 (变量 book 的值)
p! book.object_id == book.unsafe_as(UInt64)
p! book.object_id == book.as(Pointer(Book)).address

p! Pointer(Float32).new(book.unsafe_as(UInt64) + offsetof(Book, @price)).value
Pointer(Float32).new(book.unsafe_as(UInt64) + offsetof(Book, @price)).value = 33
p! Pointer(Float32).new(book.unsafe_as(UInt64) + offsetof(Book, @price)).value
