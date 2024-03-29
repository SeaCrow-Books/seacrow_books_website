# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.staff?
        scope.where(author: user) # or another scope according to your business logic
      else
        scope.none
      end
    end

    private

    attr_reader :user, :scope
  end

  private

  def admin?
    user&.admin?
  end

  def staff?
    user&.staff?
  end
end
