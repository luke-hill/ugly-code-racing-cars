require_relative '../lib/tire_pressure'

RSpec.describe 'Alarm' do
  context '#check' do
    let(:alarm) { Alarm.new }
    
    context 'activates the alarm' do
      it 'when the pressure is too low' do
        allow(Sensor).to receive(:sample_pressure) { 0.99 }
        alarm.check
        
        expect(alarm.is_alarm_on).to be true
      end
  
      it 'when the pressure is too high' do
        allow(Sensor).to receive(:sample_pressure) { 6.01 }
        alarm.check

        expect(alarm.is_alarm_on).to be true
      end
    end

    context 'does not activate the alarm' do
      it 'when the pressure is within tolerance' do
        allow(Sensor).to receive(:sample_pressure) { 3.0 }
        alarm.check

        expect(alarm.is_alarm_on).to be false
      end
    end
  end
end
