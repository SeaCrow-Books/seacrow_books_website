
class ImageResourcePolicy < ApplicationPolicy

  def index?
      user&.admin? || user&.staff?
  end

  def show?
      user&.admin? || user&.staff?
  end

  def create?
      user&.admin? || user&.staff?
  end

  def destroy?
    user&.admin?
  end

  def update?
    user&.admin? || user&.staff?
  end

  def permanent_image?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
