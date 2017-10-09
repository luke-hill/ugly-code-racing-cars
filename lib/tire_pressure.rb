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
  attr_reader :low_pressure_threshold, :high_pressure_threshold, :sensor

  def initialize(low_pressure_threshold, high_pressure_threshold, sensor)
    @low_pressure_threshold = low_pressure_threshold
    @high_pressure_threshold = high_pressure_threshold
    @sensor = sensor
    @alarm = :off
  end

  def check
    unless pressure_ok?
      self.alarm = :on
    end
  end

  def on?
    alarm == :on
  end

  def off?
    alarm == :off
  end
  
  private
  
  def sensor_value
    @sensor_value ||= sensor.pop_next_pressure_psi_value
  end
  
  def pressure_ok?
    sensor_value.between?(low_pressure_threshold, high_pressure_threshold)
  end
end
