module Antecedent
  ASSOCIATION = ActiveRecord::Associations::BelongsToPolymorphicAssociation

  def self.disable_sti
    ASSOCIATION.class_eval do
      alias _klass klass

      def klass
        type = owner[reflection.foreign_type]
        type.presence && type_base_class(type)
      end

      private

      def type_base_class(type)
        type.constantize.base_class
      rescue NameError
        # if type class does not exist try
        # removing namespace
        type.deconstantize.constantize
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
