class Sensor
  OFFSET = 16

  def pop_next_pressure_psi_value
    Sensor::OFFSET + Sensor.sample_pressure
  end

  def self.sample_pressure # placeholder implementation that simulate a real sensor in a real tire
    6 * rand * rand
  end
end

class Alarm
  attr_accessor :alarm
  attr_reader :low_pressure_threshold, :high_pressure_threshold

  def initialize
    @low_pressure_threshold = 17
    @high_pressure_threshold = 21
    @sensor = Sensor.new
    @alarm = :off
  end

  def check
    if pressure_too_low? || pressure_too_high?
      self.alarm = :on
    end
  end
  
  def sensor_value
    @sensor_value ||= @sensor.pop_next_pressure_psi_value
  end
  
  def pressure_too_high?
    high_pressure_threshold < sensor_value
  end
  
  def pressure_too_low?
    sensor_value < low_pressure_threshold
  end
  
  def on?
    alarm == :on
  end
  
  def off?
    alarm == :off
  end
end
