# original: https://github.com/activescaffold/active_scaffold/blob/master/lib/active_scaffold/helpers/id_helpers.rb
module ActiveScaffold::Helpers
  module IdHelper
    def nested?
      false
    end

    def id_from_controller(controller)
      controller.to_s.gsub("/", "__") # .html_safe
    end

    def controller_id(controller = nil)
      # TODO: nested
      controller ||= params["eid"]? || params["parent_controller"]? || params["controller"]? || controller_name
      "as_" + id_from_controller(controller)
    end

    def nested_id
      "#{nested.parent_scaffold.controller_path}-#{nested.parent_id}-#{params["controller"]}" if nested?
    end

    def active_scaffold_id
      "#{controller_id}-active-scaffold"
    end

    def active_scaffold_content_id
      "#{controller_id}-content"
    end

    def active_scaffold_tbody_id
      "#{controller_id}-tbody"
    end

    def active_scaffold_messages_id(options = nil)
      options ||= Hash(String, String).new
      id = options["controller_id"]? || controller_id
      "#{id}-messages"
    end

    def active_scaffold_calculations_id(options = nil)
      options ||= Hash(String, String).new
      id = options["controller_id"]? || controller_id
      suffix = options["column"].try{|c| "-#{c.name}"}
      "%s-calculations%s" % [id, suffix]
    end

    def empty_message_id
      "#{controller_id}-empty-message"
    end

    def before_header_id
      "#{controller_id}-search-container"
    end

    def search_input_id
      "#{controller_id}-search-input"
    end

    def action_link_id(link_action, link_id)
      "#{controller_id}-#{link_action}-#{link_id}-link"
    end

    def active_scaffold_column_header_id(column)
      name = column.respond_to?(:name) ? column.name : column.to_s
      clean_id "#{controller_id}-#{name}-column"
    end

    def element_row_id(options = nil)
      options ||= Hash(String, String).new
      options["action"] ||= params["action"] if params["action"]?
      options["id"] ||= params["id"] if params["id"]?
      options["id"] ||= params["parent_id"] if params["parent_id"]?
      clean_id "#{options["controller_id"]? || controller_id}-#{options["action"]}-#{options["id"]}-row"
    end

    def element_cell_id(options = nil)
      options ||= Hash(String, String).new
      options["action"] ||= params["action"]
      options["id"] ||= params["id"]
      options["id"] ||= params["parent_id"]
      options["name"] ||= params["name"]
      clean_id "#{controller_id}-#{options["action"]}-#{options["id"]}-#{options["name"]}-cell"
    end

    def element_form_id(options = nil)
      options ||= Hash(String, String).new
      options["action"] ||= params["action"]
      options["id"] ||= params["id"]
      options["id"] ||= params["parent_id"]
      clean_id "#{controller_id}-#{options["action"]}-#{options["id"]}-form"
    end

    def association_subform_id(column)
      klass = column.association.klass.to_s.underscore
      clean_id "#{controller_id}-associated-#{klass}"
    end

    def loading_indicator_id(options = nil)
      options ||= Hash(String, String).new
      options["action"] ||= params["action"]
      clean_id "#{controller_id}-#{options["action"]}-#{options["id"]}-loading-indicator"
    end
    
    def sub_section_id(options = nil)
      options ||= Hash(String, String).new
      options["id"] ||= params["id"]
      options["id"] ||= params["parent_id"]
      clean_id "#{controller_id}-#{options["id"]}-#{options["sub_section"]}-subsection"
    end

    def sub_form_id(options = nil)
      options ||= Hash(String, String).new
      options["id"] ||= params["id"]
      options["id"] ||= params["parent_id"]
      clean_id "#{controller_id}-#{options["id"]}-#{options["association"]}-subform"
    end
    
    def sub_form_list_id(options = nil)
      options ||= Hash(String, String).new
      options["id"] ||= params["id"]
      options["id"] ||= params["parent_id"]
      clean_id "#{controller_id}-#{options["id"]}-#{options["association"]}-subform-list"
    end

    def element_messages_id(options = nil)
      options ||= Hash(String, String).new
      options["action"] ||= params["action"]
      options["id"] ||= params["id"]
      options["id"] ||= params["parent_id"]
      clean_id "#{controller_id}-#{options["action"]}-#{options["id"]}-messages"
    end

    def action_iframe_id(options)
      "#{controller_id}-#{options["action"]}-#{options["id"]}-iframe"
    end
    
    def scope_id(scope)
      scope.gsub(/(\[|\])/, "_").gsub("__", "_").gsub(/_$/, "")
    end

    # whitelists id-safe characters
    private def clean_id(val)
      val.gsub /[^-_0-9a-zA-Z]/, "-"
    end
  end

  include IdHelper
end
