# this is a zero controller to manage posts
#
# This controller does all the work for posts, like adding new posts, fetching
# them and at last the render step.
class PostController < Zero::Controller
  def get
    custom_params = @request.params.custom
    if custom_params.has_key?('id')
      @posts = {custom_params['id'] => POSTS[custom_params['id']]}
    else
      @posts = POSTS
    end
  end

  def post
    payload = @request.params.payload
    if payload.has_key?('body')
      @id = SecureRandom.uuid
      POSTS[@id] = payload['body']
    end
  end

  def process
    return send(@request.method) if [:get, :post]
  end

  def render
    if @request.get?
      template = 'posts/index'
    elsif @request.post?
      @response.status = 302
      if @id
        @response.header['Location'] = '/' + @id
        template = 'posts/success'
      else
        @response.header['Location'] = '/'
        template = 'posts/notfound'
      end
    end

    @response.body = [renderer.render(template, @request.accept.types, self)]
  end
end

