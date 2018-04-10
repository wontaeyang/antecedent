module Antecedent
  def self.disable_sti
    raise_version_error
  end

  def self.enable_sti
    raise_version_error
  end

  private

  def self.raise_version_error
    raise Antecedent::ActiveRecordVersionNotSupported.new(
      "ActiveRecord version not supported"
    )
  end
end

class Antecedent::ActiveRecordVersionNotSupported < StandardError;end
