require './log_parser'

class LogAnalyzer
  attr_accessor :log_file

  def initialize(log_file)
    @log_file = log_file
  end

  def analyze(request)
    request_method, request_path = request.split(' ')

    log_parser = LogParser.new(log_file, request_method, request_path)
    logs = log_parser.process

    puts request
    puts "frequency: #{frequency(logs)}"
    puts "response time: (mean: #{mean(response_time(logs))}ms, median: #{median(response_time(logs))}ms, mode: #{mode(response_time(logs))}ms)"
    puts "dyno (most frequent): #{frequent_dyno(logs)}"
    puts ''
  end

  private

  def frequency(logs)
    logs.size
  end

  def response_time(logs)
    values = []
    logs.each { |log| values << (log.connect + log.service) }
    values.sort
  end

  def frequent_dyno(logs)
    mode(logs.map(&:dyno))
  end

  def mean(values)
    (values.inject(0) { |sum, x| sum += x } / values.size).round(2)
  end

  def median(values)
    values.sort
    mid = values.size / 2
    values.size.even? ? mean(values[mid-1..mid]) : values[mid]
  end

  def mode(values)
    occurrences = values.inject(Hash.new(0)) { |value, frequency| value[frequency] += 1; value }
    values.max_by { |frequency| occurrences[frequency] }
  end
end
