#!/usr/bin/env crystal

def __(t : String)
  puts ""
  puts "------\e[1;33m " + t + " \e[m" + ("-" * (50 - 8 - t.size))
  puts ""
end

class Book
  property name : String
  property price : Float64

  def initialize(@name : String, @price : Float64)
  end
end

__ "has_getter? / has_setter?"

macro has_method?(obj, method)
  if {{ obj }}.is_a? Pointer
    {{ obj }}.value.responds_to? {{ method.id.symbolize }} 
  else
    {{ obj }}.responds_to? {{ method.id.symbolize }} 
  end
end

macro has_setter?(obj, field_name)
  has_method? {{ obj }}, "{{ field_name }}="
end

macro has_getter?(obj, field_name)
  has_method? {{ obj }}, "{{ field_name }}"
end

book = Book.new("foo", 11)
p! has_getter? book, price
p! has_getter? book, pricesss
p! has_getter? pointerof(book), price
p! has_getter? pointerof(book), pricesss
p! has_setter? book, price
p! has_setter? book, pricesss
p! has_setter? pointerof(book), price
p! has_setter? pointerof(book), pricesss

__ "get/set fields"

macro get_field_val_real(obj, field_name)
  if {{ obj }}.is_a? Pointer
    {{ obj }}.value.{{ field_name }}
  else
    {{ obj }}.{{ field_name }}
  end
end

macro set_field_val_real(obj, name, value)
  if {{ obj }}.is_a? Pointer
    {{ obj }}.value.{{ name }} = {{ value }}
  else
    {{ obj }}.{{ name }} = {{ value }}
  end
end

def get_field_val(obj : Pointer(T) | T, name : String) forall T
  {% begin %}
  return case name
    {% for field in T.instance_vars %}
      when "{{ field.name }}"
        get_field_val_real obj, {{ field.name }}   
    {% end %}
    else raise "the field: `{{T.name}}.#{name}` not found"
  end
  {% end %}
end

def get_field_val?(obj : Pointer(T) | T, name : String) forall T
  get_field_val obj, name
rescue
  nil
end

def set_field_val(obj : Pointer(T) | T, name : String, value) forall T
  {% begin %}
  case name
  {% for field in T.instance_vars %}
    when "{{ field.name }}"
      if v = value.as? {{ field.type }}
        set_field_val_real obj, {{ field.name }}, v
      else 
        raise "the type of field: `{{ T.name }}.#{name}` is `{{ field.type }}`, but got `#{value}`" 
      end
  {% end %}
  else
    raise "the field: `{{ T.name }}.#{name}` not found"
  end
  {% end %}
end

def set_field_val?(obj : Pointer(T) | T, name : String, value) : Bool forall T
  set_field_val obj, name, value
  true
rescue
  false
end

book = Book.new("foo", 11)
set_field_val book, "price", 22.0
p! get_field_val book, "price"

p! set_field_val? pointerof(book), "price", 33.0
p! get_field_val?(pointerof(book), "price")
p! get_field_val?(pointerof(book), "pricesssss") || 0
