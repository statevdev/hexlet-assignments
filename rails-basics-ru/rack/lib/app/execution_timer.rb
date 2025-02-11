# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    if status == 200
      start_time = Time.now

      status, headers, = @app.call(env)

      end_time = Time.now

      runtime = ((end_time - start_time) * 1000).round(3)

      response << "\nExecution Time: #{runtime} ms"
    end
    [status, headers, response]
  end
end
