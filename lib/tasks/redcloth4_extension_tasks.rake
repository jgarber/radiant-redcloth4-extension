namespace :radiant do
  namespace :extensions do
    namespace :redcloth4 do
      
      desc "Runs the migration of the Redcloth4 extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          Redcloth4Extension.migrator.migrate(ENV["VERSION"].to_i)
        else
          Redcloth4Extension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Redcloth4 to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[Redcloth4Extension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(Redcloth4Extension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
