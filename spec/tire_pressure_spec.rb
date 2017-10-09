require_relative '../lib/tire_pressure'

RSpec.describe 'Alarm' do
  context '#check' do
    let(:low_pressure_threshold) { 17 }
    let(:high_pressure_threshold) { 21 }
    
    let(:alarm) { Alarm.new(low_pressure_threshold, high_pressure_threshold, Sensor.new) }
    
    context 'activates the alarm' do
      it 'when the pressure is too low' do
        allow(Sensor).to receive(:sample_pressure) { 0.99 }
        alarm.check
        
        expect(alarm).to be_on
      end
  
      it 'when the pressure is too high' do
        allow(Sensor).to receive(:sample_pressure) { 6.01 }
        alarm.check

        expect(alarm).to be_on
      end
    end

    context 'does not activate the alarm' do
      it 'when the pressure is within tolerance' do
        allow(Sensor).to receive(:sample_pressure) { 3.0 }
        alarm.check

        expect(alarm).to be_off
      end
    end
  end
end
