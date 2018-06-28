require 'thor'

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

        end
        
    end
    
end
