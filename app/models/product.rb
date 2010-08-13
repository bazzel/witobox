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
  validates_attachment_presence :photo, :message => I18n.t('activerecord.errors.messages.photo_file_name')
  validates_attachment_size :photo, :less_than => 2.megabytes, 
                                    :message => I18n.t('activerecord.errors.messages.photo_file_size')
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/pjpeg', 'image/x-png'],
                                            :message => I18n.t('activerecord.errors.messages.photo_content_type')
  validates_numericality_of :amount, :greater_than_or_equal_to => 0
  validate :consolidate_photo_validations
  
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
  
  def amount
    return unless cents
    cents.to_f / 100
  end
  
  def amount=(value)
    self.cents = "#{value}".gsub(/,/, '.').to_f * 100
  end
  
  def to_s
    name
  end
  
  private
  
  def reprocess_photo
    photo.reprocess!
  end
  
  # Needed for validating amount attribute.
  def amount_before_type_cast
    @amount
  end
    
  # Put the first of the validation errors on photo (photo_file_name, photo_file_size, photo_content_type)
  # so they will be displayed with the photo form element in the view.
  def consolidate_photo_validations

    [:photo_file_name, :photo_file_size, :photo_content_type].each do |name|
      if (err = errors.on(name))
        errors.add(:photo, err)
        break
      end
    end
    
  end

end
