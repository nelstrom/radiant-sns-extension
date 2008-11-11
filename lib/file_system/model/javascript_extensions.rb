module FileSystem::Model::JavascriptExtensions
  
  def self.included(base)
    base.class_eval do
      puts "loading javascript extensions"
      extend ClassMethods
    end
  end
  
  module ClassMethods
    def klass_name
      "Javascript"
    end
  end
  
  def filename
    @filename ||= returning String.new do |output|
      basename = self.name
      extension = case 
        when respond_to?(:filter_id)
          self.filter_id.blank? ? default_content_type : self.filter_id.downcase
        when respond_to?(:content_type)
          CONTENT_TYPES.invert[self.content_type] || default_content_type
        else
          default_content_type
      end
      minify = case
        when respond_to?(:minify) 
          self.minify ? "min" : nil
        else nil
      end
      output << File.join(self.class.path, 
                          [basename, minify, extension].compact.join("."))
    end
  end
  
  private
    def default_content_type
      "js"
    end
  
end