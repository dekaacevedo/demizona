class StorePolicy < ApplicationPolicy

  def show?
    true
  end

  def create?
    seller_user
  end

  def destroy?
    user_owner
  end

  def update?
    user_owner
  end

  def admin?
    user_owner
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

  def seller_user
    if record.user.seller?
      user == record.user
    end
  end

end
