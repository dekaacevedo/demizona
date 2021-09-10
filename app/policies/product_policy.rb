class ProductPolicy < ApplicationPolicy

  def destroy?
    true
  end

  def update?
    user_owner
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_owner
    user == record.store.user
  end
end
