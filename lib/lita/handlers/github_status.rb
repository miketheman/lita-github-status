module Lita
  module Handlers
    class GithubStatus < Handler
      route('github status', :status, command: true)
      route('github status last', :status_last_message, command: true)
      route('github status messages', :status_messages, command: true)

      BASE_URL = 'https://status.github.com/api'

      def status(response)
        data = MultiJson.load(http.get(BASE_URL + '/status.json').body)

        now = Time.now
        updated = Time.parse data['last_updated']
        seconds_ago = (now - updated).round

        response.reply "Status: #{data['status']} (#{seconds_ago} seconds ago)"
      end

      def status_last_message(response)
        data = MultiJson.load(http.get(BASE_URL + '/last-message.json').body)

        response.reply "Status: #{data['status']}\n" \
                       "Message: #{data['body']}\n" \
                       "Time: #{Time.parse data['created_on']}"
      end

      def status_messages(response)
        data = MultiJson.load(http.get(BASE_URL + '/messages.json').body)

        replies = data.map do |message|
          "[#{message['status']}] #{message['body']} (#{Time.parse message['created_on']})"
        end

        replies.each do |reply|
          response.reply reply
        end
      end
    end

    Lita.register_handler(GithubStatus)
  end
end
