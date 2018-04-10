module Antecedent
  ASSOCIATION = ActiveRecord::Associations::BelongsToPolymorphicAssociation

  def self.disable_sti
    ASSOCIATION.class_eval do
      alias _klass klass

      def klass
        type = owner[reflection.foreign_type]
        type.presence && type.constantize.base_class
      end
    end

    ActiveRecord::Base.inheritance_column = :_type_disabled
  end

  def self.enable_sti
    ASSOCIATION.class_eval do
      if defined?(_klass)
        alias klass _klass
      end
    end

    ActiveRecord::Base.inheritance_column = :type
  end
end
