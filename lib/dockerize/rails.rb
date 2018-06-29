require 'thor'
require 'fileutils'
require 'erb'

module Dockerize
    class Rails < Thor
        desc "with <db_type>", "Creates docker-compose rails app with given database name"
        long_desc <<-LONGDESC
         will generate ruby on rails application and will connect it
        to a given database.
        Example:
        $ dockerize rails with postgresql
        
        Supported dbs:
            - postgresql
        > from: Anton Bozhinov
        LONGDESC
        option :name
        option :db_username
        option :db_password
        def with(db_type)
            @db_type = db_type
            if options[:name]
                @project_name = options[:name]
            else
                puts "What is your project name?"
                @project_name = STDIN.gets.chomp
            end
            if options[:db_username]
                @db_username = options[:db_username]
            else
                puts "Enter a db username..."
                @db_username = STDIN.gets.chomp
            end
            if options[:db_password]
                @db_password = options[:db_password]
            else
                puts "Enter a db password..."
                @db_password = STDIN.gets.chomp
            end
            puts "Generating rails aplication with #{@db_type} as a database in #{@project_name}..."
            puts "Creating #{@project_name} dir in #{Dir.pwd}"

            project_dir = Dir.pwd + "/#{@project_name}"
            if Dir.exist?(project_dir)
                puts "Found dir with same project name!"
                puts "Replacing dir with the current project..."
                FileUtils.remove_dir(project_dir)
            end

            puts "Creating project folder..."
            FileUtils.mkdir @project_name

            puts "Copy template files..."
            template_dir = Dir.glob(File.expand_path(File.dirname(__FILE__) + "/template/rails/common/*"))
            FileUtils.cp_r(template_dir, project_dir)

            docker_compose_dir = File.expand_path("#{File.dirname(__FILE__)}/template/rails/#{@db_type}/docker-compose.yml.erb")
            config_dir = File.expand_path("#{File.dirname(__FILE__)}/config/database.yml.erb")

            puts "docker-compose file found at #{docker_compose_dir}"
            docker_compose_file = File.read(docker_compose_dir)
            docker_compose_renderer = ERB.new(docker_compose_file)
            docker_compose_output = docker_compose_renderer.result(binding)
            File.open("#{project_dir}/docker-compose.yml", "w") do |f|
                f.write(docker_compose_output)
                f.close()
            end
            puts "docker-compose file added successfuly"

            puts "Database config found at #{config_dir}"
            config_file = File.read(config_dir)
            renderer = ERB.new(config_file)
            config_output = renderer.result(binding)

            puts "Initializing rails application..."
            Dir.chdir(project_dir) do 
                puts "Currently in #{Dir.pwd}"
                system "docker-compose run web rails new . --force -T --database=#{db_type}"
                system "docker-compose build"
                File.open("config/database.yml", "w") do |f|
                    f.write(config_output)
                    f.close()
                end
            end
        end
    end
end

