require 'minitest_helper'

describe Use do
  before do
    Use.delete_all
  end

  it 'allows only one user per project' do
    u1 = Use.create package_id: 1, user_id: 2
    u1.save.must_equal true

    u2 = Use.create package_id: 1, user_id: 2
    u2.save.must_equal false
  end

  it 'requires a user and package' do
    use = Use.new
    use.save.must_equal false
    use.errors[:user_id].wont_be_empty
    use.errors[:package_id].wont_be_empty
  end

  it 'belongs to a user and package' do
    use = Use.new
    use.must_respond_to :user
    use.must_respond_to :user=
    use.must_respond_to :package
    use.must_respond_to :package=
  end

end
