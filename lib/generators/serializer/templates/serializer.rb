class <%= serializer_name %>Serializer
  attributes <% attributes.each_with_index do |attr, index| -%>:<%= attr %><%= (index != attributes.count - 1) ? ',' : '' %> <% end %>
end