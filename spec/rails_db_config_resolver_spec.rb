require 'spec_helper'

SPEC_ROOT = __dir__
DB_FILE = File.join(SPEC_ROOT, 'support', 'database.yml')

describe RailsDbConfigResolver do

  context 'with full database file, and partial env variable' do

    subject { RailsDbConfigResolver.new(DB_FILE, 'sqlite://env-host.com/env_database', 'production') }

    its(:parse) { should eq(
                            adapter:  'sqlite',
                            database: 'env_database',
                            pool:     5,
                            username: 'file_username',
                            password: 'file_password',
                            host:     'env-host.com',
                            port:     1234
    ) }

  end

end