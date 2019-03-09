module AwsService
  class SQS
    class << self
      def client
        @client ||= Aws::SQS::Client.new(region: Rails.application.secrets.aws[:region])
      end

      def send(message)
        client.send_message({
          queue_url: Rails.application.secrets.aws[:sqs][:queue],
          message_body: message,
          delay_seconds: 1
        })
      end
    end
  end
end
