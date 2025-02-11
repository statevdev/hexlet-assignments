# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)
    if status == 200
      body = response.join
      hash = Digest::SHA256.hexdigest(body)
      response << "\n#{hash}"
    end
    [status, headers, response]
    # END
  end
end
