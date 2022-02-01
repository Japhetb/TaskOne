# Git 
Git is a distributed version control system for tracking changes in source code during software development. It is designed for coordinating work among programmers, but it can be used to track changes in any set of files. Its goals include speed, data integrity, and support for distributed, non-linear workflows.

# GitHub: 
GitHub is a web-based Git repository hosting service, which offers all of the distributed revision control and source code management (SCM) functionality of Git as well as adding its own features


### Polymorphism in Elixir
# Protocols

Protocols are a mechanism to achieve polymorphism in Elixir when you want behavior to vary depending on the data type. We are already familiar with one way of solving this type of problem: via pattern matching and guard clauses. Consider a simple utility module that would tell us the type of input variable:

```elixir

defmodule Utility do
  def type(value) when is_binary(value), do: "string"
  def type(value) when is_integer(value), do: "integer"
  # ... other implementations ...
end

```

If the use of this module were confined to your own project, you would be able to keep defining new type/1 functions for each new data type. However, this code could be problematic if it were shared as a dependency by multiple apps because there would be no easy way to extend its functionality.

This is where protocols can help us: protocols allow us to extend the original behavior for as many data types as we need. That’s because dispatching on a protocol is available to any data type that has implemented the protocol and a protocol can be implemented by anyone, at any time.

Here’s how we could write the same Utility.type/1 functionality as a protocol:

```elixir
defprotocol Utility do
  @spec type(t) :: String.t()
  def type(value)
end

defimpl Utility, for: BitString do
  def type(_value), do: "string"
end

defimpl Utility, for: Integer do
  def type(_value), do: "integer"
end

```

We define the protocol using defprotocol - its functions and specs may look similar to interfaces or abstract base classes in other languages. We can add as many implementations as we like using defimpl. The output is exactly the same as if we had a single module with multiple functions:

```elixir

iex> Utility.type("foo")
"string"
iex> Utility.type(123)
"integer"

```
With protocols, however, we are no longer stuck having to continuously modify the same module to support more and more data types. For example, we could get the defimpl calls above and spread them over multiple files and Elixir will dispatch the execution to the appropriate implementation based on the data type. Functions defined in a protocol may have more than one input, but the dispatching will always be based on the data type of the first input


