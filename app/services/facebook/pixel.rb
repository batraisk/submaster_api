module Facebook
  class Pixel
    attr_reader :page, :access_token, :pixel_id, :guest

    def initialize(page, guest)
      @page = page
      @guest = guest
      @access_token = page.facebook_server_side_token
      @pixel_id = page.facebook_pixel_id

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
        events: [event],
      )
      request.execute
    end
    # def call
    #
    #   access_token = @access_token
    #   pixel_id = @pixel_id
    #
    #   FacebookAds.configure do |config|
    #     config.access_token = access_token
    #   end
    #
    #   user_data_0 = FacebookAds::ServerSide::UserData.new(
    #     client_ip_address: "::1",
    #     client_user_agent: "Mozilla\/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit\/537.36 (KHTML, like Gecko) Chrome\/93.0.4577.82 Safari\/537.36")
    #   event_0 = FacebookAds::ServerSide::Event.new(
    #     event_name: "Instagram subscription 0",
    #     event_time: Time.now.to_i,
    #     user_data: user_data_0,
    #     # custom_data: custom_data_0,
    #     action_source: "website")
    #
    #   request = FacebookAds::ServerSide::EventRequest.new(
    #     pixel_id: pixel_id,
    #     events: [event_0])
    #   request.execute
    # end


  end
end