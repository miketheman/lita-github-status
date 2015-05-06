require 'spec_helper'

describe Lita::Handlers::GithubStatus, lita_handler: true do
  it 'routes commands correctly' do
    expect(subject).to route_command('github status').to :status
    expect(subject).to route_command('github status last').to :status_last_message
    expect(subject).to route_command('github status messages').to :status_messages
  end

  describe '#status' do
    let(:status) { %({"status":"good","last_updated":"2015-05-06T12:32:08Z"}) }

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with(
        'https://status.github.com/api/status.json'
      ).and_return(double('Faraday::Response', status: 200, body: status))
    end

    it 'retrieves the status' do
      send_command('github status')

      expect(replies.last).to include('Status: good')
      expect(replies.last).to include('seconds ago')
    end
  end

  describe '#status_last_message' do
    let(:last_message) do
      %({"status":"good",
        "body":"Everything operating normally.",
        "created_on":"2015-05-06T12:20:14Z"})
    end

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with(
        'https://status.github.com/api/last-message.json'
      ).and_return(double('Faraday::Response', status: 200, body: last_message))
    end

    it 'retrieves the last status message' do
      send_command('github status last')

      expect(replies.last).to include('Status: good')
      expect(replies.last).to include('Message: Everything operating normally.')
      expect(replies.last).to include('Time: 2015-05-06 12:20:14 UTC')
    end
  end

  describe '#status_messages' do
    let(:status_messages) do
      %([
          {"status":"good","body":"Everything operating normally.",
            "created_on":"2015-05-06T12:20:14Z"},
          {"status":"minor","body":"We've finished emergency maintenance and are monitoring closely.",
            "created_on":"2015-05-06T11:54:37Z"},
          {"status":"major","body":"We're doing emergency maintenance to recover the site.",
            "created_on":"2015-05-06T11:40:07Z"},
          {"status":"minor","body":"We're seeing high error rates on github.com and are investigating.",
            "created_on":"2015-05-06T11:32:14Z"}
      ])
    end

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with(
        'https://status.github.com/api/messages.json'
      ).and_return(double('Faraday::Response', status: 200, body: status_messages))
    end

    it 'retrieves the last status message' do
      send_command('github status messages')

      expect(replies.first).to include('[good] Everything operating normally.')
      expect(replies.first).to include('(2015-05-06 12:20:14 UTC)')

      expect(replies.last).to include("[minor] We're seeing high error rates")
      expect(replies.last).to include('(2015-05-06 11:32:14 UTC)')
    end
  end
end
