class Person < ActiveRecord::Base
	after_create :add_job_detail
	after_create :add_contact_detail

	has_one :user
	has_one :job_detail
	has_one :job_title, :through => :job_detail
	has_one :department, :through => :job_detail
	has_one :location, :through => :job_detail
	has_one :contact_detail
	has_one :termination
	has_many :phone_numbers
	has_many :email_addresses
	has_many :pay_details
	has_many :reporting_relationships
	has_many :managers, :through => :reporting_relationships
	has_many :emergency_contacts
	has_many :dependents
	has_many :person_skills
	has_many :person_certifications
	has_many :person_educations
	has_many :person_languages

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :gender, presence: true, :on => :edit
	validates :date_of_birth, presence: true, :on => :edit

	accepts_nested_attributes_for :user, :reject_if => :all_blank

	def full_name
		self.preferred_first.present? ? "#{preferred_first} #{last_name}" : "#{first_name} #{last_name}"
	end

	#after the person is saved, create a job detail record with the person ID.
	def add_job_detail
		JobDetail.create(person_id: self.id, start_date: DateTime.now.to_date)
	end
	
	#after the person is saved, create a contact detail record with the person ID.
	def add_contact_detail
		ContactDetail.create(person_id: self.id)
	end

	def active?
		Termination.find_by_person_id(self.id).nil?
	end

	private
	def self.search(query)
		where("first_name ILIKE ? OR last_name ILIKE ? OR preferred_first ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
	end
end
