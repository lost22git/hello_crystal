#!/usr/bin/env crystal

a : String? = "hello"
p! a
p! a.try &.upcase

a = nil
p! a
p! a.try &.upcase || "world"
