require 'airport'

describe Airport do
  context 'Airport is not full' do
    before(:each) do
      @airport = Airport.new
      @plane = Plane.new(@airport)
      @atc = AirTrafficController.new(@plane)
    end
    it 'Can hold planes' do
      expect(subject).to respond_to :planes
    end
    it 'Has a default maximum capacity of planes that it can hold' do
      expect(subject).to respond_to :capacity
      expect(subject.capacity).not_to be_nil
    end
    it 'allows the default capacity to be overridden as appropriate' do
      expect(subject.capacity = 5).to eq 5
      expect(Airport.new(50).capacity).to eq 50
    end
    it 'ensures that the same plane cannot land if it is already in the airport' do
      @atc.instruct_to_land(@plane, "Sunny")
      expect { @plane.land(@airport) }.to raise_error 'Plane is already on the ground'
    end
    it 'ensures that the same plane cannot take off if it has already taken off' do
      @atc.instruct_to_take_off(@plane, "Sunny")
      @plane.take_off(@airport)
      @atc.instruct_to_take_off(@plane, "Sunny")
      expect { @plane.take_off(@airport) }.to raise_error 'Plane is already in the air'
    end
  end
  context 'Airport is full' do
    it 'ensures that planes cannot land if the airport is full' do
      @airport = Airport.new
      @airport.capacity.times { Plane.new(@airport) }
      @atc = AirTrafficController.new(@plane = Plane.new)
      @atc.instruct_to_land(@plane, "Sunny")
      puts @airport.planes.size
      expect { @plane.land(@airport) }.to raise_error 'Airport is full'
    end
  end
end
