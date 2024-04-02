#!/usr/bin/env ruby

require_relative "doubly_linked_list"

class Stack
  def initialize(elem = nil)
    @dll = DoublyLinkedList.new()

    if elem != nil
      @dll.add_last(elem)
    end
  end

  def pop
    @dll.remove_last
  end

  def push(elem)
    @dll.add_last(elem)
  end

  def peek()
    @dll.tail.data
  end

  def peek_all()
    @dll.stringify
  end
end


# Example usage

stack = Stack.new("Banana")

p stack.peek

stack.push("Apple")

p stack.peek

stack.push("Watermelon")
stack.push("Kiwi")

p stack.peek

p stack.peek_all
