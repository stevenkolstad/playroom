# == Schema Information
#
# Table name: establishment_resources
#
#  id               :bigint(8)        not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  establishment_id :bigint(8)
#  resource_id      :bigint(8)
#
# Indexes
#
#  index_establishment_resources_on_establishment_id  (establishment_id)
#  index_establishment_resources_on_resource_id       (resource_id)
#
# Foreign Keys
#
#  fk_rails_...  (establishment_id => establishments.id)
#  fk_rails_...  (resource_id => resources.id)
#

require 'test_helper'

class EstablishmentResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
