#!/usr/bin/env crystal

def __(t : String)
  puts ""
  puts "------\e[1;33m " + t + " \e[m" + ("-" * (50 - 8 - t.size))
  puts ""
end

__ "primitive types (Value Type)"

p! sizeof(Bool)
p! alignof(Bool)

p! sizeof(Char) # UTF-8 4
p! alignof(Char)

p! sizeof(Int)
p! alignof(Int)

p! sizeof(Int32)
p! alignof(Int32)
p! sizeof(UInt32)
p! alignof(UInt32)

p! sizeof(Int8)
p! alignof(Int8)
p! sizeof(UInt8)
p! alignof(UInt8)

p! sizeof(Int16)
p! alignof(Int16)
p! sizeof(UInt16)
p! alignof(UInt16)

p! sizeof(Int64)
p! alignof(Int64)
p! sizeof(UInt64)
p! alignof(UInt64)

p! sizeof(Int128)
p! alignof(Int128)
p! sizeof(UInt128)
p! alignof(UInt128)

p! sizeof(Float)
p! alignof(Float)
p! sizeof(Float32)
p! alignof(Float32)
p! sizeof(Float64)
p! alignof(Float64)

__ "String (Referenced Type)"

p! sizeof(String) # ptr
p! alignof(String)
p! instance_sizeof(String)
p! instance_alignof(String)

__ "Array (Referenced Type)"

p! sizeof(Array(Int32)) # ptr
p! alignof(Array(Int32))
p! instance_sizeof(Array(Int32))
p! instance_alignof(Array(Int32))

__ "StaticArray (Value Type)"

p! sizeof(StaticArray(Int32, 2)) # 4 * 2
p! alignof(StaticArray(Int32, 2))

__ "Hash (Referenced Type)"

p! sizeof(Hash(String, Int32)) # ptr
p! alignof(Hash(String, Int32))
p! instance_sizeof(Hash(String, Int32))
p! instance_alignof(Hash(String, Int32))

__ "Set (Value Type)"

p! sizeof(Set(String)) # ptr to Hash(String,Nil)
p! alignof(Set(String))

__ "Tuple (Value Type)"

p! sizeof(Tuple(Int32, Int32, Int32)) # 4 * 3
p! alignof(Tuple(Int32, Int32, Int32))

__ "NamedTuple (Value Type)"

p! sizeof(NamedTuple(name: String, age: UInt8)) # name 8 + age 1 + padding 7
p! alignof(NamedTuple(name: String, age: UInt8))

__ "Range (Value Type)"

p! sizeof(Range(Int32, Int32)) # begin 4 + end 4 + exclusive 1 + padding 3
p! alignof(Range(Int32, Int32))

__ "Slice (Value Type)"

p! sizeof(Slice(String)) # ptr + len
p! alignof(Slice(String))

__ "Enum (Value Type)"

enum Lang
  Crystal
  Nim
  Zig
end

p! sizeof(Lang) # 4 UInt32
p! alignof(Lang)

enum Color : UInt8
  Red
  Blue
  Green
end

p! sizeof(Color) # 1 UInt8
p! alignof(Color)

# struct (Value Type)

struct UserStruct
  @id : UInt32
  @name : String
  @balance : UInt32

  def initialize(@id : UInt32, @name : String, @balance : UInt32)
  end
end

p! sizeof(UserStruct) # (id 4 + padding 4) + name 8 + (balance 4 + padding 4)
p! alignof(UserStruct)

__ "record (Value Type)"

record UserRecord,
  id : UInt32,
  name : String,
  balance : UInt32

p! sizeof(UserRecord) # (id 4 + padding 4) + name 8 + (balance 4 + padding 4)
p! alignof(UserRecord)
p! offsetof(UserRecord, @id)
p! offsetof(UserRecord, @name)
p! offsetof(UserRecord, @balance)

__ "Packed struct"

@[Packed]
record UserPackedRecord,
  id : UInt32,
  name : String,
  balance : UInt32

p! sizeof(UserPackedRecord)  # id 4 + name 8 + balance 4
p! alignof(UserPackedRecord) # 1

__ "class (Referenced Type)"

class UserClass
  @id : UInt32
  @name : String
  @balance : UInt32

  def initialize(@id : UInt32, @name : String, @balance : UInt32)
  end
end

p! sizeof(UserClass) # ptr
p! alignof(UserClass)
p! instance_sizeof(UserClass) # TYPEID 4 + id 4 + name 8 + (balance 4 + padding 4)
p! instance_alignof(UserClass)
p! offsetof(UserClass, @id)
p! offsetof(UserClass, @name)
p! offsetof(UserClass, @balance)

__ "Pointer (Value Type)"

p! sizeof(Pointer(String))
p! alignof(Pointer(String))
