# encoding: utf-8
module ProxyPacRb
  # Compress javascript files
  class ProxyPacCompressor
    def compress(file)
      file.compressed_content = Uglifier.new.compile(file.raw_content)
    end
  end
end