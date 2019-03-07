class UserService
  class << self
    def save(opts)
      AwsService::DynamoDB.put(
        item: {
          id: opts[:id],
          name: opts[:name],
          email: opts[:email],
          id_email_name: "#{opts[:id]}_#{opts[:email]}_#{opts[:name]}"
        },
        table: Rails.application.secrets.aws[:dynamo_db][:user]
      )

      :ok
    end
  end
end
