class Product < ActiveRecord::Base
  has_attached_file :photo, :convert_options => { :all => "-strip" }, 
                            :styles => {
                              :crop => ["500x500>", :jpg], 
                              :big => ["470x470>", :jpg], 
                              :small => ["198x146!", :jpg]
                            },
                            :processors => [:cropper]

  # === Validations
  #
  validates_presence_of :name
  validates_presence_of :description
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  # === Named scopes
  #
  named_scope(:for_sale, :conditions => {:sold => false})
  
  # === Callbacks
  #
  after_update :reprocess_photo, :if => :cropping?

  # === Instance Methods
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
  
  private
  
  def reprocess_photo
    photo.reprocess!
  end
end
