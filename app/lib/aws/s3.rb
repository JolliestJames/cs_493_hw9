module AWS
  class S3
    class << self
      def put_object(object, path)
        client.put_object({
          body: File.read(object),
          bucket: bucket[:name],
          key: path
        })
      end

      def bucket
        buckets[:buckets].detect do |b|
          b[:name] == Rails.application.secrets.aws[:bucket_name]
        end
      end

      private

      def buckets
        client.list_buckets
      end

      def client
        Aws::S3::Client.new(
          credentials: AWS::Credentials.simple_storage_service,
          region: Rails.application.secrets.aws[:region]
        )
      end
    end
  end
end
