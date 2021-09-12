class OrderPolicy < ApplicationPolicy

  def create?
    true
  end

  def show?
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
end
