#!/usr/bin/env ruby

class Node
  attr_accessor :data, :prev, :next

  def initialize(data, prev_el, next_el)
    @data, @prev, @next = data, prev_el, next_el
  end

  def set_prev(node)
    @prev = node
  end

  def set_next(node)
    @next = node
  end
end

class DoublyLinkedList
  attr_accessor :len, :head, :tail

  def initialize()
    @len, @head, @tail = 0, nil, nil
  end

  def size
    @len
  end

  def is_empty?()
    @len == 0
  end

  def add(elem)
    add_last(elem)
  end

  def start_head(elem)
    node = Node.new(elem, nil, nil)
    @head, @tail = node, node
  end

  def add_last(elem)
    if is_empty?
      start_head(elem)
    else
      @tail.set_next(Node.new(elem, @tail, nil))
      @tail = @tail.next
    end

    @len += 1
  end

  def add_first(elem)
    if self.is_empty?
      start_head(elem)
    else
      @head.set_prev(Node.new(elem, nil, @head))
      @head = @head.prev
    end

    @len += 1
  end

  def add_at(index, elem)
    raise StandardError.new("Invalid index: #{index }")if index < 0 || index > size

    add_first(elem) if index == 0

    add_last(elem) if index == size

    for i in 0..(index - 1)
      tmp = @head.next
    end

    new_node = Node.new(elem, tmp.prev, tmp)
    tmp.prev.set_next(new_node)
    tmp.set_prev(new_node)

    @len += 1
  end

  def remove
    remove_last()
  end

  def remove_last
    @tail.data = nil
    @tail.prev.set_next(nil)

    @tail = @tail.prev

    @len -= 1
  end

  def remove_first
    @head.data = nil
    @head.next.set_prev(nil)

    @head = @head.next

    @len -= 1
  end

  def remove_at(index)
    raise StandardError.new("Invalid index: #{index }")if index < 0 || index > size

    remove_first if index == 0

    remove_last if index == size

    for i in 0..(index - 1)
      tmp = @head.next
    end

    tmp.data = nil
    tmp.prev.set_next(tmp.next)
    tmp.next.set_prev(tmp.prev)

    @len -= 1
  end

  def stringify()
    return [] if @head.nil?

    trav = @head

    res = []

    while trav != nil
      res.append(trav.data)
      trav = trav.next
    end

    res.compact.to_s
  end
end


# Example usage

dll = DoublyLinkedList.new()

dll.add_last("b")
dll.add("c")
dll.add("d")
dll.add("e")
dll.add_first("a")

p dll.stringify

dll.add_at(2, "hello")

p dll.stringify

dll.remove_last

p dll.stringify

dll.remove_at(1)

p dll.stringify
