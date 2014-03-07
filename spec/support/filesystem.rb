# encoding: utf-8
require 'fedux_org/stdlib/filesystem'

module ProxyPacRb
  module SpecHelper
    module Filesystem
      include FeduxOrg::Stdlib::Filesystem

      def root_directory
        ::File.expand_path('../../../', __FILE__)
      end
    end
  end
end

# encoding: utf-8
RSpec.configure do |c|
  c.include ProxyPacRb::SpecHelper::Filesystem
  c.before(:each) { cleanup_working_directory }
end
