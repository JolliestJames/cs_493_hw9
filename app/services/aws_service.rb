module AwsService
  class << self
    def s3_client
      @s3_client ||= AwsService::S3.client
    end
  end
end
