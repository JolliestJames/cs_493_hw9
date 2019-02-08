require 'rails_helper'

RSpec.describe Api::V1::MusicController, type: :controller do
  describe 'GET #index' do
    let(:expected) { { music: 'Someday there will be music here' }.to_json }

    specify { expect(get(:index).body).to eq(expected) }
  end
end
