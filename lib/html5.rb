module ActionView
  module Helpers

    module Html5FormTagHelper
      
      # Creates a text field of type "search".
      #
      # ==== Options
      # * Accepts the same options as text_field_tag.
      def search_field_tag(name, value = nil, options = {})
        text_field_tag(name, value, options.stringify_keys.update("type" => "search"))
      end

      # Creates a text field of type "tel".
      #
      # ==== Options
      # * Accepts the same options as text_field_tag.
      def telephone_field_tag(name, value = nil, options = {})
        options.merge!( :size=>15) unless options.stringify_keys.key?('size')
        text_field_tag(name, value, options.stringify_keys.update("type" => "tel"))
      end
      alias phone_field_tag telephone_field_tag
      
      # Creates a text field of type "url".
      #
      # ==== Options
      # * Accepts the same options as text_field_tag.
      def url_field_tag(name, value = nil, options = {})
        text_field_tag(name, value, options.stringify_keys.update("type" => "url"))
      end
      
      # Creates a text field of type "email".
      #
      # ==== Options
      # * Accepts the same options as text_field_tag.
      def email_field_tag(name, value = nil, options = {})
        text_field_tag(name, value, options.stringify_keys.update("type" => "email"))
      end

      # Creates a number field.
      #
      # ==== Options
      # * <tt>:min</tt> - The minimum acceptable value.
      # * <tt>:max</tt> - The maximum acceptable value.
      # * <tt>:in</tt> - A range specifying the <tt>:min</tt> and
      #   <tt>:max</tt> values.
      # * <tt>:step</tt> - The acceptable value granularity.
      # * Otherwise accepts the same options as text_field_tag.
      #
      # ==== Examples
      #   number_field_tag 'quantity', nil, :in => 1...10
      #   => <input id="quantity" name="quantity" min="1" max="9" />
      def number_field_tag(name, value = nil, options = {})
        options = options.stringify_keys
        options["type"] ||= "number"
        if range = options.delete("in") || options.delete("within")
          options.update("min" => range.min, "max" => range.max)
        end
        text_field_tag(name, value, options)
      end

      # Creates a range form element.
      #
      # ==== Options
      # * Accepts the same options as number_field_tag.
      def range_field_tag(name, value = nil, options = {})
        number_field_tag(name, value, options.stringify_keys.update("type" => "range"))
      end

    end
  
    module Html5FormHelper
      # Returns a text_field of type "search".
      def search_field(object_name, method, options = {})
        options = options.stringify_keys

        if options["autosave"]
          if options["autosave"] == true
            options["autosave"] = request.host.split(".").reverse.join(".")
          end
          options["results"] ||= 10
        end

        if options["onsearch"]
          options["incremental"] = true unless options.has_key?("incremental")
        end

        InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("search", options)
      end

      # Returns a text_field of type "tel".
      def telephone_field(object_name, method, options = {})
        options.merge!( :size=>15) unless options.stringify_keys.key?('size')
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("tel", options)
      end
      alias phone_field telephone_field

      # Returns a text_field of type "url".
      def url_field(object_name, method, options = {})
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("url", options)      
      end
      
      # Returns a text_field of type "email".
      def email_field(object_name, method, options = {})
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("email", options)
      end

      # Returns an input tag of type "number".
      #
      # ==== Options
      # * Accepts same options as number_field_tag
      def number_field(object_name, method, options = {})
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_number_field_tag("number", options)
      end

      # Returns an input tag of type "range".
      #
      # ==== Options
      # * Accepts same options as range_field_tag
      def range_field(object_name, method, options = {})
        InstanceTag.new(object_name, method, self, options.delete(:object)).to_number_field_tag("range", options)
      end

    end
  
    class InstanceTag
      def to_number_field_tag(field_type, options = {})
        options = options.stringify_keys
        if range = options.delete("in") || options.delete("within")
          options.update("min" => range.min, "max" => range.max)
        end
        to_input_field_tag(field_type, options)
      end
    end

    class FormBuilder
      # Extend search_field
      def search_field(method, options = {})
        @template.search_field(@object_name, method, objectify_options(options))
      end

      # Extend telephone_field
      def telephone_field(method, options = {})
        @template.telephone_field(@object_name, method, objectify_options(options))
      end
      alias phone_field telephone_field

      # Extend url_field
      def url_field(method, options = {})
        @template.url_field(@object_name, method, objectify_options(options))
      end
      
      # Extend email_field
      def email_field(method, options = {})
        @template.email_field(@object_name, method, objectify_options(options))
      end

      # Extend number_field
      def number_field(method, options = {})
        @template.number_field(@object_name, method, objectify_options(options))
      end

      # Extend number_field
      def range_field(method, options = {})
        @template.range_field(@object_name, method, objectify_options(options))
      end
    end

  end
end