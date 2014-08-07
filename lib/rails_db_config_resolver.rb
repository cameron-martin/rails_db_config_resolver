require 'rails_db_config_resolver/version'
require 'rails_db_config_resolver/database_config'

require 'erb'
require 'yaml'
require 'uri'

class RailsDbConfigResolver

  def initialize(file, env_url, rails_env)
    @file = file
    @env_url = env_url
    @rails_env = rails_env
  end

  def parse
    merged_config.to_hash
  end

private

  def merged_config
    if @env_url
      file_config.merge(env_url_config)
    else
      file_config
    end
  end

  def env_url_config
    DatabaseConfig.from_url(@env_url)
  end

  def file_config
    DatabaseConfig.from_hash(file_config_hash)
  end

  def file_config_hash
    symbolize_keys(YAML.load(rendered_yaml)[@rails_env])
  end

  def raw_yaml
    File.read(@file)
  end

  def rendered_yaml
    ERB.new(raw_yaml).result
  end

  def symbolize_keys(hash)
    Hash[hash.map { |k, v| [k.to_sym, v] }]
  end

end
