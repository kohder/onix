# coding: utf-8

module ONIX
  class PersonDate
    include ROXML

    xml_name "PersonDate"

    xml_accessor :person_date_role, :from => "PersonDateRole", :as => Fixnum
    xml_accessor :date_format,      :from => "DateFormat", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :date,             :from => "Date"
  end
end
