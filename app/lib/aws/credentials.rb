module AWS
  class Credentials
    class << self
      def simple_storage_service
        Aws::AssumeRoleCredentials.new(
          client: security_token_service,
          role_arn: Rails.application.secrets.aws[:role_arn],
          role_session_name: 's3-boss'
        )
      end

      private

      def security_token_service
        Aws::STS::Client.new(region: Rails.application.secrets.aws[:region])
      end
    end
  end
end
