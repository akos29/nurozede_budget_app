class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_group, only: %i[index new create]
  before_action :authenticate_user!
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = 'You are not authorized to proceed with your request.'
    redirect_to expenses_path
  end

  def index
    @expenses = @group.expenses.where(user_id: current_user.id).order('created_at Desc')

    @total_amount = 0

    @expenses.each do |expense|
      @total_amount += expense.amount
    end
  end

  def show; end

  def new
    @expense = Expense.new(group_ids: [params[:group_id]])
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id

    @expense.name = @expense.name.capitalize

    if @expense.save
      redirect_to group_expenses_path(@group), notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @expense = Expense.find_by_id(params[:id])
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Exspence successfully updated.' }
        format.json { render :index, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      if @expense.destroy
        format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      else
        format.html { redirect_to expenses_url, notice: 'Expense was not destroyed.' }
      end
      format.json { head :no_content }
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :amount, group_ids: [])
  end
end
