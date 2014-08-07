require 'spec_helper'

describe RailsDbConfigResolver::DatabaseConfig do

  describe '.from_url' do

    context 'with all fields' do

      subject { RailsDbConfigResolver::DatabaseConfig.from_url('postgres://username:password@host.com:1234/database?pool=5') }

      its(:adapter) { should eq('postgres') }
      its(:username) { should eq('username') }
      its(:password) { should eq('password') }
      its(:host) { should eq('host.com') }
      its(:port) { should eq(1234) }
      its(:database) { should eq('database') }
      its(:pool) { should eq(5) }

    end

    context 'without pool' do

      subject { RailsDbConfigResolver::DatabaseConfig.from_url('postgres://username:password@host.com:1234/database') }

      its(:adapter) { should eq('postgres') }
      its(:username) { should eq('username') }
      its(:password) { should eq('password') }
      its(:host) { should eq('host.com') }
      its(:port) { should eq(1234) }
      its(:database) { should eq('database') }
      its(:pool) { should be_nil }

    end

  end

  describe '#initialize' do

    context 'pool' do

      def create_with_pool(pool)
        RailsDbConfigResolver::DatabaseConfig.new(pool: pool)
      end

      it 'leaves integer pool as is' do
        expect(create_with_pool(5).pool).to eq(5)
      end

      it 'converts pool to integer' do
        expect(create_with_pool('5').pool).to eq(5)
      end

      it 'converts empty pool to nil' do
        expect(create_with_pool('').pool).to eq(nil)
      end

    end

  end

  describe '#merge' do

    context 'with two urls' do

      let(:config1) { RailsDbConfigResolver::DatabaseConfig.from_url('postgres://username:password@host.com/database?pool=5') }
      let(:config2) { RailsDbConfigResolver::DatabaseConfig.from_url('postgres://other-host.com/other-database?pool=10') }

      subject { config1.merge(config2) }

      its(:adapter) { should eq('postgres') }
      its(:username) { should eq('username') }
      its(:password) { should eq('password') }
      its(:host) { should eq('other-host.com') }
      its(:database) { should eq('other-database') }
      its(:pool) { should eq(10) }

    end

  end

  describe '#to_url' do

    # Here we test if DatabaseConfig.from_url(url).to_url == url

    {
        'with every field' => 'postgres://username:password@host.com:1234/database?pool=5',
        'without port' => 'postgres://username:password@host.com/database?pool=5',
        'without pool' => 'postgres://username:password@host.com:1234/database',
        'without password' => 'postgres://username@host.com:1234/database?pool=5',
        'without username and password' => 'postgres://host.com:1234/database?pool=5',
    }.each do |description, url|
      context description do
        subject { RailsDbConfigResolver::DatabaseConfig.from_url(url) }
        its(:to_url) { should eq(url) }
      end
    end

  end

end