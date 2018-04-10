require "antecedent/version"
require "active_record"

if ActiveRecord::VERSION::STRING =~ /^5\./
  require "antecedent/active_record_5"
else
  require "antecednt/fallback"
end

