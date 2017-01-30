require './log'

class LogParser
  attr_accessor :log_file, :request_method, :request_path

  def initialize(log_file, request_method, request_path)
    @log_file = File.open(log_file)
    @request_method = request_method
    @request_path = request_path
  end

  def process
    logs = []
    log_file.each_line do |line|
      if line.include?(request_method) && line[eval(regex_path(request_path, '{user_id}', '\d+'))]
        logs << Log.new(
          request_method,
          path(line),
          dyno(line),
          connect(line),
          service(line)
        )
      end
    end

    return logs
  end

  private

  def path(log_string)
    log_string[/path=\S+/].split('=')[1]
  end

  def dyno(log_string)
    log_string[/dyno=\S+/].split('=')[1]
  end

  def connect(log_string)
    log_string[/connect=\d+/].split('=')[1]
  end

  def service(log_string)
    log_string[/service=\d+/].split('=')[1]
  end

  def regex_path(path, replace, with)
    '/' + path.sub(replace, with).split('/').join('\/') + '/'
  end
end
