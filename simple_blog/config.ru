require 'bundler/setup'
require 'time'
require 'zero'
require 'securerandom'
require 'erb'
require 'tilt'
require 'uri'

RENDERER = Zero::Renderer.new('templates', {
  'html' => ['text/xml', 'text/html', 'plain/text', '*/*'],
  'json' => ['application/json'],
  'atom' => ['application/atom+xml']
})
RENDERER.read_template_path!

Zero::Controller.renderer = RENDERER

POSTS = {}

require './post_controller'

run Zero::Router.new(
  '/' => PostController,
  '/:id' => PostController
)
