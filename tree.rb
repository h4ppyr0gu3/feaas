class Test
  def self.json
    {
      fetch: {
        headers: {
          auth: "auth"
        },
        url: "http://localhost:4567",
        method: "get",
        mode: "cors"
      },
      handle: {
        each: "$res.song",
        component: "component_name",
        variable: {
          image: "song.image_url"
        },
        songs: [
          {
            id: 2,
            title: "Heyy",
            image_url: "https://img.youtube.com/vi/F-7rQBY8uIQ/hqdefault.jpg"
          },
          {
            id: 4,
            title: "Tee Grizzley - Robbery Part 5 [Official Video]",
            image_url: "https://img.youtube.com/vi/dfnf3mfGYd0/hqdefault.jpg"
          },
          {
            id: 5,
            title: "Tee Grizzley - Jay & Twan 2 [Official Video]",
            image_url: "https://img.youtube.com/vi/R_mlVh0DE-4/hqdefault.jpg"
          },
          {
            id: 3,
            title: "California Breeze",
            image_url: "https://img.youtube.com/vi/WyhU6Zb_fhY/hqdefault.jpg"
          }
        ],
        handle: {
          bind_point: "name",
          item: "song.types.name",
          component: "types"
        }
      }
    }
  end
end

class Node
  attr_accessor :children, :parent, :attributes, :name

  def initialize(parent, name, attributes = [], children = [])
    @parent = parent
    @name = name
    @attributes = attributes
    @children = children
    assign_parents_children(parent)
  end

  def assign_parents_children(parent)
    return if parent.nil?

    parent.children << self
  end

  def self.child
    children[0]
  end

  def self.leaf?
    return true if children == []

    false
  end

  def list_children
    children.each do |child|
      puts "child = #{child.name}"
      puts "parent = #{child.parent.name}"
    end

    puts children.count
  end
end

class Attributes
  def initialize(key, value)
    @key = key
    @value = value
  end
end

# node = ""
# Test.json.each do |k, v|
#   node = Node.new(nil, k, v)
#   case v.class.to_s
#   when "Hash"
#     v.each do |k, v|
#       pp Node.new(node, k, v)
#     end
#   when "Array"
#     v.each do |v|
#       Node.new(node, "test", v)
#     end
#   end
# end

def generate_root(hash)
  root = Node.new(nil, nil, nil)
  hash.each do |k, v|
    parent = Node.new(root, k)
    case v.class.to_s
    when "Hash"
      v.each { |k, v| generate_children(Node.new(parent, k, v), v) }
    when "Array"
      v.each { |v| generate_children(Node.new(parent, v, v), v) }
    else
      Node.new(node, v, v)
    end
  end
  root
end

def generate_children(parent, value)
  case value.class.to_s
  when "Hash"
    value.each { |k, v| generate_children(Node.new(parent, k, v), v) }
  when "Array"
    value.each { |v| generate_children(Node.new(parent, v, v), v) }
  else
    Node.new(parent, value, value)
  end
end

node = generate_root(Test.json)
pp node
node.list_children
node.children[0].list_children
node.children[0].children[0].list_children
