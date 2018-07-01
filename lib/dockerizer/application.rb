require 'thor'

module Dockerizer
    class Application < Thor
        def with(db_type)
            raise NotImplementedError, "You must implement with(db_type) method!"
        end
    end
end