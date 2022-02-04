require 'station.rb'

describe Station do

    let(:name) { "Waterloo" }
    let(:zone) { 1 }
    let(:station) { Station.new(name, zone) }

    it "describes station name" do
        expect(station.name).to eq name
    end

    it "describes the station zone" do
        expect(station.zone).to eq zone
    end

end