class Test
  class << self
    def json 
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
          handle: {
            bind_point: "name",
            item: "song.types.name",
            component: "types"
          }
        }
      }
    end

    def call
      js_declaration + js_headers + js_init + js_request
    end

    def name
      @name ||= json[:fetch][:name] || ("a".."z").to_a.sample(8).join
    end

    def headers
      headers = []
      json[:fetch][:headers].each do |k, v|
        headers << "#{name}Headers.append('#{k}', '#{v}');"
      end
      headers
    end

    def js_declaration
      "let #{name}Response = ''"
    end

    def js_headers
      "const #{name}Headers = new Headers();
#{headers.join("\n")}"
    end

    def js_init
      "const #{name}Init = {
  method: 'GET',
  headers: #{name}Headers,
  mode: 'cors',
  cache: 'default',
};"
    end

    def js_request
      "const #{name}Request = new Request('#{json[:fetch][:url]}');

fetch(#{name}Request, #{name}Init)
  .then((response) => {
    return response.json();
  }).then((body) => {
    #{name}Response = body;
    console.log(#{name}Response);
  });
"
    end
  end
end

class Node
  attr_accessor :child, :parent, :attributes
  def initialize(attributes, parent, child = nil)
    @parent = parent
    @attributes = attributes
    @children = children
  end

  def self.leaf?
    return true if child == nil

    false
  end
end

class Attributes
  def initialize(key, value)
    @key = key
    @value = value
  end
end

node = Node.new(nil, nil, nil)
node.child


def json 
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
      handle: {
        bind_point: "name",
        item: "song.types.name",
        component: "types"
      }
    }
  }
end


puts Test.call
