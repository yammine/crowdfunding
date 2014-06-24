class EmailFormatValidator < ActiveModel::EachValidator

  EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  def validate_each(object, attribute, value)
    unless value =~ EMAIL_REGEX
      object.errors[attribute] << (options[:message] || "not formatted properly")
    end
    object.errors
  end


end