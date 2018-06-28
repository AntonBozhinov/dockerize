require 'thor'

module DockerizeRails
    class Cli < Thor
        desc "with DB_NAME", "Generates a docker-compose rails app with given database"
        def with DB_NAME
            puts "Generate docker-compose for Rails with #{DB_NAME}"
        end
        
    end
end