class User < ApplicationRecord
  validates_uniqueness_of :email
  paginates_per 3

  searchkick word_middle: [:firstname, :lastname, :email], case_sensitive: false

  def search_data
    {
      firstname: firstname,
      lastname: lastname,
      email: email,
    }
  end
end
