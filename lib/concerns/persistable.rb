require_relative '../../config/environment.rb'

module Persistable
  module ClassMethods
    def create_table
      table_string = self::ATTRIBUTES.map do |attribute, descriptor|
        "#{attribute} #{descriptor}"
      end.join(', ')
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS #{self.table_name} (#{table_string}) 
      SQL
      self.db.execute(sql)
    end
  end

  module InstanceMethods

  end
end