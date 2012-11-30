simple\_blog
===========

This applications intention is to show a simple way to render a template for
many different accept types. This can be used to provide an API for users and
programs alike, for example by rendering html or json depending on the `ACCEPT`
header.
The main class used in this case is the `Zero::Renderer` with a map of types. To
extend the number of supported types, there are only two steps needed

1. add a map of a short name to the type
2. provide a template using that short name

So lets see, how exactly these two steps can be made. First is the renderer with
the map. The map translates shortcuts in files to mime types, which may show up
in the ACCEPT header. So lets try to build some maps. To support most requests
there should be a `*/*` somewhere. That is the HTTP way of saying "give me
anything".

    # a map to support xml and html
    map = {
      'html' => ['text/html', 'application/xml', '*/*']
    }
    
    # extend the map with json and githubs api beta json
    map['json'] = ['application/json', 'application/vnd.github.beta+json']

With that, we can build a new renderer

    renderer = Zero::Renderer.new(template_path, map)

Now that we have that, we need templates. As the renderer looks through the
templates, when calling `#read_template_path!` it creates a tree of possible
types and template combinations to render.

In this case, we could build an index template for json and html output like
this

    echo "Hello world!" > index.html.erb
    echo "{'text': 'hello world!'}" >> index.json.erb

Now when `#render` is called with the accept types, the renderer looks through
the tree of combinations and renders the fitting template.

    renderer.render('index', request.accept.types, Object.new)

Best is to look through the code. In this example, the setup is in `config.ru`
and the render call is in `post_controller.rb`.
