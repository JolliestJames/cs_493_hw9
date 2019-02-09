module AwsService
  class S3
    class << self
      def put_object(object, path)
        $s3_client.put_object({
          body: File.read(object),
          bucket: bucket[:name],
          key: path
        })
      end

      def objects
        Aws::S3::Bucket.new(bucket[:name], client: $s3_client).objects.map { |o| o }
      end

      def object(key)
        $s3_client.get_object(bucket: bucket[:name], key: key)
      end

      def client
        Aws::S3::Client.new(
          credentials: AwsService::Credentials.simple_storage_service,
          region: Rails.application.secrets.aws[:region]
        )
      end

      private

      def bucket
        buckets[:buckets].detect do |b|
          b[:name] == Rails.application.secrets.aws[:bucket_name]
        end
      end

      def buckets
        $s3_client.list_buckets
      end
    end
  end
end
