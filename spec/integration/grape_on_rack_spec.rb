require 'spec_helper'

describe 'Grape on RACK', js: true, type: :feature do
  context 'homepage' do
    it 'displays index.html page' do
      visit '/'
      expect(title).to eq('Rack Powers Web APIs')
    end
    context 'ring' do
      before :each do
        @rang = Acme::PostPut.rang
        visit '/'
      end
      it 'increments the ring counter' do
        expect(find('#ring_value')).to have_content "rang #{@rang + 1} time(s)"
        expect(find('#ring_action')).to have_content 'click here to ring again'
        3.times do |i|
          find('#ring_action').click
          expect(find('#ring_value')).to have_content "rang #{@rang + i + 2} time(s)"
        end
      end
    end
  end
  context "page that doesn't exist" do
    before :each do
      visit '/invalid'
    end
    it 'displays 404 page' do
      expect(title).to eq('Page Not Found')
    end
  end
  context 'exception' do
    before :each do
      visit '/api/raise'
    end
    it 'displays 500 page' do
      expect(title).to eq('Unexpected Error')
    end
  end
  context 'curl' do
    it 'reticulates a spline' do
      visit '/'
      url = "http://#{Capybara.server_host}:#{Capybara.server_port}/api/spline"
      json = '{"reticulated":"false"}'
      rc = `curl -X POST -d '#{json}' #{url} -H 'Accept: application/json' -H 'Content-Type:application/json' -s`
      expect(rc).to eq(json)
    end
  end
end
