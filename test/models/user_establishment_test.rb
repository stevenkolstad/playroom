# == Schema Information
#
# Table name: user_establishments
#
#  id               :bigint(8)        not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  establishment_id :bigint(8)
#  user_id          :bigint(8)
#
# Indexes
#
#  index_user_establishments_on_establishment_id  (establishment_id)
#  index_user_establishments_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (establishment_id => establishments.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class UserEstablishmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
