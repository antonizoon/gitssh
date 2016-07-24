require 'spec_helper'

describe 'gitssh' do
  let!(:stdlib_stubs) do
    MockFunction.new('size') do |f|
      f.stubbed.with([]).returns(0)
    end
  end

  context 'with defaults for all parameters' do
    it do
      should contain_class('gitssh').with('basedir' => '/var/git',
                                          'package_ensure' => 'present',
                                          'package_name'   => 'git',
                                          'purge_ssh_keys' => 'true')
    end

    it do
      should contain_package('git').with('ensure' => 'present')
    end

    it do
      should contain_user('git').with('home' => '/var/git',
                                      'purge_ssh_keys' => true)
    end

    it do
      should contain_exec('/bin/echo /usr/bin/git-shell >> /etc/shells')
    end
  end
end