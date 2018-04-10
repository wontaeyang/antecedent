source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in antecedent.gemspec
gemspec

group :test do
  gem 'activerecord', '~> 5.2'
  gem 'pg', '~> 1.0'
  gem 'standalone_migrations', '~> 5.2', '>= 5.2.5'
end
