module ActiveScaffold::Helpers
  module PathHelper
    def main_path_to_return
      if v = params["return_to"]?
        v
      else
#        parameters = {}
#        if params["parent_controller"]
#          parameters[:controller] = params["parent_controller"]
        #        end
        "/"
      end
    end

    def resolve_url(config, link, record) : String
      resolve_url(link.url, ->{ record_id(config, record) })
    end

    def resolve_url(url : String, id_builder = nil) : String
      id_builder ||= ->{ raise "URL ERROR: cannot resolve ':id' (#{url})"}
      url.gsub(/:([a-z]+)\b/) {
        case $1.to_s
        when "controller" ; controller_name
        when "action"     ; action_name
        when "id"         ; id_builder.call
        else
          raise "url contains unknown parameter: ':#{$1}' (#{url})"
        end
      }
    end
  end

  include PathHelper
end
