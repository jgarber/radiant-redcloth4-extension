# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class Redcloth4Extension < Radiant::Extension
  version "1.0"
  description "Uses RedCloth 4 for textile_filter instead of RedCloth 3, which is bundled with Radiant."
  
  def activate
    unless Radiant::Version::Major.to_i <= 0 && Radiant::Version::Minor.to_i <= 6 && Radiant::Version::Tiny.to_i <= 9
      ActionController::Base.logger.warn "This version of Radiant has built-in support for RedCloth 4.  Please remove this extension to prevent problems."
    end
    
    # Get the latest version of RedCloth
    Object.send :remove_const, :RedCloth if Object.const_defined?(:RedCloth) && RedCloth::VERSION.is_a?(String)
    $:.delete File.join(RADIANT_ROOT, 'vendor', 'redcloth', 'lib')
    gem 'RedCloth', '>= 4.0.3'
    require 'RedCloth'
  end
  
  def deactivate
  end
  
end