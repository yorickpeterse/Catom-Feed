require 'shebang'
require 'erb'
require 'digest/sha1'

class Default < Shebang::Command
  command :default
  banner  'Generates an Atom feed for cat.yorickpeterse.com'
  usage   '$ catom_feed.rb [COMMAND] [OPTIONS]'

  o :h, :help, 'Shows this help message', :method => :help

  o :t, :template, 'The ERB template to use for the feed',
    :default => File.expand_path('../feed.erb', __FILE__),
    :type    => String

  o :p, :path, 'The path to the directory containing all files for the feed',
    :default => '/srv/http/cat.yorickpeterse.com/public',
    :type    => String

  MOVIES = ['.mp4', '.webm']

  def index(args = [])
    unless File.directory?(option(:p))
      abort "The directory #{option(:p)} does not exist"
    end

    updated_at = Time.now
    items      = []
    files      = Dir[File.join(option(:p), '**/*.*')].sort do |left, right|
      File.mtime(right).to_i <=> File.mtime(left).to_i
    end

    files.each do |file|
      filename = File.basename(file)

      items << {
        :hash       => Digest::SHA1.new.hexdigest(filename),
        :filename   => filename,
        :created_at => File.mtime(file),
        :movie      => MOVIES.include?(File.extname(file))
      }
    end

    template = ERB.new(File.read(option(:t)), 0, '<>')

    puts template.result(binding)
  end
end

Shebang.run
