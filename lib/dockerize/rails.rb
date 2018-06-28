require 'thor'

module Dockerize
    class Rails < Thor
        desc "with <db_name>", "Creates docker-compose rails app with given database name"
        long_desc <<-LONGDESC
        `dockerize <module> with <db_name>` will generate ruby on rails application and will connect it
        to a given database.
        Example:
        $ dockerize rails with postgresql
     
        > from: Anton Bozhinov
        LONGDESC
        def with(db_name)
            puts "Generating rails aplication with #{db_name} as a database..."
        end
        
    end
    
end