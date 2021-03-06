class TextAssetFilter
  include Simpleton
  include Annotatable
  
  annotate :filter_name
   
  def filter(text)
    text
  end
  
  class << self
    def inherited(subclass)
      subclass.filter_name = subclass.name.to_name('Filter')
    end
    
    def filter(text)
      instance.filter(text)
    end
  end
end