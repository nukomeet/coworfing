module ApplicationHelper
  def status_h(status)
    name = "info"

    case status
    when :pending
      name = "info"
    when :approved
      name = "success"
    when :rejected
      name = "important"
    else
      status.to_s
    end

    content_tag :span, status, class: "label label-#{name}"
  end

  def twitterized_type(type)
    case type
    when :alert
      "warning"
    when :error
      "error"
    when :notice
      "info"
    when :success
      "success"
    else
      type.to_s
    end
  end

  def confirm_button_with_class(name, path, confirm_text, classes, disabled=false, method=:get)
    if disabled 
      link_to(name, '#', class: classes + ' disabled')
    else
      link_to(name, path, data: { confirm: confirm_text }, class: classes, method: method)
    end
  end
  
  def invitation_status(user)
    user.invitation_accepted? ? "accepted" : "awaiting"   
  end

  def avatar_url(email, options = {})  
    width = options[:width] || 210
    default = options[:default] || "mm"
    gravatar_id = Digest::MD5::hexdigest(email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}?s=#{width}&d=#{default}"  
  end  

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn", :'data-id' => id,  :'data-fields' => fields.gsub("\n", "") )
  end

  def build_checkin_link(title, url, checkin, status)
    active = !checkin.nil? && checkin.status.to_sym == status ? 'btn btn-primary' : 'btn'
    disabled = checkin.nil? && status == :uncheck ? 'disabled' : ''

    link_to(title, url, class: "#{active} #{disabled}")
  end
end
