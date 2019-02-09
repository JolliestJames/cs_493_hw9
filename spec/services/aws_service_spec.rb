require 'rails_helper'
require 'base64'

RSpec.describe AwsService do
  describe '.s3_client' do
    specify { expect(described_class.s3_client).to be_a(Aws::S3::Client) }
  end
end
