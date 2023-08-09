class GroupExpense < ApplicationController
  belongs_to :group
  belongs_to :expense
end