require 'thor'

module DockerizeRails
    class Cli < Thor
        desc "with DB_NAME", "Generates a docker-compose rails app with given database"
        def with db_name
            puts "Generate docker-compose for Rails with #{db_name}"
        end
        
    end
end