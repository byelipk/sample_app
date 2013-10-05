# == Schema Information
#
# Table name: email_verifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  code        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active_link :boolean          default(TRUE)
#

require 'spec_helper'

describe EmailVerification do
  pending "add some examples to (or delete) #{__FILE__}"
end
