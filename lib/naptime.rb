require "naptime/version"
require 'json'

module Naptime
  class REST

    @@crud = {
      'Create' => {
        'http' => 'POST',
        'return' => 'id',
        'requires' => false,
        'body' => true
      },
      'Read' => {
        'http' => 'GET',
        'return' => false,
        'requires' => 'id',
        'body' => false
      },
      'Update' => {
        'http' => 'POST',
        'return' => false,
        'requires' => 'id',
        'body' => true
      },
      'Delete' => {
        'http' => 'DELETE',
        'return' => false,
        'requires' => 'id',
        'body' => false
      }
    }

    def initialize(fileName)

      @rest = Hash.new
      @restPath = Hash.new

      file = File.open(fileName, "rb")

      self.traverse(File.basename(fileName,".*"), JSON.parse(file.read), '/')

    end

    def traverse(noun, desc, path)

      @rest[noun.to_sym] = Hash.new
      @restPath[noun.to_sym] = Hash.new
      @restPath[noun.to_sym]['path'] = path

      desc.each do |x,y|
        if y.respond_to?('each')
          self.traverse(x, y, path + noun + '/[id]/')
        else
          @rest[noun.to_sym][x] ||= y
        end
      end

    end

    def output

      @rest.each do |noun, payload|

        @@crud.each do |action, info|
          path = @restPath[noun]['path'] + noun.to_s
          id = info['requires'] == 'id' ? '/[id]' : ''

          apiUri = "#{info['http']} #{path}#{id}\n"
          apiPayload = payload.to_json + "\n" if info['body']

          print apiUri
          print apiPayload
          print "\n"

        end
      end
    end
  end
end
