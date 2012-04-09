require 'sinatra'
require 'RMagick'
require 'digest/sha1'
use Rack::Logger

configure do
  set :webkit2png, File.expand_path('../python-webkit2png/webkit2png.py', __FILE__)
  set :timeout, 8.to_s
  set :cache_path, File.expand_path('../cache', __FILE__)
  set :failed_path, File.expand_path('../failed.png', __FILE__)
end

get '/screenshot' do
  begin
    urlhash = Digest::SHA2.new.hexdigest(params[:url])
    timestamp = params[:timestamp].to_i
    cache_filename = File.join(settings.cache_path, "#{urlhash}_#{timestamp}.png")

    if !File.exists?(cache_filename)

      io = IO.popen(["timeout", settings.timeout, "python", settings.webkit2png, "-x", "800", "600", "-g", "800", "600", params[:url]])
      clown = Magick::Image.from_blob(io.read).first
      io.close
      clown.crop_resized!(150, 85, Magick::NorthGravity)
      clown.format = "PNG"
      image = clown.to_blob

      if image.length < 200
        raise "image size suspicious"
      end

      File.open(cache_filename, 'w') do |f|
        f.write image
      end
    end

    content_type :png
    attachment
    send_file cache_filename
  rescue => e
    request.logger.error e
    status 502
    send_file settings.failed_path
  end
end

