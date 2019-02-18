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
        query_options = build_query(opts)
        query_options = apply_filter(query_options, opts[:method]) if opts[:method]
        client.query(query_options).items
      end

      def build_query(opts)
        {
          expression_attribute_values: expression_attribute_values(opts), 
          key_condition_expression: "genre = :genre",
          table_name: Rails.application.secrets.aws[:dynamo_db_table]
        }
      end

      def apply_filter(query_options, method)
        query_options.merge(filter_expression: "#{method} = :#{method}")
      end

      def expression_attribute_values(opts)
        values = { ":genre" => opts[:genre] }
        values = values.merge(":#{opts[:method]}" => opts[opts[:method]]) if opts[:method]
        values
      end
    end
  end
end
