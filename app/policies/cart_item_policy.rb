class CartItemPolicy < ApplicationPolicy

  def update?
    true
  end

  def destroy?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
