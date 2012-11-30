router example
==============

This example shows how to use the router. First it can be used to distinguish
between different routes but it is also possible to use parts of the URI for
parameters. These are saved in the Zero::Request.

To build a new router, you initialize it with a map of URIs to applications.
These have to provide the method `#call` and take a rack compatible environment.

    Router.new('/' => FooApp)

To read the custom parameters, you can either get the Zero::Request with

    Zero::Request.create(environment)

or by fetching the hash from the environment

    environment['zero.params.custom']
