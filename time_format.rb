class TimeFormat
  attr_accessor :formats, :unknown_formats

  TIME_FORMAT = {
    'year'=>"%Y", 'month'=>"%m", 'day'=>"%d", '
    hour'=>"%H", 'minute'=>"%M", 'second'=>"%S"
  }.freeze

def initialize(request_params)
  @formats = request_params['format'].split(',') || []
  @unknown_formats = unknown_formats_keys
end

def success?
  formats.any? 
end

def get_time
  if success?
    current_time
  else
    "Unknown time format [#{unknown_formats.join(',')}]"
  end
end

def current_time
  Time.now.strftime(time_params)
end

private

def time_params
  formats.map{|key| TIME_FORMAT[key]}.join('-')
end

def unknown_formats_keys
  formats - TIME_FORMAT.keys
end
end
