require 'thor'
require 'fileutils'

module Dockerize
    class Rails < Thor
        desc "with <db_name>", "Creates docker-compose rails app with given database name"
        long_desc <<-LONGDESC
         will generate ruby on rails application and will connect it
        to a given database.
        Example:
        $ dockerize rails with postgresql
     
        > from: Anton Bozhinov
        LONGDESC
        option :name
        def with(db_name)
            if options[:name]
                project_name = options[:name]
            else
                puts "What is your project name?"
                project_name = STDIN.gets.chomp
            end
            puts "Generating rails aplication with #{db_name} as a database in #{project_name}..."
            puts "Creating #{project_name} dir in #{Dir.pwd}"

            project_dir = Dir.pwd + "/#{project_name}"
            if Dir.exist?(project_dir)
                puts "Found dir with same project name!"
                puts "Replacing dir with the current project..."
                FileUtils.remove_dir(project_dir)
            end

            puts "Creating project folder..."
            FileUtils.mkdir project_name

            puts "Copy template files..."
            template_dir = File.expand_path(File.dirname(__FILE__) + "/templates/rails/#{db_name}")
            FileUtils.cp_r(template_dir, project_dir)
        end
    end
end

