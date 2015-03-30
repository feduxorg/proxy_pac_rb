require 'proxy_pac_rb'
require 'rack'

module ProxyPacRb
  module Rack
    # Rack Middleware to compress proxy pac
    #
    # @example Sinatra's <server>.rb
    # require 'proxy_pac_rb/rack/proxy_pac_compressor'
    # use ProxyPacRb::Rack::ProxyPacCompressor
    #
    # @example Rack's config.ru
    # require 'proxy_pac_rb/rack/proxy_pac_compressor'
    # use ProxyPacRb::Rack::ProxyPacCompressor
    #
    # @example Middleman's config.rb
    # require 'proxy_pac_rb/rack/proxy_pac_compressor'
    # use ProxyPacRb::Rack::ProxyPacCompressor
    #
    class ProxyPacCompressor
      private

      attr_reader :compressor, :loader

      public

      def initialize(
        app,
        enabled: true
      )
        @app        = app
        @compressor = ProxyPacRb::ProxyPacCompressor.new
        @loader     = ProxyPacRb::ProxyPacLoader.new
      end

      def call env
        status, headers, body = @app.call(env)

        return [status, headers, body] unless headers.key?('Content-Type') \
                                              && %r{application/x-ns-proxy-autoconfig} === headers['Content-Type']

        content = body.each_with_object('') { |e, a| a << e }
        begin
          proxy_pac = ProxyPacFile.new(source: content)

          loader.load(proxy_pac)
          compressor.compress(proxy_pac)

          content = proxy_pac.content
        rescue => err
          status  = 500
          content = err.message
        end

        headers['Content-Length'] = content.bytesize.to_s if headers['Content-Length']

        [status, headers, [content]]
      rescue

      ensure
        body.close if body.respond_to? :close
      end
    end
  end
end