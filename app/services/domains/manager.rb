module Domains
  class Manager
    def connect_domain(domain)
      call_script('connect_domain.sh', "-d #{domain} -u deploy")
    end

    def remove_domain(domain)
      call_script('remove_domain.sh', "-d #{domain}")
    end

    private

      def call_script(script, params = nil)
        return if Rails.env.production? != true
        path = Rails.root.join('app', 'scripts', script)
        command = "sudo bash #{path}"
        command += " #{params}" if params.present?
        system command
      end

  end
end
