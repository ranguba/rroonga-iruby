# Copyright (C) 2017  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

require "erector"

module RroongaIRuby
  module Record
    class TableWidget < Erector::Widget
      def initialize(record)
        columns = record.columns
        n_columns = 1  # _id
        n_columns += 1 if record.support_key?
        n_columns += columns.size
        super(:table => record.table,
              :record => record,
              :columns => columns,
              :n_columns => n_columns,
              :size => 1)
      end

      def content
        table do
          thead do
            tr do
              th(:colspan => @n_columns) do
                text "#{@table.name}(#{@table.class.name})"
              end
            end
            tr do
              th do
                text "_id"
              end
              if @record.support_key?
                th do
                  text "_key"
                end
              end
              @columns.each do |column|
                th do
                  text "#{column.local_name}(#{column.range.name})"
                end
              end
            end
          end

          tbody do
            tr do
              td do
                text @record.id
              end
              if @record.support_key?
                td do
                  text @record.key
                end
              end
              @columns.each do |column|
                td do
                  value = @record[column.local_name]
                  value = value.record_id if value.is_a?(Groonga::Record)
                  text value
                end
              end
            end
          end
        end
      end
    end

    def to_html
      TableWidget.new(self).to_html
    end
  end
end
