class Log
  attr_accessor :method, :path, :dyno, :connect, :service

  def initialize(method, path, dyno, connect, service)
    @method = method
    @path = path
    @dyno = dyno
    @connect = connect.to_f
    @service = service.to_f
  end
end
