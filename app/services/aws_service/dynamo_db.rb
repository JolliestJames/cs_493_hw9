module AwsService
  class DynamoDB
    class << self
      def client
        @client ||= Aws::DynamoDB::Client.new(region: Rails.application.secrets.aws[:region])
      end

      def scan(attr)
        client.scan(
          attributes_to_get: [attr],
          table_name: Rails.application.secrets.aws[:dynamo_db_table]
        ).items
      end

      def query(opts)
        query_options = {
          expression_attribute_values: expression_attribute_values(opts), 
          key_condition_expression: "genre = :genre",
          table_name: Rails.application.secrets.aws[:dynamo_db_table]
        }

        query_options = query_options.merge(filter(opts[:method])) if opts[:method]

        client.query(query_options).items
      end

      def filter(method)
        { filter_expression: "#{method} = :#{method}" }
      end

      def expression_attribute_values(opts)
        values = { ":genre" => opts[:genre] }
        values = values.merge(":#{opts[:method]}" => opts[opts[:method]]) if opts[:method]
        values
      end
    end
  end
end
