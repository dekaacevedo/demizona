class ProductPolicy < ApplicationPolicy

  def destroy?
    true
  end

  def update?
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
