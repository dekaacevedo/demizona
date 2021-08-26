class CartItemPolicy < ApplicationPolicy

  def update?
    true
  end

  def destroy?
    true
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
