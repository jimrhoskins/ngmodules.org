module PackageHelper
  def uses(user, package)
    user and user.uses.find_by_package_id(package.id)
  end
end
