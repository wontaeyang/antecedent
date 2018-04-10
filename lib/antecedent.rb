require "antecedent/version"
require "active_record"

if ActiveRecord::VERSION::STRING =~ /^5\.2/
  require "antecedent/active_record_5_2"
else
  require "antecednt/fallback"
end

