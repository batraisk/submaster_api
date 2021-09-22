module Facebook
  class Pixel
    attr_reader :page, :access_token, :pixel_id, :guest

    def initialize(page, guest)
      @page = page
      @guest = guest
      @access_token = facebook_server_side_token
      @pixel_id = facebook_pixel_id

    end

    def call
      return unless @access_token and @pixel_id
      FacebookAds.configure do |config|
        config.access_token = access_token
      end

      user_data = FacebookAds::ServerSide::UserData.new(
        client_ip_address: guest.remote_ip,
        client_user_agent: guest.user_agent,
      )

      event = FacebookAds::ServerSide::Event.new(
        event_name: 'Instagram subscription',
        event_time: Time.now.to_i,
        user_data: user_data,
        action_source: 'website'
      )


      request = FacebookAds::ServerSide::EventRequest.new(
        pixel_id: pixel_id,
        events: [event]
      )
      request.execute
    end
  end
end