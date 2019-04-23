# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    alias_action :create, :read, :update, :destroy, :delete, to: :crud

    can(:crud, Idea) do |idea|
      idea.user == user
    end

    can :crud, Review do |rev|
      rev.user == user || rev.idea.user == user
    end

    can :like, Idea do |idea|
      user.persisted? && idea.user != user
    end
  end
  
end
