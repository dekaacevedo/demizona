class StorePolicy < ApplicationPolicy

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    user_owner
  end

  def update?
    user_owner
  end

  def admin?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_owner
    user == record.user
  end

end
