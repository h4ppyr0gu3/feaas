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

puts Test.call
