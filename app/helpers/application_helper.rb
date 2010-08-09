# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def button_tag(value = "Submit", options = {}, &block)
    default_options = {
      :type => 'submit'
    }
    options = default_options.merge(options)
    button = content_tag(:button, value, options)

    if block_given?
      concat(button + capture(&block))
    else
      button
    end
  end
  
  def submit_tag(value = t('buttons.submit'), options = {})
    button_tag value, options.merge(:class => 'positive')
  end
  
  def cancel_link(value = t('buttons.cancel'), url = :back, options = {})
    link_to value, url, options.merge(:class => 'negative')
  end
end
