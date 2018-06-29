require 'thor'
require_relative 'rails'

module Docko
    class Cli < Thor
        desc "rails ", "Generates a docker-compose rails app with given database"
        long_desc <<-LONGDESC
        `docko rails` will generate a ruby on rails application with the default sqlite database
        inside of a docker container. It will also generate a docker-compose.yml file.
     
        > from: Anton Bozhinov
        LONGDESC
        subcommand "rails", Rails
    end
end