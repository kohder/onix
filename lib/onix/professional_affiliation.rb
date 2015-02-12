# coding: utf-8

module ONIX
  class ProfessionalAffiliation
    include ROXML

    xml_name "ProfessionalAffiliation"

    xml_accessor :professional_position, :from => "ProfessionalPosition"
    xml_accessor :affiliation,           :from => "Affiliation"
  end
end
