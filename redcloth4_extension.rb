# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class Redcloth4Extension < Radiant::Extension
  version "1.0"
  description "Enables RedCloth 4 even though RedCloth 3 is bundled with Radiant"
  
  def activate
    # Get the latest version of RedCloth
    Object.send :remove_const, :RedCloth if Object.const_defined?(:RedCloth) && RedCloth::VERSION.is_a?(String)
    $:.delete File.join(RADIANT_ROOT, 'vendor', 'redcloth', 'lib')
    gem 'RedCloth', '>= 4.0.3'
    require 'RedCloth'
  end
  
  def deactivate
  end
  
end