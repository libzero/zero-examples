require 'bundler/setup'
require 'zero'

headers = {'Content-Type' => 'text/html'}

# build some small applications
app1 = lambda {|env| [200, headers, ['Index found!']]}
app2 = lambda {|env| [200, headers, ['Another App found!']]}
app3 = lambda do |env|
  r = Zero::Request.create(env)
  [200, headers, ["I'm #{r.params['name']}."]]
end

run Zero::Router.new(
  '/' => app1,
  '/app2' => app2,
  '/name/:name' => app3
)
