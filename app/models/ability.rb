class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    user ||= User.new # guest user (not logged in)
    can :read, Expense
    can :read, Group
    can(:manage, Group, user:)
    can :manage, Expense, user:
  end
end
